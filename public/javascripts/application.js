// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
    init_pubsubhubbub();
});


function init_pubsubhubbub() {
    PUBNUB.subscribe({
      channel  : "griddy",      // CONNECT TO THIS CHANNEL.
      error    : function() {        // LOST CONNECTION (auto reconnects)
          alert("Connection Lost. Will auto-reconnect when Online.")
      },
      callback : function(message) { // RECEIVED A MESSAGE.
          process_pubnub(message)
      },
      connect  : function() {}
  })
}

function process_pubnub(message) {
    
    if (message.slot !== null && ($("body").attr('id') == 'talk-assign' || 'talk-move')) {
        slot = message.slot
        if (slot.talk_id != null && $("#slot-"+message.slot.id+"-select").length > 0){
            $("#slot-"+message.slot.id+"-select").removeClass('green').addClass('red').val('Taken').attr("disabled", true);         
        }
    }
    
    if (message.slot !== null && ($("body").attr('id') == 'date-grid' && slot.talk_id != null)) {
        $.getJSON("/talks/"+message.slot.talk_id+".json", function(data) {
            if($("#slot-"+message.slot.id).parent().hasClass('empty')){
                $("#slot-"+message.slot.id).children().first().append('<h2 class="heading title"><a href="/'+getCookie('version')+'/talks/'+data.talk.id+'">'+data.talk.title+'</a></h2>');
            } else {
                $("#slot-"+message.slot.id).children().first().find('h2 > a').attr("href", "/"+getCookie('version')+"/talks/"+data.talk.id+"")
                $("#slot-"+message.slot.id).children().first().find('h2 > a').text(data.talk.title)
            }
        });
    }

    if (message.slot !== null && ($("body").attr('id') == 'date-grid' && slot.talk_id == null)) {
        if($("#slot-"+message.slot.id).parent().hasClass('empty') !== true){
            $("#slot-"+message.slot.id).children().first().find('h2').empty();
        }
    }
}

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}