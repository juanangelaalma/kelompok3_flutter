import 'package:coolapp/models/movie.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(),
            // body: buildBody(),
          )
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {}
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Container(
          height: 500,
          width: 400,
          child: Image.asset(
            movie.poster,
          ),
        )
      ]
    );
  }
}