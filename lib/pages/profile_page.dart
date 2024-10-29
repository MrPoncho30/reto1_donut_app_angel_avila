import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene la instancia actual del usuario autenticado
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mostrar la foto de perfil si está disponible, de lo contrario mostrar un ícono
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!) // Cargar la foto desde la URL
                  : AssetImage('assets/profile_image.png')
                      as ImageProvider, // Foto por defecto
            ),
            SizedBox(height: 10),
            // Muestra el nombre del usuario si está disponible
            Text(
              user?.displayName ??
                  'Nombre de Usuario', // Puedes modificarlo según necesites
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Muestra el correo electrónico del usuario
            Text(
              user?.email ?? 'usuario@correo.com',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
