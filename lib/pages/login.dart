import 'package:flutter/material.dart'; // Importa el paquete de Material Design para Flutter.
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Authentication para manejar el registro y autenticación de usuarios.
import 'package:reto1_donut_app_angel_avila/pages/home_pageInvitado.dart';
import 'home_page.dart'; // Importa la página principal de la aplicación.
import 'package:google_sign_in/google_sign_in.dart'; // Importa Google Sign-In para permitir autenticación con Google.
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importa Font Awesome para usar íconos de redes sociales.

class LoginScreen extends StatelessWidget {
  // Controladores de texto para los campos de correo y contraseña.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Método para registrar un nuevo usuario.
  Future<void> _register(BuildContext context) async {
    try {
      // Crea un nuevo usuario con el correo y contraseña proporcionados.
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Envía un correo de verificación al usuario.
      await userCredential.user?.sendEmailVerification();

      // Muestra un mensaje de SnackBar informando que se ha enviado el correo de verificación.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Se ha enviado un correo de verificación.')),
      );
    } catch (e) {
      // Maneja errores y muestra un mensaje de error si ocurre un problema al registrarse.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de registro')),
      );
    }
  }

  // Método para iniciar sesión con correo y contraseña.
  Future<void> _signIn(BuildContext context) async {
    try {
      // Inicia sesión con el correo y contraseña proporcionados.
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Verifica si el usuario ha verificado su correo.
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        // Si está verificado, navega a la página principal.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Si no ha verificado su correo, muestra un mensaje para que lo haga.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor verifica tu correo.')),
        );
      }
    } catch (e) {
      // Maneja errores y muestra un mensaje de error si ocurre un problema al iniciar sesión.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de inicio de sesión')),
      );
    }
  }

  // Método para iniciar sesión con Google.
  Future<void> _signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn(); // Crea una instancia de GoogleSignIn.
    final GoogleSignInAccount? googleUser = await googleSignIn
        .signIn(); // Abre el flujo de inicio de sesión de Google.

    if (googleUser != null) {
      // Si el usuario ha iniciado sesión, obtiene la autenticación de Google.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Inicia sesión con las credenciales de Google.
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Navega a la página principal.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  // Método para restablecer la contraseña.
  Future<void> _resetPassword(BuildContext context) async {
    try {
      // Envía un correo para restablecer la contraseña.
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      // Muestra un mensaje de SnackBar informando que se ha enviado el correo.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Se ha enviado un correo para restablecer la contraseña')),
      );
    } catch (e) {
      // Maneja errores y muestra un mensaje de error si ocurre un problema al enviar el correo.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al restablecer la contraseña')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Establece un degradado de fondo para el contenedor.
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue, // Color superior del degradado.
              Colors.orange, // Color inferior del degradado.
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0, // Ancho del contenedor.
                  height: 100.0, // Altura del contenedor.
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.red,
                        width: 3.0), // Color y ancho del borde.
                    borderRadius: BorderRadius.circular(
                        10.0), // Radio de las esquinas redondeadas.
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0), // Asegúrate de que la imagen tenga esquinas redondeadas.
                    child: Image.asset(
                      'lib/images/alanfood.png', // Imagen de la aplicación.
                      fit: BoxFit
                          .cover, // Ajusta la imagen al tamaño del contenedor.
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Bienvenido a AlanFood', // Título de bienvenida.
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white), // Estilo del texto.
                ),
                const SizedBox(height: 32.0),
                TextField(
                  controller:
                      emailController, // Controlador para el campo de correo.
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico', // Etiqueta del campo.
                    prefixIcon: Icon(Icons.email,
                        color: Colors.red[700]), // Icono del campo.
                    border: OutlineInputBorder(), // Borde del campo.
                    filled: true, // Campo relleno.
                    fillColor: Colors.white, // Color de fondo del campo.
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller:
                      passwordController, // Controlador para el campo de contraseña.
                  obscureText: true, // Oculta el texto ingresado.
                  decoration: InputDecoration(
                    labelText: 'Contraseña', // Etiqueta del campo.
                    prefixIcon: Icon(Icons.lock,
                        color: Colors.red[700]), // Icono del campo.
                    border: OutlineInputBorder(), // Borde del campo.
                    filled: true, // Campo relleno.
                    fillColor: Colors.white, // Color de fondo del campo.
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _resetPassword(
                        context), // Llama al método de restablecimiento de contraseña.
                    child: const Text(
                      '¿Olvidaste tu contraseña?', // Texto del botón.
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  width: double.infinity, // Ancho completo.
                  child: ElevatedButton(
                    onPressed: () => _signIn(
                        context), // Llama al método de inicio de sesión.
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red[700], // Color de fondo del botón.
                      padding: const EdgeInsets.symmetric(
                          vertical: 12), // Relleno vertical.
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Esquinas redondeadas.
                      ),
                    ),
                    child: const Text(
                      'Iniciar Sesión', // Texto del botón.
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white), // Estilo del texto.
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity, // Ancho completo.
                  child: ElevatedButton(
                    onPressed: () =>
                        _register(context), // Llama al método de registro.
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green[700], // Color de fondo del botón.
                      padding: const EdgeInsets.symmetric(
                          vertical: 12), // Relleno vertical.
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Esquinas redondeadas.
                      ),
                    ),
                    child: const Text(
                      'Registrarse', // Texto del botón.
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white), // Estilo del texto.
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'o',
                  style: TextStyle(
                      color: Colors.white), // Texto "o" como separador.
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity, // Ancho completo.
                  child: ElevatedButton.icon(
                    icon: const FaIcon(
                      FontAwesomeIcons.google, // Ícono de Google.
                      color: Colors.white,
                    ),
                    onPressed: () => _signInWithGoogle(
                        context), // Llama al método de inicio de sesión con Google.
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue[600], // Color de fondo del botón.
                      padding: const EdgeInsets.symmetric(
                          vertical: 12), // Relleno vertical.
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Esquinas redondeadas.
                      ),
                    ),
                    label: const Text(
                      'Iniciar sesión con Google', // Texto del botón.
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white), // Estilo del texto.
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Reemplaza el botón "Iniciar como Invitado" con un texto que navega a la página principal.
                GestureDetector(
                  onTap: () async {
                    // Cierra la sesión actual si hay un usuario autenticado.
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await FirebaseAuth.instance
                          .signOut(); // Cierra la sesión del usuario actual.
                    }

                    // Navega a la página principal al tocar el texto.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage2()),
                    );
                  },
                  child: const Text(
                    'Iniciar como Invitado', // Texto que actuará como enlace.
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Estilo del texto.
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
