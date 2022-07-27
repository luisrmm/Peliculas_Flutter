import 'package:flutter/material.dart';
import 'package:app_peliculas/screens/home_screen.dart';
import 'package:app_peliculas/screens/login_screen.dart';
import 'package:app_peliculas/screens/details_movie.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginScreen(),
    'home': (BuildContext context) =>  HomeScreen(),
    'detalle': (BuildContext context) =>  DetailsMoviesScreen(),
  };
}