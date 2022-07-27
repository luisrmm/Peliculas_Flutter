import 'package:flutter/material.dart';
import 'package:app_peliculas/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineMark',
      initialRoute: '/',
      routes: getRoutes(),
    );
  }
}