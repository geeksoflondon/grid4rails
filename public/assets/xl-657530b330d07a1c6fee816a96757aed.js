function refresh(){window.location.reload(!1)}!function(t){t.fn.flypost=function(i){var e=function(i,e){t(i).find(".slot").each(function(){var i=this,n=t(i).attr("id"),s=n.substr(5,n.length),r=function(i){var n=null;return t.each(e.timeslot.slots,function(t,e){e.id==i&&(n=e)}),n},a=r(s),l={title:"Empty",parent:null,reset:function(){t(this.parent).hasClass("talk")&&t(this.parent).addClass("empty").removeClass("talk"),t(this.parent).find(".speaker").remove(),t(this.parent).find(".description").remove(),t(this.parent).find(".title").remove()},insert:function(i){this.parent=i,this.reset(),t(this.parent).append('<p class="heading title">'+this.title+"</p>")}},h=function(){return{id:null,title:null,speaker:null,description:null,url:null,parent:null,populate:function(t){return null!==t&&(this.id=t.id,this.title=t.title,this.speaker=t.speaker,this.description=t.description,this.url=t.url),this},reconstruct:function(i){return this.parent=i,null!==this.parent&&"undefined"!==this.parent&&(this.id=t(this.parent).attr("id"),this.title=t(this.parent).find(".title").text(),this.speaker=t(this.parent).find(".speaker").text(),this.description=t(this.parent).find(".description").text(),this.url=t(this.parent).find(".title a").attr("href")),this},equals:function(t){return this.id==t.id&&this.talk==t.talk&&this.speaker==t.speaker&&this.description==t.description?!0:!1},reset:function(){t(this.parent).hasClass("empty")&&t(this.parent).addClass("talk").removeClass("empty"),t(this.parent).find(".speaker").remove(),t(this.parent).find(".description").remove(),t(this.parent).find(".title").remove()},insert:function(i){this.parent=i,this.reset(),null!==this.title&&""!=t.trim(this.title)&&t(this.parent).append('<p class="heading title"><a>'+this.title+"</a></p>"),null!==this.description&&""!=t.trim(this.description)&&t(this.parent).append('<div class="description">'+this.description+"</div>"),null!==this.speaker&&""!=t.trim(this.speaker)&&t(this.parent).append('<h3 class="heading speaker">'+this.speaker+"</h3>"),this.title}}};return null===a?(refresh(),void 0):(t(i).children(".empty").length>0?a.talk_id&&null!==a.talk_id&&t(i).children(".empty").each(function(){(new h).populate(a.talk).insert(this)}):null===a.talk_id?t(i).children(".talk").each(function(){(new l).insert(this)}):t(i).children(".talk").each(function(){var t=(new h).populate(a.talk),i=(new h).reconstruct(this);t.equals(i)||t.insert(this)}),void 0)})},n=function(i){var n={now:"http://bcl9grid.heroku.com/s/grid/now.json",next:"http://bcl9grid.heroku.com/s/grid/next.json"},s=null;t(i).hasClass("now")?s=n.now:t(i).hasClass("next")&&(s=n.next),null!==s&&t.getJSON(s,function(t){e(i,t)})};n(i)},t.fn.adjustToFit=function(){var i=this,e=t(i).height(),n=t(window).height(),s=t(document).height(),r=n;s>r&&(r=s);var a=r-e,l=a/2;if(l>0){var h=l+"px";t(i).css("top",h)}},t.fn.blade=function(i){var e={whats_on:{columns:1}},n=null,s=null,r=function(){if(a(),n=t(".grid .whats-on").filter(".visible"),s=t(".grid .whats-on").filter(".invisible"),null===s&&t(".main > p.message")){var i=t(".main > p.message"),e=t(i).clone();t(".grid .whats-on").append(e),t(i).remove()}t(s).adjustToFit()},a=function(){i&&(this.settings=t.extend(e,i))},l=function(){t(n).animate({opacity:0},2500),t(s).animate({opacity:1},2500),t(n).removeClass("visible").addClass("invisible"),t(s).removeClass("invisible").addClass("visible"),setTimeout("$(this).blade()",3e4)};this.each(function(){r(),t.fn.flypost(s),l()})},t(document).ready(function(){setTimeout("refresh()",6e4)})}(jQuery);