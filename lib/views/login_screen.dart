// lib/views/login_screen.dart

import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'registration_screen.dart';
import 'map_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();
  final _formKey = GlobalKey<FormState>();

  void _performLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _authController.login(
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) { // Verifica se o widget ainda está na árvore
        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MapScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email ou senha inválidos.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- ESPAÇO PARA A IMAGEM ---
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/images/logo.png'), // Carrega a imagem
                    margin: const EdgeInsets.only(bottom: 40),
                  ),

                  Text(
                    'Bem-vindo de volta!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Faça login para continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // --- CAMPO DE EMAIL ---
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.green[800]),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => (value?.isEmpty ?? true) ? 'Campo obrigatório' : null,
                  ),
                  const SizedBox(height: 16),

                  // --- CAMPO DE SENHA ---
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.green[800]),
                    ),
                    obscureText: true,
                    validator: (value) => (value?.isEmpty ?? true) ? 'Campo obrigatório' : null,
                  ),
                  const SizedBox(height: 30),

                  // --- BOTÃO DE LOGIN ---
                  ElevatedButton(
                    onPressed: _performLogin,
                    child: Text('Login'),
                  ),
                  const SizedBox(height: 20),

                  // --- BOTÃO PARA CADASTRO ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Não tem uma conta?", style: TextStyle(color: Colors.grey[700])),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistrationScreen()),
                          );
                        },
                        child: Text(
                          'Cadastre-se',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}