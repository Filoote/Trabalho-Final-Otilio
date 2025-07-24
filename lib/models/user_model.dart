// lib/models/user_model.dart

import 'dart:convert';

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});

  // Métodos para converter o objeto para e de um Map (útil para JSON)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}