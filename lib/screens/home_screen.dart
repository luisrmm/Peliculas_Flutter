import 'package:app_peliculas/constants/app_colors.dart';
import 'package:app_peliculas/models/movies.dart';
import 'package:flutter/material.dart';
import 'package:app_peliculas/services/movies_service.dart';
import 'package:app_peliculas/widgets/carrd_swiper_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Movies>> movies;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cinemark"),
        backgroundColor: AppColors.primaryColor,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: _handleLogout,
                child: Icon(
                  Icons.logout_outlined,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _swipeTarjetas(),
        ],
      ),
    );
  }

  Widget _swipeTarjetas() {
    return FutureBuilder(
        future: movies = MoviesServices.getMovies(),
        builder: (BuildContext context, AsyncSnapshot snapshop) {
          if (snapshop.hasData) {
            return CardSwiper(
              movies: snapshop.data,
            );
          } else {
            return const SizedBox(
                height: 400.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          }
        });
  }

   void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userName');
    Navigator.pushNamedAndRemoveUntil(
        context, '/', ModalRoute.withName('/'));
  }
}
