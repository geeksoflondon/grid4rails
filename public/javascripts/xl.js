(function($) {
	
	$.fn.dg = function(custom_settings) {	
		
		// Configuration
		var settings = {
			whats_on : {
				columns: 1				 
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
				
		}
		
		var configure = function() {
			
			// Merge the default settings with any custom ones supplied
			if(custom_settings) {
				this.settings = $.extend(settings, custom_settings);
			}
			
		}
		
		var rotate = function() {	
				
			$(visible).animate({opacity : 0}, 2500);
			$(invisible).animate({opacity : 1}, 2500);
			$(visible).removeClass("visible").addClass("invisible");
			$(invisible).removeClass("invisible").addClass("visible");
			setTimeout("$(this).dg({})", 30000);
		}		
																	
		this.each(function() {
			init();
			console.log(visible);
			console.log(invisible);
			rotate();							
		});
				
	};
	
})(jQuery);
