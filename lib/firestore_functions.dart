import 'package:cloud_firestore/cloud_firestore.dart';

getPublicKeyFromEmail(String email) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('users').doc(email).get();

  if (doc.exists) {
    return doc.get("publicKey");
  } else {
    return 'user not found';
  }
}
