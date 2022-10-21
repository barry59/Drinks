import '../model/user.dart';
import '../model/firebaseUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  // Initialize FirebaseAuth
  final FirebaseAuth _authenticatedUser = FirebaseAuth.instance;

  // Return a user if it's not null, otherwise return null.
  FirebaseUser? _firebaseUser(User? user) {
    return user != null? FirebaseUser(uid: user.uid): null;
  }

  // Get current user.
  User? appUser = FirebaseAuth.instance.currentUser;

  // Return current user's email address.
  getUserEmail() {
    if (appUser != null) {
      String? email = appUser!.email;
      return email;
    }
    return "User unavailable, check Firebase.".toUpperCase();
  }

  // Return the latest changes of current user's authentication status.
  Stream<FirebaseUser?> get user {
    return _authenticatedUser.authStateChanges().map(_firebaseUser);
  }

  // If user record is found in firebase, return user record. Otherwise, return error message.
  Future appLogin(AppUser _user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _user.emailAddress.toString(), password: _user.password.toString());
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) { // Return an error code from firebase that indicates an invalid login attempt
      return FirebaseUser(errorCode: e.code, uid: null);
    } catch (e) { // Return the error message
      return FirebaseUser(errorCode: e.toString(), uid: null);
    }
  }

  // Sign up user in firebase if no record is found and return the new user record.
  // If user uses the same email address to sign up twice, return error message.
  Future appSignUp(AppUser _user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _user.emailAddress.toString(), password: _user.password.toString());
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) { // Return an error code from firebase that indicates an unsuccessfull SignUp attempt
      return FirebaseUser(errorCode: e.code, uid: null);
    } catch (e) { // Return the error message
      return FirebaseUser(errorCode: e.toString(), uid: null);
    } 
  }

  // Sign out user.
  Future appSignOut() async {
    try {
      return await _authenticatedUser.signOut();
    } catch (e) {
      return "Unsuccessful SignOut Attempt";
    }
  }
}