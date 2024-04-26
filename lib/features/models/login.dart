import 'dart:convert';

class LoginModel {
  String email;
  String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class User {
  String id;
  String firstName;
  String email;
  String orgId;
  String role;
  User({
    required this.id,
    required this.firstName,
    required this.email,
    required this.orgId,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      email: map['email'] ?? '',
      orgId: map['orgId'] ?? '',
      role: map['role'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, email: $email, orgId: $orgId, role: $role)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'email': email,
      'orgId': orgId,
      'role': role,
    };
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
