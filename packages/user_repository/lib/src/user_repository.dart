import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:uuid/uuid.dart';
import 'models/models.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  User _user;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

//  Future<String> getUser() async {
//    return (await _firebaseAuth.currentUser()).email;
//  }
  Future<User> getFirebaseUser() async {
    
    final FirebaseUser fbs_User = (await _firebaseAuth.currentUser());
    final user = User(
      id: '${fbs_User.uid ?? Uuid().v4()}',
      uid: '${fbs_User.uid ?? ''}',
      email: '${fbs_User.email ?? ''}',
      displayName: '${fbs_User.displayName ?? ''}',
      photoUrl: '${fbs_User.photoUrl ?? ''}',
      phoneNumber: '${fbs_User.phoneNumber ?? ''}',
    );
    return user;
  }
  
  Future<User> getAppUserUuid() async {
    if(_user != null) return _user;
    return Future.delayed(const Duration(milliseconds: 300),
          () => _user = User(
              id: Uuid().v4(),
              uid: Uuid().v4()
            ),
          );
  }
}


//import 'dart:async';
//
//import 'package:uuid/uuid.dart';
//
//import 'models/models.dart';
//
//class UserRepository {
//  User _user;
//
//  Future<User> getUser() async {
//    if(_user != null) return _user;
//    return Future.delayed(const Duration(milliseconds: 300),
//        () => _user = User(Uuid().v4()),);
//  }
//}

