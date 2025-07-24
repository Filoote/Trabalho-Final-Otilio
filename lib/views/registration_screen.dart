// lib/views/registration_screen.dart

import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();
  final _formKey = GlobalKey<FormState>();

  void _performRegistration() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = User(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final success = await _authController.register(user);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cadastro realizado com sucesso!')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Este email já foi cadastrado.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar com fundo transparente para um visual mais limpo
      appBar: AppBar(
        title: Text('Crie sua Conta'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.green[900], // Cor dos ícones e texto
      ),
      body: Center(
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
                  height: 120,
                  width: 120,
                  child: Icon(Icons.person_add_alt_1_rounded, size: 80, color: Colors.green[700]),
                  margin: const EdgeInsets.only(bottom: 40),
                ),

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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // --- BOTÃO DE CADASTRO ---
                ElevatedButton(
                  onPressed: _performRegistration,
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}