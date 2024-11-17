import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print("Error signing in with email: $e");
      return null;
    }
  }

  // Sign in anonymously
  Future<User?> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print("Error signing in anonymously: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Stream to detect if a user is signed in
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // Get the current logged-in user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
