(function($) {

	$.fn.babble = function(custom_settings) {		

		// Configuration
		var settings = {
			username : ["sheilaellen"], // [string]   required, unless you want to display our tweets. :) it can be an array, just do ["username1","username2","etc"]
			avatar_size : null, // [integer]  height and width of avatar if displayed (48px max)
			count : 3, // [integer]  how many tweets to display?
			intro_text : null, // [string]   do you want text BEFORE your your tweets?
			outro_text : null, // [string]   do you want text AFTER your tweets?
			messages : {
				fetching : "Fetching tweets...", // [string]   optional loading text, displayed while tweets load
				loading : "...loading tweets," // [string]   optional loading text, displayed while tweets load
			},
			delay : 20, // [integer]  the interval to leave between calls to Twitter to refresh the stream
			query : null, // [string]   optional search query
			running : false
		};

		// Properties
		var placeholder = null;
		var request = null;
		var list = null;

		// Methods
		var init = function() {

			// Determine settings
			configure();

			// Build request
			request = formulate_request();
			

		}, configure = function() {

			// Merge the default settings with any custom ones supplied
			if(custom_settings) {
				this.settings = $.extend(settings, custom_settings);
			}
			
			// Auto-adjust height
			var autoAdjust = function() {		
			
				var pane = $(".tweets");		
				
				// Determine the height of relevant elements	
				var currPaneTop = $(pane).position().top;
				var windowHeight = $(window).height();				
				var documentHeight = $(document).height();							
				
				// Calculate a potential new height for the pane		
				var spaceHeight = windowHeight;
				if (documentHeight > spaceHeight) {
					spaceHeight = documentHeight;
				}								
				var spareBodySpace = spaceHeight - currPaneTop;															
										
				// If there's space, reposition the pane
				if (spareBodySpace > 0) {
					var newPaneHeight = spareBodySpace + "px";
					$(pane).css("height", newPaneHeight);							
				}															
			};
			autoAdjust();

		}, notify = function(message) {

			// Add new status
			if(message) {

				// Remove current status
				$(".status").remove();

				// Display new status
				var element = $('<p class="status">' + message + '</p>');
				$(placeholder).append(element);

				// Return newly displayed status element
				return element;
			}

			// No message to display
			return null;

		}, formulate_request = function() {

			var query = '';
			if(settings.query) {
				query += 'q=' + settings.query;
			}
			query += '&q=from:' + settings.username + '%20OR%20from:';
			return 'http://search.twitter.com/search.json?&' + 'q=bcl9' + '&rpp=' + settings.count + '&callback=?';

		}, fetch = function() {

			// Update display
			var element = notify(settings.messages.fetching);

			// Submit request to Twitter
			$.getJSON(request, function(data) {

				// Process and display the response
				display(process_response(data));

			});
		}, process_response = function(data) {

			// Update display
			var element = notify(settings.messages.loading);

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
							returning.push(this.replace(regexp, ' <a href="http://search.twitter.com/search?q=&tag=$1&lang=all&from=' + settings.username + "%2BOR%2B" + '">#$1</a>'));
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

				var avatar_template = '<p class="avatar"><a href="http://twitter.com/' + item.from_user + '"><img src="' + item.profile_image_url + '" height="' + settings.avatar_size + '" width="' + settings.avatar_size + '" alt="' + item.from_user + '\'s avatar" border="0"/></a></p>';
				var avatar = (settings.avatar_size ? avatar_template : '');
				var tweeter = '<span class="tweeter">' + item.from_user + '</span>';
				var delimiter = '<span class="delimiter">: </span>';
				var date = '<p class="when"><a href="http://twitter.com/' + item.from_user + '/statuses/' + item.id + '" title="view tweet on twitter">' + relative_time(item.created_at) + '</a></p>';
				var text = '<span class="tweet_text">' + $([item.text]).linkUrl().linkUser().linkHash()[0] + '</span>';
				var message = '<p class="message">' + tweeter + delimiter + text + '</p>';
				var tweet_html = '<li class="tweet">' + avatar + message + date + '</li>';
				return tweet_html;

			};
		
			
			// Process the JSON returned from Twitter
			$.each(data.results, function(i, item) {

				// Populate tweet template
				var tweet_html = populate_template(item);

				// Add the marked-up tweet to the container
				tweets.push(tweet_html);

			});
			return tweets;

		}, display = function(tweets) {

			// Create html list element
			if(list === null) {
				list = $('<ul>').appendTo(placeholder);
			}

			// Remove current status
			$(".status").remove();

			for(var i = tweets.length - 1; i >= 0; i--) {

				// Add the marked-up tweet to the list
				var tweet = tweets[i];
				$(tweet).css("display", "none"); 
				
				list.prepend(tweet);
					
				// Update the classes on the list
				list.children('li:first').addClass('tweet_first');
				list.children('li:odd').addClass('tweet_even');
				list.children('li:even').addClass('tweet_odd');
				
				$(tweet).fadeIn("slow");			

			}
		};

		this.each(function() {
			placeholder = this;
			init();
			fetch();
		});
	};
})(jQuery);
