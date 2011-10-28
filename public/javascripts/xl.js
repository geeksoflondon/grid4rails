// Automatic page refresh
function refresh() {
	window.location.reload(false);
}



(function($) {

	$.fn.flypost = function(context) {

		var publish = function(element, data) {

			$(element).find(".header .time").each(function(){
				
				var timestamp = this;

				var start = (data.timeslot.start).substring(11, 16);
				var end = (data.timeslot.end).substring(11, 16);
								
				$(timestamp).replaceWith('<p class="time">' + start + '-' + end + '</p>');
				
			});

			$(element).find(".slot").each(function() {

				var slot = this;

				// Find and store the Ids for this slot
				var slotIdStr = $(slot).attr("id");
				var slotId = slotIdStr.substr(5, slotIdStr.length);

				var getSlotData = function(id) {
					var slotData = null;
					$.each(data.timeslot.slots, function(i, slot) {
						if(slot.id == id) {
							slotData = slot;
						}
					});
					return slotData;
				};
				
				var slotData = getSlotData(slotId);		
				
				var emptyObj = {
					title : "Empty",
					parent : null,
					reset  : function() {
						if ($(this.parent).hasClass("talk")){
							$(this.parent).addClass("empty").removeClass("talk");	
						}
						$(this.parent).find(".speaker").remove();	
						$(this.parent).find(".description").remove();
						$(this.parent).find(".title").remove();	
					},
					insert : function(parent) {
						this.parent = parent;
						this.reset();
						$(this.parent).append('<p class="heading title">' + this.title + '</p>');																	
					}
				};

				var talkObj = function(){
					return {
						id : null,
						title : null,
						speaker : null,
						description : null,
						url : null,
						parent : null,
						populate : function(talkData) {
							if(talkData !== null) {
								this.id = talkData.id;
								this.title = talkData.title;
								this.speaker = talkData.speaker;
								this.description = talkData.description;
								this.url = talkData.url;
							}
							return this;
						},	
						reconstruct : function(parent) {						
							this.parent = parent;
							if (this.parent !== null && this.parent !== 'undefined') {
								this.id = $(this.parent).attr("id");
								this.title = $(this.parent).find(".title").text();
								this.speaker = $(this.parent).find(".speaker").text();
								this.description = $(this.parent).find(".description").text();
								this.url = $(this.parent).find(".title a").attr("href");
							}
							return this;
						},
						equals : function(other) {							
							if (
								this.id == other.id && 
								this.talk == other.talk &&
								this.speaker == other.speaker &&
								this.description == other.description	
							) {								
								return true;
							}				
							return false;					
						},
						reset : function() {
							if ($(this.parent).hasClass("empty")){
								$(this.parent).addClass("talk").removeClass("empty");
							}
							$(this.parent).find(".speaker").remove();	
							$(this.parent).find(".description").remove();
							$(this.parent).find(".title").remove();													
						},				
						insert : function(parent) {			
							
							this.parent = parent;
							this.reset();
							
							if (this.title !== null && $.trim(this.title) != '') {
								$(this.parent).append('<p class="heading title"><a>' + this.title + '</a></p>');
							}
							if (this.description !== null && $.trim(this.description) != '') {
								$(this.parent).append('<div class="description">' + this.description + '</div>');
							}
							if (this.speaker !== null && $.trim(this.speaker) != '') {
								$(this.parent).append('<h3 class="heading speaker">' + this.speaker + '</h3>');
							}
							if (this.title) {
								
							}
						}	
					};				
				};

				if(slotData === null) {
					refresh();	
				}

				if($(slot).children(".empty").length > 0) {

					if(slotData.talk_id && slotData.talk_id !== null) {

						// Slot was empty but now has a talk
						$(slot).children(".empty").each(function() {
							var current = new talkObj().populate(slotData.talk).insert(this);
						});
						
					} else {

						// Slot was empty and still is.  Do nothing.
						
					}


				} else {

					if(slotData.talk_id === null) {

						// Slot was occupied but now is empty
						$(slot).children(".talk").each(function() {
							var current = new emptyObj().insert(this);
						});
						
					} else {

						// Slot is still occupied						
						$(slot).children(".talk").each(function() {
							var current = new talkObj().populate(slotData.talk);
							var original = new talkObj().reconstruct(this);		
																													
							if (!current.equals(original)) {
								current.insert(this);
							}
						});
					}

				}


			});
		};
		var fetchJson = function(context) {
			var sources = {
				now  : "http://bcl9grid.heroku.com/s/grid/now.json",
				next : "http://bcl9grid.heroku.com/s/grid/next.json"								
			};

			// Get URL for JSon version of pane specified
			var source = null;
			if($(context).hasClass('now')) {
				source = sources.now;
			} else if($(context).hasClass('next')) {
				source = sources.next;
			}

			// Update pane specified
			if(source !== null) {
				var json = $.getJSON(source, function(data) {
					publish(context, data);
				});
			}

		};
		fetchJson(context);
	};


	$.fn.adjustToFit = function() {

		var pane = this;

		// Determine the height of relevant elements
		var paneHeight = $(pane).height();
		var windowHeight = $(window).height();
		var documentHeight = $(document).height();

		// Calculate a potential new top position for the pane
		var spaceHeight = windowHeight;
		if(documentHeight > spaceHeight) {
			spaceHeight = documentHeight;
		}
		var spareBodySpace = spaceHeight - paneHeight;
		var newPaneTop = (spareBodySpace / 2);

		// If there's space, reposition the pane
		if(newPaneTop > 0) {
			var paneTop = newPaneTop + "px";
			$(pane).css("top", paneTop);
		}
	};
	// Now and next
	$.fn.blade = function(custom_settings) {

		// Configuration
		var settings = {
			whats_on : {
				columns : 1
			}
		};

		var visible = null;
		var invisible = null;

		// Methods
		var init = function() {

			// Determine settings
			configure();

			// Find the now and next panes
			visible = $(".grid .whats-on").filter(".visible");
			invisible = $(".grid .whats-on").filter(".invisible");
			
			if (invisible === null && $(".main > p.message")) {
				var original = $(".main > p.message");
				var clone = $(original).clone();
				$(".grid .whats-on").append(clone);		
				$(original).remove();		
			}		

			$(invisible).adjustToFit();

		};
		var configure = function() {

			// Merge the default settings with any custom ones supplied
			if(custom_settings) {
				this.settings = $.extend(settings, custom_settings);
			}

		};
		var rotate = function() {

			$(visible).animate({
				opacity : 0
			}, 2500);
			$(invisible).animate({
				opacity : 1
			}, 2500);
			$(visible).removeClass("visible").addClass("invisible");
			$(invisible).removeClass("invisible").addClass("visible");
			setTimeout("$(this).blade()", 30000);
		};

		this.each(function() {
			init();
			$.fn.flypost(invisible);
			rotate();
		});
	};
	
	
	// Automatic page refresh, every 60 seconds
	$(document).ready(function() {
		// the timeout value should be the same as in the "refresh" meta-t
		// setTimeout("refresh()", 60*1000);
	});
})(jQuery);
