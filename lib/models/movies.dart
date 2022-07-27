// To parse this JSON data, do
//
//     final movies = moviesFromJson(jsonString);

import 'dart:convert';

List<Movies> moviesFromJson(String str) =>
    List<Movies>.from(json.decode(str).map((x) => Movies.fromJson(x)));

String moviesToJson(List<Movies> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movies {
    Movies({
        this.idMovie,
      this.name,
      this.dateCreated,
      this.poster,
      this.review,
      this.comment,
      this.involved,
      this.qualifiaction,
    });

    int idMovie;
    String name;
    DateTime dateCreated;
    String poster;
    String review;
    List<Comment> comment;
    List<Involved> involved;
    List<Qualifiaction> qualifiaction;

    factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        idMovie: json["idMovie"],
        name: json["name"],
        dateCreated: json['dateCreated'] == null ? null : DateTime.parse(json['dateCreated'] as String),
        //dateCreated: DateTime.parse(json["dateCreated"]),
        poster: json["poster"],
        review: json["review"],
        //comment: List<Comment>.from(json["comment"].map((x) => Comment.fromJson(x))),
        comment: json["comment"] != null ? new List<Comment>.from( json["comment"].map((x) => Comment.fromJson(x))) : List<Comment>(),
        //involved: List<Involved>.from(json["involved"].map((x) => Involved.fromJson(x))),
        involved: json["involved"] != null ? new List<Involved>.from( json["involved"].map((x) => Involved.fromJson(x))) : List<Involved>(),
        //qualifiaction: List<Qualifiaction>.from(json["qualifiaction"].map((x) => Qualifiaction.fromJson(x))),
        qualifiaction: json["qualifiaction"] != null ? new List<Qualifiaction>.from( json["qualifiaction"].map((x) => Qualifiaction.fromJson(x))) : List<Qualifiaction>(),
    );

    Map<String, dynamic> toJson() => {
        "idMovie": idMovie,
        "name": name,
        "dateCreated": dateCreated.toIso8601String(),
        "poster": poster,
        "review": review,
        "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
        "involved": List<dynamic>.from(involved.map((x) => x.toJson())),
        "qualifiaction": List<dynamic>.from(qualifiaction.map((x) => x.toJson())),
    };
}

class Comment {
    Comment({
      this.idComment,
      this.comment1,
      this.dateCreated,
      this.idMovie,
      this.userName,
      this.parentIdComment,
    });

    int idComment;
    String comment1;
    DateTime dateCreated;
    int idMovie;
    String userName;
    int parentIdComment;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        idComment: json["idComment"],
        comment1: json["comment1"],
        dateCreated: json['dateCreated'] == null ? null : DateTime.parse(json['dateCreated'] as String),
        idMovie: json["idMovie"],
        userName: json["userName"],
        parentIdComment: json["parentIdComment"],
    );

    Map<String, dynamic> toJson() => {
        "idComment": idComment,
        "comment1": comment1,
        "dateCreated": dateCreated.toIso8601String(),
        "idMovie": idMovie,
        "userName": userName,
        "parentIdComment": parentIdComment,
    };
}

class Involved {
    Involved({
      this.idInvolved,
      this.idWorker,
      this.idMovie,
      this.idRol,
      this.idRolNavigation,
      this.idWorkerNavigation,
    });

    int idInvolved;
    int idWorker;
    int idMovie;
    int idRol;
    IdRolNavigation idRolNavigation;
    IdWorkerNavigation idWorkerNavigation;

    factory Involved.fromJson(Map<String, dynamic> json) => Involved(
        idInvolved: json["idInvolved"],
        idWorker: json["idWorker"],
        idMovie: json["idMovie"],
        idRol: json["idRol"],
        idRolNavigation: IdRolNavigation.fromJson(json["idRolNavigation"]),
        idWorkerNavigation: IdWorkerNavigation.fromJson(json["idWorkerNavigation"]),
    );

    Map<String, dynamic> toJson() => {
        "idInvolved": idInvolved,
        "idWorker": idWorker,
        "idMovie": idMovie,
        "idRol": idRol,
        "idRolNavigation": idRolNavigation.toJson(),
        "idWorkerNavigation": idWorkerNavigation.toJson(),
    };
}

class IdRolNavigation {
    IdRolNavigation({
      this.idRol,
      this.name,
    });

    int idRol;
    String name;

    factory IdRolNavigation.fromJson(Map<String, dynamic> json) => IdRolNavigation(
        idRol: json["idRol"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "idRol": idRol,
        "name": name,
    };
}

class IdWorkerNavigation {
    IdWorkerNavigation({
      this.idWorker,
      this.name,
      this.pageWeb,
      this.facebook,
      this.twitter,
    });

    int idWorker;
    String name;
    String pageWeb;
    String facebook;
    String twitter;

    factory IdWorkerNavigation.fromJson(Map<String, dynamic> json) => IdWorkerNavigation(
        idWorker: json["idWorker"],
        name: json["name"],
        pageWeb: json["pageWeb"],
        facebook: json["facebook"],
        twitter: json["twitter"],
    );

    Map<String, dynamic> toJson() => {
        "idWorker": idWorker,
        "name": name,
        "pageWeb": pageWeb,
        "facebook": facebook,
        "twitter": twitter,
    };
}

class Qualifiaction {
    Qualifiaction({
      this.idQualification,
      this.idMovie,
      this.idExpert,
      this.qualification,
    });

    int idQualification;
    int idMovie;
    int idExpert;
    int qualification;

    factory Qualifiaction.fromJson(Map<String, dynamic> json) => Qualifiaction(
        idQualification: json["idQualification"],
        idMovie: json["idMovie"],
        idExpert: json["idExpert"],
        qualification: json["qualification"],
    );

    Map<String, dynamic> toJson() => {
        "idQualification": idQualification,
        "idMovie": idMovie,
        "idExpert": idExpert,
        "qualification": qualification,
    };
}
