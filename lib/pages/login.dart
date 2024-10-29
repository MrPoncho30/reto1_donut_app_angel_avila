// Importación de la librería Material de Flutter, que contiene widgets básicos de diseño.
import 'package:flutter/material.dart';
// Importación de la librería de autenticación de Firebase.
import 'package:firebase_auth/firebase_auth.dart';
// Importación de la página de inicio (home_page.dart), la cual se usará tras el inicio de sesión.
import 'home_page.dart';
// Importación de la librería para autenticación con Google.
import 'package:google_sign_in/google_sign_in.dart';
// Importación de iconos de Font Awesome para usar en el diseño.
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Definición de la clase LoginScreen, que es un widget sin estado.
class LoginScreen extends StatelessWidget {
  // Controlador para manejar el texto ingresado en el campo de correo electrónico.
  final TextEditingController emailController = TextEditingController();
  // Controlador para manejar el texto ingresado en el campo de contraseña.
  final TextEditingController passwordController = TextEditingController();

  // Método para registrar un nuevo usuario en Firebase Authentication.
  Future<void> _register(BuildContext context) async {
    try {
      // Creación de un nuevo usuario con el correo y contraseña ingresados.
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), // Elimina espacios en blanco
        password: passwordController.text.trim(), // Elimina espacios en blanco
      );

      // Si el usuario se crea con éxito, redirige a la HomePage.
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      // En caso de error, muestra un mensaje de error en la pantalla.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de registro: ${e.toString()}')),
      );
    }
  }

  // Método para iniciar sesión con Google.
  Future<void> _signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn(); // Crea una instancia de GoogleSignIn.
    final GoogleSignInAccount? googleUser =
        await googleSignIn.signIn(); // Solicita la autenticación del usuario.

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication; // Obtiene la autenticación de Google.

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, // Token de acceso de Google.
        idToken: googleAuth.idToken, // ID token de Google.
      );

      // Inicia sesión con la credencial de Google.
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Establece el color de fondo de la pantalla.
      backgroundColor: Colors.orange[100],
      // Centra el contenido en la pantalla.
      body: Center(
        child: Padding(
          // Define un padding horizontal alrededor del contenido.
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          // Column para organizar los elementos en orden vertical.
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centra los elementos verticalmente.
            children: <Widget>[
              // Icono de comida rápida con tamaño y color específicos.
              Icon(
                Icons.fastfood,
                color: Colors.red[700],
                size: 100.0,
              ),
              const SizedBox(height: 16.0), // Espacio entre widgets.
              // Texto de bienvenida a la aplicación.
              const Text(
                'Bienvenido a AlanApp',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 32.0), // Espacio entre widgets.
              // Campo de texto para ingresar el correo electrónico.
              TextField(
                controller:
                    emailController, // Asigna el controlador para manejar el texto.
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico', // Etiqueta del campo.
                  prefixIcon: Icon(Icons.email,
                      color: Colors.red[700]), // Icono del campo.
                  border: OutlineInputBorder(), // Borde del campo.
                  filled: true,
                  fillColor: Colors.white, // Color de fondo del campo.
                ),
              ),
              const SizedBox(height: 16.0), // Espacio entre widgets.
              // Campo de texto para ingresar la contraseña, con texto oculto.
              TextField(
                controller:
                    passwordController, // Asigna el controlador para manejar el texto.
                obscureText: true, // Oculta el texto ingresado.
                decoration: InputDecoration(
                  labelText: 'Contraseña', // Etiqueta del campo.
                  prefixIcon: Icon(Icons.lock,
                      color: Colors.red[700]), // Icono del campo.
                  border: OutlineInputBorder(), // Borde del campo.
                  filled: true,
                  fillColor: Colors.white, // Color de fondo del campo.
                ),
              ),
              const SizedBox(height: 32.0), // Espacio entre widgets.
              // Botón para iniciar sesión.
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Intenta iniciar sesión con Firebase usando el correo y contraseña ingresados.
                    final userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text
                          .trim(), // Elimina espacios en blanco.
                      password: passwordController.text
                          .trim(), // Elimina espacios en blanco.
                    );

                    // Si el inicio de sesión es exitoso, redirige a la HomePage.
                    if (userCredential.user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  } catch (e) {
                    // En caso de error, muestra un mensaje de error.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Error de inicio de sesión: ${e.toString()}')),
                    );
                  }
                },
                // Configuración del estilo del botón de inicio de sesión.
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700], // Color de fondo del botón.
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80, vertical: 12), // Padding del botón.
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5.0), // Bordes redondeados.
                  ),
                ),
                // Texto mostrado en el botón.
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Color del texto.
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Espacio entre widgets.
              // Botón para registrarse, ejecuta el método _register.
              ElevatedButton(
                onPressed: () =>
                    _register(context), // Llama al método de registro.
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green[700], // Color de fondo del botón.
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80, vertical: 12), // Padding del botón.
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5.0), // Bordes redondeados.
                  ),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Color del texto.
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Espacio entre widgets.
              // Botón de inicio de sesión con Google.
              ElevatedButton(
                onPressed: () => _signInWithGoogle(
                    context), // Llama al método de inicio de sesión con Google.
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Color de fondo del botón.
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5.0), // Bordes redondeados.
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Ajusta el tamaño del Row al contenido.
                  children: const [
                    FaIcon(FontAwesomeIcons.google,
                        color: Colors.white), // Icono de Google.
                    SizedBox(width: 2), // Espacio entre icono y texto.
                  ],
                ),
              ),

              const SizedBox(height: 16.0), // Espacio entre widgets.
              // Botón de texto para continuar sin autenticarse.
              TextButton(
                onPressed: () {
                  // Redirige a la HomePage sin autenticación.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text(
                  'Continuar como Invitado',
                  style: TextStyle(color: Colors.brown), // Color del texto.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
