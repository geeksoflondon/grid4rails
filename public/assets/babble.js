!function(t){t.fn.babble=function(e){return{placeholder:null,request:null,list:null,queue:null,latest:null,settings:{username:["sheilaellen"],avatar_size:null,count:3,messages:{fetching:"Fetching tweets...",loading:"...loading tweets,"},delay:20,query:null,running:!1},init:function(){this.configure(),this.request=this.formulate_request()},configure:function(){e&&(this.settings=t.extend(this.settings,e)),this.autoAdjust()},autoAdjust:function(){var e=t(".tweets"),s=t(e).position().top,n=t(window).height(),a=t(document).height(),i=n;a>i&&(i=a);var r=i-s;if(r>0){var u=r+"px";t(e).css("height",u)}},notify:function(e){if(e){t(".status").remove();var s=t('<p class="status">'+e+"</p>");return t(this.placeholder).append(s),s}return null},formulate_request:function(){var t="";null!==this.settings.query&&(t+="q="+this.settings.query),t+="&q=from:"+this.settings.username;var e="http://search.twitter.com/search.json?"+t+"&rpp="+this.settings.count+"&callback=?";return e},fetch:function(){setTimeout("babbler.fetch()",25e3);var e=this;this.notify(this.settings.messages.fetching),t.getJSON(this.request,function(t){e.display(e.process_response(t))})},process_response:function(e){var s=this;this.notify(this.settings.messages.loading);var n=Array(),a=function(e){t.fn.extend({linkUrl:function(){var e=[],s=/((ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?)/gi;return this.each(function(){e.push(this.replace(s,'<a href="$1">$1</a>'))}),t(e)},linkUser:function(){var e=[],s=/[\@]+([A-Za-z0-9-_]+)/gi;return this.each(function(){e.push(this.replace(s,'<a href="http://twitter.com/$1">@$1</a>'))}),t(e)},linkHash:function(){var e=[],n=/ [\#]+([A-Za-z0-9-_]+)/gi;return this.each(function(){e.push(this.replace(n,' <a href="http://search.twitter.com/search?q=&tag=$1&lang=all&from='+s.settings.username+"%2BOR%2B"+'">#$1</a>'))}),t(e)}});var n=function(t){var e=Date.parse(t),s=arguments.length>1?arguments[1]:new Date,n=parseInt((s.getTime()-e)/1e3,10);return 60>n?"less than a minute ago":120>n?"about a minute ago":2700>n?parseInt(n/60,10).toString()+" minutes ago":5400>n?"about an hour ago":86400>n?"about "+parseInt(n/3600,10).toString()+" hours ago":172800>n?"1 day ago":parseInt(n/86400,10).toString()+" days ago"},a='<p class="avatar"><a href="http://twitter.com/'+e.from_user+'"><img src="'+e.profile_image_url+'" height="'+s.settings.avatar_size+'" width="'+s.settings.avatar_size+'" alt="'+e.from_user+'\'s avatar" border="0"/></a></p>',i=s.settings.avatar_size?a:"",r='<span class="tweeter">'+e.from_user+"</span>",u='<span class="delimiter">: </span>',o='<p class="when"><a href="http://twitter.com/'+e.from_user+"/statuses/"+e.id+'" title="view tweet on twitter">'+n(e.created_at)+"</a></p>",l='<span class="body">'+t([e.text]).linkUrl().linkUser().linkHash()[0]+"</span>",h='<p class="message">'+r+u+l+"</p>",c='<li class="tweet">'+i+h+o+"</li>";return c};return t.each(e.results,function(t,e){var s=a(e);n.push(s)}),n},display:function(e){null===this.list&&(this.list=t("<ul>").appendTo(t(this.placeholder))),t(".status").remove();for(var s=e.length-1;s>=0;s--){var n=e[s];t(n).css("display","none"),this.list.prepend(n),t(n).fadeIn("slow")}},run:function(t){this.placeholder=t,this.init(),this.fetch()}}}}(jQuery);