import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String uid;
  final String email;
  final String displayName;
  final String firstName;
  final String lastName;
  final String photoURL;
  final String phoneNumber;

  const User(
      {this.id,
      this.uid,
      this.email,
      this.displayName,
      this.photoURL,
      this.phoneNumber,
      this.firstName,
      this.lastName});

  @override
  List<Object> get props => [id, uid, email, displayName, firstName, lastName, photoURL, phoneNumber];
  
  static const empty = User(id: '', uid: '', email: '', displayName: '', lastName: '', photoURL: '', phoneNumber: '');

  @override
  String toString() {
    return 'User{id: $id, uid: $uid, email: $email, displayName: $displayName, firstName: $firstName, lastName: $lastName, photoURL: $photoURL, phoneNumber: $phoneNumber}';
  }
}
