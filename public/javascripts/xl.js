// Automatic page refresh
function refresh() {
	window.location.reload(false);
}

(function($) {

	
	$.fn.adjustToFit = function() {		
			
		var pane = this;		
		
		// Determine the height of relevant elements
		var paneHeight = $(pane).height();			
		var windowHeight = $(window).height();				
		var documentHeight = $(document).height();							
		
		// Calculate a potential new top position for the pane		
		var spaceHeight = windowHeight;
		if (documentHeight > spaceHeight) {
			spaceHeight = documentHeight;
		}								
		var spareBodySpace = spaceHeight - paneHeight;			
		var newPaneTop = (spareBodySpace / 2);
				
		// If there's space, reposition the pane
		if (newPaneTop > 0) {
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
			setTimeout("$(this).blade({})", 30000);
		};		

		this.each(function() {
			init();
			rotate();
		});
	};
	
	
	
	// Automatic page refresh, every 60 seconds
	$(document).ready(function() {
		// the timeout value should be the same as in the "refresh" meta-t
		// setTimeout("refresh()", 60*1000);
	});
		
})(jQuery);
