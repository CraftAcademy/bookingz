// App.cable.subscriptions.create({channel: 'NoteChannel', facility_id: parseInt(facility_id, 10)}, {
//     collection: function () {
//         // return $("#message");
//     },
//
//     connected: function (data) {
//         // Called when the subscription is ready for use on the server
//
//     },
//
//     disconnected: function () {
//         // Called when the subscription has been terminated by the server
//     },
//
//     received: function (data) {
//         // Called when there's incoming data on the websocket for this channel
//         $('.note_flash').html("Your message '" + data.note + "' was sent at " + data.time);
//     }
// });