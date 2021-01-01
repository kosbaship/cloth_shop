import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuth auth;

  FirebaseAuthService() {
    auth = FirebaseAuth.instance;
  }

  static Future<UserCredential> signUp({String email, String password}) async {
    return await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<UserCredential> signIn({String email, String password}) async {
    return await auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
