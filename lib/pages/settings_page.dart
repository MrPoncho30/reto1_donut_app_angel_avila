import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir la interfaz
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Auth para autenticación de usuarios
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore para manejar la base de datos en la nube
import 'package:firebase_storage/firebase_storage.dart'; // Importa Firebase Storage para subir y manejar imágenes
import 'package:image_picker/image_picker.dart'; // Importa el paquete para seleccionar imágenes de la galería
import 'dart:io'; // Importa para manejar archivos en el sistema de archivos del dispositivo

// Clase principal para la página de configuración
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() =>
      _SettingsPageState(); // Crea el estado asociado a la página
}

// Estado de la página de configuración
class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _usernameController =
      TextEditingController(); // Controlador para el campo de nombre de usuario
  final TextEditingController _newPasswordController =
      TextEditingController(); // Controlador para la nueva contraseña
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // Controlador para confirmar la nueva contraseña

  User? user; // Variable para almacenar el usuario actual
  File? _image; // Variable para almacenar la imagen seleccionada
  final ImagePicker _picker =
      ImagePicker(); // Instancia de ImagePicker para seleccionar imágenes

  // Método que se ejecuta cuando se inicializa el estado
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser; // Obtiene el usuario actual
    if (user != null) {
      _usernameController.text = user!.displayName ??
          ''; // Establece el nombre de usuario en el controlador
    }
  }

  // Método para actualizar el nombre de usuario
  Future<void> _updateUsername() async {
    if (user != null) {
      await user!.updateProfile(
        // Actualiza el perfil del usuario
        displayName:
            _usernameController.text.trim(), // Actualiza el nombre de usuario
        photoURL: user!.photoURL, // Mantiene la foto de perfil actual
      );

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(
        // Actualiza Firestore con el nuevo nombre de usuario
        {
          'username': _usernameController.text.trim(),
        },
        SetOptions(
            merge: true), // Asegura que solo se actualice el campo especificado
      );

      ScaffoldMessenger.of(context).showSnackBar(
        // Muestra un mensaje de éxito
        SnackBar(content: Text('Nombre de usuario actualizado')),
      );
      setState(
          () {}); // Actualiza el estado para reflejar cambios en la interfaz
    }
  }

  // Método para cambiar la contraseña
  Future<void> _changePassword() async {
    if (user != null) {
      if (_newPasswordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        // Verifica que las contraseñas coincidan
        try {
          await user!.updatePassword(
              _newPasswordController.text.trim()); // Cambia la contraseña
          ScaffoldMessenger.of(context).showSnackBar(
            // Muestra un mensaje de éxito
            SnackBar(content: Text('Contraseña cambiada con éxito')),
          );
        } catch (e) {
          // Maneja errores
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al cambiar la contraseña: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          // Muestra un mensaje de error si las contraseñas no coinciden
          SnackBar(content: Text('Las contraseñas no coinciden')),
        );
      }
    }
  }

  // Método para seleccionar una imagen
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
        source:
            ImageSource.gallery); // Abre la galería para seleccionar una imagen
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Almacena la imagen seleccionada
      });
      await _uploadImage(); // Llama al método para subir la imagen
    }
  }

  // Método para subir la imagen seleccionada a Firebase Storage
  Future<void> _uploadImage() async {
    if (user != null && _image != null) {
      try {
        // Subir la imagen a Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child(
            'profile_images/${user!.uid}.jpg'); // Ruta donde se almacenará la imagen
        await storageRef.putFile(_image!); // Sube la imagen

        // Obtener la URL de la imagen subida
        String downloadUrl = await storageRef.getDownloadURL();

        // Actualizar el perfil del usuario con la nueva URL de la imagen
        await user!.updateProfile(
          displayName:
              _usernameController.text.trim(), // Mantener el nombre de usuario
          photoURL: downloadUrl, // Actualizar la foto de perfil
        );

        // Actualizar la base de datos Firestore
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(
          {
            'photoURL':
                downloadUrl, // Actualiza la URL de la imagen en Firestore
            'username': _usernameController.text
                .trim(), // Asegurarse de que se actualice el nombre de usuario
          },
          SetOptions(
              merge:
                  true), // Asegura que solo se actualice el campo especificado
        );

        ScaffoldMessenger.of(context).showSnackBar(
          // Muestra un mensaje de éxito
          SnackBar(content: Text('Foto de perfil actualizada')),
        );
        setState(() {}); // Actualiza el estado para reflejar los cambios
      } catch (e) {
        // Maneja errores
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar la foto de perfil: $e')),
        );
      }
    }
  }

  // Método para construir la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración')), // Título de la página
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Espaciado alrededor de los elementos
        child: Column(
          children: [
            GestureDetector(
              // Permite detectar toques en el avatar
              onTap: _pickImage, // Llama al método para seleccionar imagen
              child: CircleAvatar(
                radius: 50, // Radio del círculo
                backgroundImage: _image !=
                        null // Si hay una imagen seleccionada, la muestra
                    ? FileImage(_image!)
                    : (user?.photoURL !=
                            null // Si hay una URL de imagen, la muestra
                        ? NetworkImage(user!.photoURL!)
                        : AssetImage(
                                'assets/profile_image.png') // Muestra una imagen por defecto
                            as ImageProvider),
              ),
            ),
            SizedBox(height: 16), // Espacio entre elementos
            TextField(
              controller:
                  _usernameController, // Controlador para el campo de nombre de usuario
              decoration: InputDecoration(
                  labelText: 'Nombre de usuario'), // Etiqueta del campo
            ),
            SizedBox(height: 16), // Espacio entre elementos
            ElevatedButton(
              onPressed:
                  _updateUsername, // Llama al método para actualizar el nombre de usuario al presionar
              child: Text('Actualizar Nombre de Usuario'), // Texto del botón
            ),
            SizedBox(height: 32), // Espacio entre elementos
            TextField(
              controller:
                  _newPasswordController, // Controlador para la nueva contraseña
              obscureText: true, // Oculta el texto de la contraseña
              decoration: InputDecoration(
                  labelText: 'Nueva Contraseña'), // Etiqueta del campo
            ),
            TextField(
              controller:
                  _confirmPasswordController, // Controlador para confirmar la nueva contraseña
              obscureText: true, // Oculta el texto de la contraseña
              decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña'), // Etiqueta del campo
            ),
            SizedBox(height: 16), // Espacio entre elementos
            ElevatedButton(
              onPressed:
                  _changePassword, // Llama al método para cambiar la contraseña al presionar
              child: Text('Cambiar Contraseña'), // Texto del botón
            ),
          ],
        ),
      ),
    );
  }
}
