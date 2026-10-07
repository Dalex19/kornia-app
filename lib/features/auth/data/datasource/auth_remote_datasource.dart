import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRemoteDatasource(this._firestore, this._auth);

  Future<void> createDocument({required Map<String, dynamic> data, required String uid}) async {
 
    await _firestore.collection('users').doc(uid).set(data);
  }


  Future<String> registerWithEmailAndPassword({required String email, required String password}) async {
   final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  return cred.user!.uid;
  }

  Future<void> loginWithEmailAndPassword({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();

}
