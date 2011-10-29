// Real-time updating via PubNub
function process_pubnub(message) {

	if(message.slot !== null && ($("body").attr('id') == 'talk-assign' || 'talk-move')) {
		slot = message.slot;
		if(slot.talk_id !== null && $("#slot-" + message.slot.id + "-select").length > 0) {
			$("#slot-" + message.slot.id + "-select").removeClass('green').addClass('red').val('Taken').attr("disabled", true);
		}
	}

	if(message.slot !== null && ($("body").attr('id') == 'date-grid' && slot.talk_id !== null)) {
		$.getJSON("/s/talks/" + message.slot.talk_id + ".json", function(data) {
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


function init_pubsubhubbub() {
	PUBNUB.subscribe({
		channel : "griddy", // CONNECT TO THIS CHANNEL.
		error : function() {// LOST CONNECTION (auto reconnects)
			alert("Connection Lost. Will auto-reconnect when Online.");
		},
		callback : function(message) {// RECEIVED A MESSAGE.
			process_pubnub(message);
		},
		connect : function() {
		}
	});
}

$(document).ready(function() {
	// Real-time updating
	init_pubsubhubbub();
	
});		