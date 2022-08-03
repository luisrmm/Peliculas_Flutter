import 'package:app_peliculas/constants/app_colors.dart';
import 'package:app_peliculas/models/movies.dart';
import 'package:app_peliculas/services/comment_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentSrceen extends StatefulWidget {
  @override
  State<CommentSrceen> createState() => _CommentSrceen();
}

class _CommentSrceen extends State<CommentSrceen> {
  final _formComment = GlobalKey<FormState>();
  TextEditingController textarea = TextEditingController();
  List<Comment> comment = [];
  List<Comment> comment2 = [];
  String newComment;
  List<Comment> _comments = [];
  Comment commentInput = new Comment(
      idComment: 0,
      comment1: "",
      dateCreated: DateTime.now(),
      idMovie: 0,
      userName: "",
      parentIdComment: 0);
  int idMovie = 0;
  bool fromContext = true;
  @override
  Widget build(BuildContext context) {
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    );

    if (fromContext == true) {
      setState(() {
        _comments = ModalRoute.of(context).settings.arguments;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('CineMark'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 500,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(20),
                itemCount: this._comments.length,
                itemBuilder: (context, index) {
                  this.idMovie = this._comments[index].idMovie;
                  return Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5))
                    ]),
                    child: Card(
                      shape: border,
                      child: ListTile(
                        title: Text(this._comments[index].userName + ": "),
                        subtitle: Text(this._comments[index].comment1),
                      ),
                    ),
                  );
                },
              ),
            ),
            //SizedBox(height: 20),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formComment,
                      child: Column(
                        children: [
                          TextFormField(
                            maxLength: 140,
                            autocorrect: false,
                            controller: textarea,
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.secondaryColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.primaryColor, width: 2),
                              ),
                              hintText: "Ej: Buena pelicula",
                              labelText: "Comentario",
                              prefixIcon: Icon(Icons.message_outlined),
                            ),
                            onSaved: (value) {
                              newComment = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese el usuario';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            disabledColor: Colors.grey,
                            color: AppColors.secondaryColor,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              child: Text(
                                'Comentar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              if (textarea.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg:
                                      "Error, debe realizar un comentario", // message
                                  toastLength: Toast.LENGTH_LONG, // length
                                  gravity: ToastGravity.CENTER, // location
                                  timeInSecForIosWeb: 4,
                                  backgroundColor: Colors.red, // duration
                                );
                              } else {
                                _handleSubmitted();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      ///Aquie llega
    );
  }

  void _getAllComment() {
    CommentService.getComments(this.idMovie).then((value) => {
          setState(() {
            this._comments = value;
          })
        });
  }

  void _handleSubmitted() async {
    final FormState form = _formComment.currentState;
    if (form.validate().toString().isEmpty) {
      Fluttertoast.showToast(
          msg: "Error llene el formulario correctamente", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
          timeInSecForIosWeb: 1 // duration
          );
    } else {
      form.save();
      textarea.clear();
      this.fromContext = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.commentInput.userName = prefs.getString('userName');
      this.commentInput.idMovie = this.idMovie;
      this.commentInput.comment1 = this.newComment;
      CommentService.createComment(commentInput)
          .then((value) => {_getAllComment()});
    }
  }
}
