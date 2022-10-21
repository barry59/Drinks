// Firebase User
// Use to check if user record is in firebase.
class FirebaseUser {
  final String? uid; // An ID given by firebase for each authenticated user
  final String? errorCode; // An error code indicating an invalid user

  FirebaseUser({this.uid, this.errorCode});
}
