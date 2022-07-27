import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:app_peliculas/models/movies.dart';

class CardSwiper extends StatelessWidget {
  final List<Movies> movies;

  CardSwiper({this.movies});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: screenSize.width * 0.7,
          itemHeight: screenSize.height * 0.7,
          itemBuilder: (BuildContext context, int index) {
            return Hero(
                tag: movies[index].idMovie,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'detalle',
                            arguments: movies[index]);
                      },
                      child: Container(
                        child: ListView(
                          children: [
                            FadeInImage(
                              image: NetworkImage(movies[index].poster),
                              placeholder:
                                  const AssetImage('assets/img/no-image.jpg'),
                              fit: BoxFit.contain,
                            ),
                            Container(
                                padding: EdgeInsets.all(20),
                                //margin: EdgeInsets.symmetric(horizontal: 5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          offset: Offset(0, 5))
                                    ]),
                                child: Column(children: [
                                  Text(movies[index].name),
                                  SizedBox(height: 30),
                                  Text(movies[index].review),
                                  SizedBox(height: 30),
                                  Text(movies[index].dateCreated.toString().substring(0, movies[index].dateCreated.toString().length -13))
                                ])),
                          ],
                        ),
                      ),
                    )));
          },
          itemCount: movies.length,
          viewportFraction: 0.8,
          scale: 0.9),
    );
  }
}
