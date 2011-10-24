// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
	init_pubsubhubbub();

	var Konami=function(){var a={addEvent:function(b,c,d,e){if(b.addEventListener)b.addEventListener(c,d,false);else if(b.attachEvent){b["e"+c+d]=d;b[c+d]=function(){b["e"+c+d](window.event,e)};b.attachEvent("on"+c,b[c+d])}},input:"",pattern:"3838404037393739666513",load:function(b){this.addEvent(document,"keydown",function(c,d){if(d)a=d;a.input+=c?c.keyCode:event.keyCode;if(a.input.length>a.pattern.length)a.input=a.input.substr(a.input.length-a.pattern.length);if(a.input==a.pattern){a.code(b);a.input=
	""}},this);this.iphone.load(b)},code:function(b){window.location=b},iphone:{start_x:0,start_y:0,stop_x:0,stop_y:0,tap:false,capture:false,orig_keys:"",keys:["UP","UP","DOWN","DOWN","LEFT","RIGHT","LEFT","RIGHT","TAP","TAP","TAP"],code:function(b){a.code(b)},load:function(b){this.orig_keys=this.keys;a.addEvent(document,"touchmove",function(c){if(c.touches.length==1&&a.iphone.capture==true){c=c.touches[0];a.iphone.stop_x=c.pageX;a.iphone.stop_y=c.pageY;a.iphone.tap=false;a.iphone.capture=false;a.iphone.check_direction()}});
	a.addEvent(document,"touchend",function(){a.iphone.tap==true&&a.iphone.check_direction(b)},false);a.addEvent(document,"touchstart",function(c){a.iphone.start_x=c.changedTouches[0].pageX;a.iphone.start_y=c.changedTouches[0].pageY;a.iphone.tap=true;a.iphone.capture=true})},check_direction:function(b){x_magnitude=Math.abs(this.start_x-this.stop_x);y_magnitude=Math.abs(this.start_y-this.stop_y);x=this.start_x-this.stop_x<0?"RIGHT":"LEFT";y=this.start_y-this.stop_y<0?"DOWN":"UP";result=x_magnitude>y_magnitude?
	x:y;result=this.tap==true?"TAP":result;if(result==this.keys[0])this.keys=this.keys.slice(1,this.keys.length);if(this.keys.length==0){this.keys=this.orig_keys;this.code(b)}}}};return a};

	konami = new Konami()
	konami.load("http://bit.ly/bcl9konami");

});
function init_pubsubhubbub() {
	PUBNUB.subscribe({
		channel : "griddy", // CONNECT TO THIS CHANNEL.
		error : function() {// LOST CONNECTION (auto reconnects)
			alert("Connection Lost. Will auto-reconnect when Online.")
		},
		callback : function(message) {// RECEIVED A MESSAGE.
			process_pubnub(message)
		},
		connect : function() {
		}
	})
}

function process_pubnub(message) {

	if(message.slot !== null && ($("body").attr('id') == 'talk-assign' || 'talk-move')) {
		slot = message.slot
		if(slot.talk_id != null && $("#slot-" + message.slot.id + "-select").length > 0) {
			$("#slot-" + message.slot.id + "-select").removeClass('green').addClass('red').val('Taken').attr("disabled", true);
		}
	}

	if(message.slot !== null && ($("body").attr('id') == 'date-grid' && slot.talk_id != null)) {
		$.getJSON("/talks/" + message.slot.talk_id + ".json", function(data) {
			if($("#slot-" + message.slot.id).parent().hasClass('empty')) {
				$("#slot-" + message.slot.id).children().first().append('<h4 class="heading title"><a href="/' + getCookie('version') + '/talks/' + data.talk.id + '">' + data.talk.title + '</a></h4>');
			} else {
				$("#slot-" + message.slot.id).children().first().find('h4 > a').attr("href", "/" + getCookie('version') + "/talks/" + data.talk.id + "")
				$("#slot-" + message.slot.id).children().first().find('h4 > a').text(data.talk.title)
			}
		});
	}

	if(message.slot !== null && ($("body").attr('id') == 'date-grid' && slot.talk_id == null)) {
		if($("#slot-" + message.slot.id).parent().hasClass('empty') !== true) {
			$("#slot-" + message.slot.id).children().first().find('.heading').empty();
		}
	}
}

function getCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i = 0; i < ca.length; i++) {
		var c = ca[i];
		while(c.charAt(0) == ' ') {
			c = c.substring(1, c.length);
		}
		if(c.indexOf(nameEQ) == 0) {
			return c.substring(nameEQ.length, c.length);
		}
	}
	return null;
}

jQuery(function($) {
	
	// Width fixes
	var tweak_width = function() {
		var widest_width = function() {
			var w = $(window).width();
			var d = $(document).width();
			var t = $("table.grid").width();
			if (t > w && t > d) {
				return t;
			} else if (d > w) {
				return d;
			} else{
				return w;
			};
		}
			
		$("#top").css("width", widest_width());
		$("#header, .scroller p").css("width", $(window).width());	
	}

	$(document).ready(function() {
		tweak_width();
	})
			
	$(window).resize(function() {
  		tweak_width();
	});
	
	// XL Grid	
	$("body#grid, .v-xl").each(function() {
		$(".grid .whats-on").each(function() {
			$(this).filter(".now").addClass("visible");
			$(this).filter(".next").addClass("invisible");	
		});
		setTimeout('$("body#grid, .v-xl").dg()', 30000);
	});			
	
	// Babble (Twitter)
	$(".tweets .stream").babble({
		username : "barcamplondon",
		avatar_size : 32,
		count : 10
	});
	
});
