(function($) {

	$.fn.babble = function(custom_settings) {
		return {

			placeholder : null,
			request : null,
			list : null,
			queue : null,
			latest : null,
			settings : {
				username : ["sheilaellen"],
				avatar_size : null,
				count : 3,
				messages : {
					fetching : "Fetching tweets...",
					loading : "...loading tweets,"
				},
				delay : 20,
				query : null,
				running : false
			},
			init : function() {

				// Determine settings
				this.configure();

				// Build request
				this.request = this.formulate_request();


			},
			configure : function() {

				// Merge the default settings with any custom ones supplied
				if(custom_settings) {
					this.settings = $.extend(this.settings, custom_settings);
				}

				this.autoAdjust();

			},
			autoAdjust : function() {

				/*
				 * Auto-adjust height of tweet stream
				 */

				var pane = $(".tweets");

				// Determine the height of relevant elements
				var currPaneTop = $(pane).position().top;
				var windowHeight = $(window).height();
				var documentHeight = $(document).height();

				// Calculate a potential new height for the pane
				var spaceHeight = windowHeight;
				if(documentHeight > spaceHeight) {
					spaceHeight = documentHeight;
				}
				var spareBodySpace = spaceHeight - currPaneTop;

				// If there's space, reposition the pane
				if(spareBodySpace > 0) {
					var newPaneHeight = spareBodySpace + "px";
					$(pane).css("height", newPaneHeight);
				}

			},
			notify : function(message) {

				/*
				 * Display a status message to the user
				 */

				if(message) {

					// Remove current status
					$(".status").remove();

					// Display new status
					var element = $('<p class="status">' + message + '</p>');
					$(this.placeholder).append(element);

					// Return newly displayed status element
					return element;
				}

				// No message to display
				return null;

			},
			formulate_request : function() {

				/*
				 * Build the request that will be sent to Twitter
				 */

				var query = '';
				if(this.settings.query !== null) {
					query += 'q=' + this.settings.query;
				}
				query += '&q=from:' + this.settings.username;
						
				var request = 'http://search.twitter.com/search.json?' + query + '&rpp=' + this.settings.count + '&callback=?'; 										
								
				return request;

			},
			fetch : function() {

				setTimeout("babbler.fetch()", 25000);

				/*
				 * Fetch the latest tweets from Twitter
				 */

				var babbler = this;

				// Update display
				var element = this.notify(this.settings.messages.fetching);

				// Submit request to Twitter
				$.getJSON(this.request, function(data) {

					// Process and display the response
					babbler.display(babbler.process_response(data));								

				});
								
			},
			process_response : function(data) {

				/*
				 * Parse the response returned from Twitter
				 */

				var babbler = this;

				// Update display
				var element = this.notify(this.settings.messages.loading);

				// Create a container for the marked-up tweets
				var tweets = Array();

				// HTML Template for each individual tweet
				var populate_template = function(item) {

					$.fn.extend({
						linkUrl : function() {
							var returning = [];
							var regexp = /((ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?)/gi;
							this.each(function() {
								returning.push(this.replace(regexp, "<a href=\"$1\">$1</a>"));
							});
							return $(returning);
						},
						linkUser : function() {
							var returning = [];
							var regexp = /[\@]+([A-Za-z0-9-_]+)/gi;
							this.each(function() {
								returning.push(this.replace(regexp, "<a href=\"http://twitter.com/$1\">@$1</a>"));
							});
							return $(returning);
						},
						linkHash : function() {
							var returning = [];
							var regexp = / [\#]+([A-Za-z0-9-_]+)/gi;
							this.each(function() {
								returning.push(this.replace(regexp, ' <a href="http://search.twitter.com/search?q=&tag=$1&lang=all&from=' + babbler.settings.username + "%2BOR%2B" + '">#$1</a>'));
							});
							return $(returning);
						}
					});

					// Takes in a timestamp and returns a phrase
					// indicative of how long ago the tweet was sent
					var relative_time = function(time_value) {
						var parsed_date = Date.parse(time_value);
						var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
						var delta = parseInt(((relative_to.getTime() - parsed_date) / 1000), 10);
						if(delta < 60) {
							return 'less than a minute ago';
						} else if(delta < 120) {
							return 'about a minute ago';
						} else if(delta < (45 * 60)) {
							return (parseInt((delta / 60), 10)).toString() + ' minutes ago';
						} else if(delta < (90 * 60)) {
							return 'about an hour ago';
						} else if(delta < (24 * 60 * 60)) {
							return 'about ' + (parseInt((delta / 3600), 10)).toString() + ' hours ago';
						} else if(delta < (48 * 60 * 60)) {
							return '1 day ago';
						} else {
							return (parseInt((delta / 86400), 10)).toString() + ' days ago';
						}
					};
					var avatar_template = '<p class="avatar"><a href="http://twitter.com/' + item.from_user + '"><img src="' + item.profile_image_url + '" height="' + babbler.settings.avatar_size + '" width="' + babbler.settings.avatar_size + '" alt="' + item.from_user + '\'s avatar" border="0"/></a></p>';
					var avatar = (babbler.settings.avatar_size ? avatar_template : '');
					var tweeter = '<span class="tweeter">' + item.from_user + '</span>';
					var delimiter = '<span class="delimiter">: </span>';
					var when = '<p class="when"><a href="http://twitter.com/' + item.from_user + '/statuses/' + item.id + '" title="view tweet on twitter">' + relative_time(item.created_at) + '</a></p>';
					var text = '<span class="body">' + $([item.text]).linkUrl().linkUser().linkHash()[0] + '</span>';
					var message = '<p class="message">' + tweeter + delimiter + text + '</p>';
					var tweet_html = '<li class="tweet">' + avatar + message + when + '</li>';
					return tweet_html;

				};
				// Process the JSON returned from Twitter
				$.each(data.results, function(i, item) {

					// Populate tweet template
					// var tweet = [item.created_at, populate_template(item)];
					var tweet = populate_template(item);					

					// Add the marked-up tweet to the container
					tweets.push(tweet);

				});
				return tweets;

			},
			display : function(tweets) {			
				
				var babbler = this;

				// Create html list element
				if(this.list === null) {
					this.list = $('<ul>').appendTo($(this.placeholder));
				}

				// Remove current status
				$(".status").remove();

				for(var i = tweets.length - 1; i >= 0; i--) {

					// Add the marked-up tweet to the list
					var tweet = tweets[i];
					$(tweet).css("display", "none");

					this.list.prepend(tweet);

					$(tweet).fadeIn("slow");

				}
			
			},
			run : function(placeholder) {
				this.placeholder = placeholder;
				this.init();
				this.fetch();
			}
		};
	};
})(jQuery);
