// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function getCookie(e){var t=e+"=",n=document.cookie.split(";");for(var r=0;r<n.length;r++){var i=n[r];while(i.charAt(0)==" ")i=i.substring(1,i.length);if(i.indexOf(t)===0)return i.substring(t.length,i.length)}return null}var babbler=null;jQuery(function(e){var t=function(){var t=function(){var t=e(window).width(),n=e(document).width(),r=e("table.grid").width();return r>t&&r>n?r:n>t?n:t};e("#top").css("width",t()),e("#header, .scroller p").css("width",e(window).width())};e(window).resize(function(){t()}),e("body#grid, .v-xl").each(function(){e(".grid .whats-on").each(function(){e(this).filter(".now").each(function(){e(this).css("opacity","0"),e(this).adjustToFit(),e(this).animate({opacity:1},2500),e(this).addClass("visible")}),e(this).filter(".next").addClass("invisible")}),setTimeout('$("body#grid, .v-xl").blade()',3e4)}),e(".tweets .stream").each(function(){babbler=new e.fn.babble({username:"barcamplondon",query:"bcl9",avatar_size:32,count:10}),babbler.run(this)}),e(document).ready(function(){t();var e=function(){var e={addEvent:function(e,t,n,r){e.addEventListener?e.addEventListener(t,n,!1):e.attachEvent&&(e["e"+t+n]=n,e[t+n]=function(){e["e"+t+n](window.event,r)},e.attachEvent("on"+t,e[t+n]))},input:"",pattern:"3838404037393739666513",load:function(t){this.addEvent(document,"keydown",function(n,r){r&&(e=r),e.input+=n?n.keyCode:event.keyCode,e.input.length>e.pattern.length&&(e.input=e.input.substr(e.input.length-e.pattern.length)),e.input==e.pattern&&(e.code(t),e.input="")},this),this.iphone.load(t)},code:function(e){window.location=e},iphone:{start_x:0,start_y:0,stop_x:0,stop_y:0,tap:!1,capture:!1,orig_keys:"",keys:["UP","UP","DOWN","DOWN","LEFT","RIGHT","LEFT","RIGHT","TAP","TAP","TAP"],code:function(t){e.code(t)},load:function(t){this.orig_keys=this.keys,e.addEvent(document,"touchmove",function(t){t.touches.length==1&&e.iphone.capture===!0&&(t=t.touches[0],e.iphone.stop_x=t.pageX,e.iphone.stop_y=t.pageY,e.iphone.tap=!1,e.iphone.capture=!1,e.iphone.check_direction())}),e.addEvent(document,"touchend",function(){e.iphone.tap===!0&&e.iphone.check_direction(t)},!1),e.addEvent(document,"touchstart",function(t){e.iphone.start_x=t.changedTouches[0].pageX,e.iphone.start_y=t.changedTouches[0].pageY,e.iphone.tap=!0,e.iphone.capture=!0})},check_direction:function(e){x_magnitude=Math.abs(this.start_x-this.stop_x),y_magnitude=Math.abs(this.start_y-this.stop_y),x=this.start_x-this.stop_x<0?"RIGHT":"LEFT",y=this.start_y-this.stop_y<0?"DOWN":"UP",result=x_magnitude>y_magnitude?x:y,result=this.tap===!0?"TAP":result,result==this.keys[0]&&(this.keys=this.keys.slice(1,this.keys.length)),this.keys.length===0&&(this.keys=this.orig_keys,this.code(e))}}};return e},n=new e;n.load("http://bit.ly/bcl9konami")}),e(document).ready(function(){var t=128,n=e("#char_count");if(n.length>0){var r=e("textarea#talk_description"),i=function(){var e=t-r.val().length;n.text(e),e<0?n.addClass("counter_warning"):n.removeClass("counter_warning")};r.keyup(i),i()}})});