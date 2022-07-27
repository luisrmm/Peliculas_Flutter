import 'package:app_peliculas/models/movies.dart';
import 'package:http/http.dart' as http;

class MoviesServices{
  static final urlServicio = 'https://apimovie.somee.com/api/Movies/proc';

  static Future <List<Movies>> getMovies() async {
    var url = Uri.parse(urlServicio);
    final response =  await http.get(url);
    if(response.statusCode == 200){
      List<Movies> movies = moviesFromJson(response.body);
      return movies;
    }else{
      return null;
    }
  }
}