import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String uid;
  final String email;
  final String displayName;
  final String firstName;
  final String lastName;
  final String photoUrl;
  final String phoneNumber;

  const User(
      {this.id,
      this.uid,
      this.email,
      this.displayName,
      this.photoUrl,
      this.phoneNumber,
      this.firstName,
      this.lastName});

  @override
  List<Object> get props => [id, uid, email, displayName, firstName, lastName, photoUrl, phoneNumber];

  @override
  String toString() {
    return 'User{id: $id, uid: $uid, email: $email, displayName: $displayName, firstName: $firstName, lastName: $lastName, photoUrl: $photoUrl, phoneNumber: $phoneNumber}';
  }
}
