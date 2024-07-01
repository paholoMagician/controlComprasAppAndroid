import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Variable de estado para el spinner

  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Mostrar el spinner
    });

    final String email = _emailController.text;
    final String password = _passwordController.text;

    final url = Uri.parse('https://rpsoftdev.store/api/Usuario/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    setState(() {
      _isLoading = false; // Ocultar el spinner
    });

    if (response.statusCode == 200) {
      _showAlert('Ingreso exitoso', 'Has ingresado correctamente.');
    } else {
      _showAlert('Error', 'Hubo un error al enviar los datos.');
    }
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingreso'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Espacio para el logotipo
              SizedBox(
                height: 250,
                child: Center(
                  child: Image.asset(
                    'lib/assets/logo.jpg', // Cambia la ruta a tu imagen de logotipo
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple, // Fondo púrpura
                    borderRadius:
                        BorderRadius.circular(8.0), // Bordes redondeados
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'CONTROL DE COMPRAS ONLINE',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white, // Letras de color blanco
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.orange, // Color del borde inferior
                      width: 2.0, // Ancho del borde inferior
                    ),
                  ),
                ),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Ingresa tu email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        _isLoading
                            ? const CircularProgressIndicator() // Spinner
                            : ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Colors.purple, // Letras de color blanco
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: _login,
                                icon: const Icon(Icons.done), // Ícono de 'done'
                                label: const Text('Entrar'),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
