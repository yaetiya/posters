import 'package:firebase_auth/firebase_auth.dart';

Future<FirebaseUser> getCurrentUser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();

  if (user != null) {
    return user;
  } else {
    return null;
  }
}
