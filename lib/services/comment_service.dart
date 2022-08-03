import 'dart:convert';
import 'package:app_peliculas/models/comments.dart';
import 'package:app_peliculas/models/movies.dart';
import 'package:http/http.dart' as http;

class CommentService {
  static final urlServicio = 'https://apimovie.somee.com/api/Comments/Comment';
  //static final urlGetComments = 'https://apimovie.somee.com/api/Comments/';

  static Future<Comments> createComment(Comment c) async {
    String jsonStr = jsonEncode(c);
    var url = Uri.parse(urlServicio);
    await http.post(url,
        body: jsonStr,
        headers: {"Content-Type": "application/json"}).then((result) {
    });
    return null;
  }

  static Future <List<Comment>> getComments(int idMovie) async {
    var urlGetComments =
        'https://apimovie.somee.com/api/Comments/ ' + idMovie.toString();
    var url = Uri.parse(urlGetComments);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<Comment> comments = comments2FromJson(response.body);
      return comments;
    } else {
      return null;
    }
  }
}
