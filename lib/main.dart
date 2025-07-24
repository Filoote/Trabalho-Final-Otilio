// lib/main.dart

import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'views/login_screen.dart';
import 'views/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Mapas Verde',
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      theme: ThemeData(
        // Paleta de cores principal
        primarySwatch: Colors.green,
        // Cor de destaque (para botões, links, etc.)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green[800]!, // Verde mais escuro para elementos principais
          secondary: Colors.teal[400]!, // Um verde-azulado para destaque
        ),
        // Estilo para botões elevados (ElevatedButton)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700], // Cor de fundo do botão
            foregroundColor: Colors.white, // Cor do texto do botão
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
          ),
        ),
        // Estilo para campos de texto
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.green[50]?.withOpacity(0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green[800]!),
          ),
        ),
        // Estilo para a AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[800],
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: _getInitialScreen(),
    );
  }

  Widget _getInitialScreen() {
    return FutureBuilder<bool>(
      future: AuthController().isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return snapshot.data == true ? MapScreen() : LoginScreen();
        }
      },
    );
  }
}