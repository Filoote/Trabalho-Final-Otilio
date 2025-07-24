// lib/views/map_screen.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/auth_controller.dart';
import 'login_screen.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final AuthController _authController = AuthController();

  // Coordenadas iniciais (ex: centro de Teresina, PI)
  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-5.0923, -42.8039),
    zoom: 14,
  );

  void _performLogout() async {
    await _authController.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _performLogout,
            tooltip: 'Sair',
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          // Você pode usar este controller para interagir com o mapa
        },
      ),
    );
  }
}