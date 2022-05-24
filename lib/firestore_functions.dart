import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getPublicKeyFromEmail(String email) async {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .get()
      .then((value) {
    return value.data()!['publicKey'];
  });
}
