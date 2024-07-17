import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //firebase auth to do auth manipulations
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //get current user from firebase auth
  User? get currentUser => _firebaseAuth.currentUser;
  //get auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({required String email, required String password})async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({required String email,required String password})async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut()async{
    await _firebaseAuth.signOut();
  }
}