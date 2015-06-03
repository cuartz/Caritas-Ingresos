// Ribbon scrolling effects 
// -------------------------------------------------------------------

(function($){

	$.fn.ribbonPosition = function(){
		
		var element = this;
	
		// execute once on load
		changePosition();
		
		// bind function to window scroll event
		$(window).bind("scroll", function(){
			changePosition();
		});
		
		// function to determine position and adjust style
		function changePosition() {
			var	t = $(window).scrollTop();
			var	h = $(window).height();
			
			var	offset = $(window).height() / 25;	// offset - increase or decrease size of middle (set to zero to disable)
			var	zoneSize = $(window).height() / 3;
			var	zoneOne = t + zoneSize + offset;
			var	zoneTwo = t + zoneSize * 2 - offset;
			
			// loop through each element and apply style change
			return $(element).each( function() {
				var obj = $(this);
				var objH = obj.height();
				var offset = obj.offset();
				if (offset.top + objH <= zoneOne) {
					return $(this).css('background-position','0 0');
				} else if (offset.top >= zoneTwo) {
					return $(this).css('background-position','0 -104px');
				} else {
					return $(this).css('background-position','0 -52px');
				}
			});	
		}

	};

})(jQuery);


// load function
jQuery(document).ready(function($) {
	
	// 3D ribbon scroll triggers
	// -------------------------------------------------------------------
	$(".ribbon .wrapAround").ribbonPosition();
	
});
