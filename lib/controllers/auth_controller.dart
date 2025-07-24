// lib/controllers/auth_controller.dart

// import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthController {
  // Chave para armazenar a lista de usuários no SharedPreferences
  static const _usersKey = 'users';

  // Método para registrar um novo usuário
  Future<bool> register(User newUser) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Pega a lista de usuários existente (se houver)
    final List<String> usersJson = prefs.getStringList(_usersKey) ?? [];
    List<User> users = usersJson.map((user) => User.fromJson(user)).toList();

    // Verifica se o email já está cadastrado
    if (users.any((user) => user.email == newUser.email)) {
      print("Erro: Email já cadastrado.");
      return false;
    }

    // Adiciona o novo usuário e salva a lista atualizada
    users.add(newUser);
    List<String> updatedUsersJson = users.map((user) => user.toJson()).toList();
    await prefs.setStringList(_usersKey, updatedUsersJson);
    
    print("Usuário registrado com sucesso!");
    return true;
  }

  // Método para fazer login
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> usersJson = prefs.getStringList(_usersKey) ?? [];
    List<User> users = usersJson.map((user) => User.fromJson(user)).toList();

    // Procura por um usuário com o email e senha correspondentes
    final userExists = users.any((user) => user.email == email && user.password == password);

    if (userExists) {
      // Salva o estado de "logado"
      await prefs.setBool('isLoggedIn', true);
      print("Login bem-sucedido!");
      return true;
    } else {
      print("Erro: Email ou senha inválidos.");
      return false;
    }
  }

  // Método para logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    print("Logout realizado.");
  }

  // Verifica se o usuário já está logado (para iniciar o app na tela certa)
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}