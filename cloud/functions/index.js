const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

const admin = require('firebase-admin');
admin.initializeApp();

exports.onDeleteGroup = functions.firestore.document('/groups/{groupId}').onDelete(group => {

    // Remove all subcollections from that group
    group.ref.getCollections().then(subcollections => {
        subcollections.forEach((subcollection) => {
            subcollection.get().then((childSnapshot) => {
                childSnapshot.forEach(doc => doc.ref.delete());
            });
        });
    });

});

exports.onDeleteRaid = functions.firestore.document('/groups/{groupId}/raids/{raidId}').onDelete(raid => {

    // Remove all subcollections from that raid
    raid.ref.getCollections().then(subcollections => {
        subcollections.forEach((subcollection) => {
            subcollection.get().then((childSnapshot) => {
                childSnapshot.forEach(doc => doc.ref.delete());
            });
        });
    });
    
});