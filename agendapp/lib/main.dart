import 'package:agendapp/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mi Agenda',
        // home: Login(),
        initialRoute: 'login',
        routes: {'login': (BuildContext context) => const Login()});
  }
}
