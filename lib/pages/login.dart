import 'package:flutter/material.dart'; // Importa el paquete Flutter para UI.
import 'package:firebase_auth/firebase_auth.dart'; // Importa el paquete Firebase Authentication.
import 'home_page.dart'; // Importa la página principal de la app.
import 'package:google_sign_in/google_sign_in.dart'; // Importa el paquete para autenticación con Google.
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importa íconos de FontAwesome.

// Define la clase LoginScreen como un StatelessWidget.
class LoginScreen extends StatelessWidget {
  // Controladores para los campos de entrada de email y contraseña.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Método para registrar un usuario nuevo con Firebase.
  Future<void> _register(BuildContext context) async {
    try {
      // Crea una nueva cuenta de usuario usando email y contraseña.
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), // Elimina espacios del email.
        password: passwordController.text
            .trim(), // Elimina espacios de la contraseña.
      );

      // Si el registro es exitoso, navega a HomePage.
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      // Muestra un mensaje de error si el registro falla.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de registro')),
      );
    }
  }

  // Método para iniciar sesión con Google.
  Future<void> _signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Inicia sesión con Firebase usando las credenciales de Google.
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  // Método para restablecer la contraseña del usuario.
  Future<void> _resetPassword(BuildContext context) async {
    try {
      // Envía un correo de restablecimiento de contraseña.
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Se ha enviado un correo para restablecer la contraseña')),
      );
    } catch (e) {
      // Muestra un mensaje de error si falla el restablecimiento.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Error al restablecer la contraseña. Por favor escribe tu correo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 158, 220, 226), // Color de fondo de la pantalla.
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.fastfood, // Icono principal.
                color: Colors.red[700],
                size: 100.0,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Bienvenido a AlanApp', // Título principal de la pantalla.
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 32.0),
              // Campo de entrada para el correo electrónico.
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email, color: Colors.red[700]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              // Campo de entrada para la contraseña.
              TextField(
                controller: passwordController,
                obscureText: true, // Oculta la contraseña.
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock, color: Colors.red[700]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              // Botón para restablecer la contraseña.
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _resetPassword(context),
                  child: const Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              // Botón para iniciar sesión.
              ElevatedButton(
                onPressed: () async {
                  try {
                    final userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );

                    if (userCredential.user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error de inicio de sesión.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16.0),
              // Botón para registrarse.
              ElevatedButton(
                onPressed: () => _register(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 5.0),
              // Botón para iniciar sesión con Google.
              ElevatedButton(
                onPressed: () => _signInWithGoogle(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    FaIcon(FontAwesomeIcons.google, color: Colors.white),
                    SizedBox(width: 2),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              // Botón para continuar como invitado.
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text(
                  'Continuar como Invitado',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
