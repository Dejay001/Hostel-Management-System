class UserModel {
  final String uid;
  late final String email;
  final String firstname;
  late final String lastname;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.uid,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'] as String, email: json['email'] as String, firstname: '', lastname: '');
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'uid': this.uid, 'email': this.email, 'firstname': this.firstname, 'lastname': this.lastname};
}