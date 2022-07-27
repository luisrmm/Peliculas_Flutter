import 'package:flutter/material.dart';
import 'package:app_peliculas/models/movies.dart';

class DetailsMoviesScreen extends StatelessWidget {
  const DetailsMoviesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movies movie = ModalRoute.of(context).settings.arguments as Movies;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 10.0),
            _posterTitulo(context, movie),
            _descripcion(movie)
          ])),
        ],
      ),
    );
  }

  Widget _crearAppBar(Movies movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.name,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.poster),
          placeholder: const AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Movies movies) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Hero(
              tag: movies.idMovie,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(movies.poster),
                  height: 100.0,
                ),
              )),
          const SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                movies.name,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.star_border_outlined),
                  Text(
                    movies.qualifiaction.map((e) => e.qualification).toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
              Text(
                movies.dateCreated
                    .toString()
                    .substring(0, movies.dateCreated.toString().length - 13),
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(Movies movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.review,
        textAlign: TextAlign.center,
      ),
    );
  }

  /* Widget _crearCasting(Movies movies){
    return FutureBuilder(
      future: movies.involved,
      builder: (context, AsyncSnapshot snapshot){
        return _createActoresPageView(snapshot.data);
      });
  }

  Widget _createActoresPageView(List<Involved> involved){
    return const SizedBox();
  } */
}
