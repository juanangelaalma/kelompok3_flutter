import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'constants.dart';
import 'dart:math' as math;

import 'package:http/http.dart' as http;

import 'package:coolapp/models/movie.dart';
import 'movie_card.dart';

List<List> categories = [["In Theater", "now_playing"], ["Popular", "popular"], ["Coming Soon", "upcoming"]];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Navbar(),
        appBar: buildAppBar(context),
        body: Body()
      ),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      // leading: IconButton(
      //   padding: EdgeInsets.only(left: kDefaultPadding),
      //   icon: SvgPicture.asset("assets/icons/menu.svg"),
      //   onPressed: () => {},
      // ),
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE63946),
                  Color(0xFF457b9d),
                ],
              ),
            ),
            accountName: Text("Juan Angela Alma"), 
            accountEmail: Text("juanangelaalma@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: kSecondaryColor,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/user.jpg"),
                radius: 50.0,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.grey,),
            title: Text('Favorites'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.movie_sharp, color: Colors.grey,),
            title: Text('Movies'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.grey,),
            title: Text('Reviews'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.grey,),
            title: Text('Log Out'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedCategory = 0;
  List<List> categories = [["In Theater", "now_playing"], ["Popular", "popular"], ["Coming Soon", "upcoming"]];

  void _manageState(value) {
    setState(() {
      selectedCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CategoryList(categories: categories, onClickCategory: _manageState, selectedCategory: selectedCategory),
          Genres(),
          SizedBox(height: kDefaultPadding,),
          MovieCarousel(selectedCategory: selectedCategory),
        ],
      )
    );
  }
}


class CategoryList extends StatelessWidget {
  var categories;
  var selectedCategory;
  
  final ValueChanged onClickCategory;

  void manageState(value) {
    onClickCategory(value);
  }

  CategoryList({Key? key, this.categories, required this.onClickCategory, required this.selectedCategory}) : super(key: key); 
  
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding / 2),
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index, context, manageState),
      ),
    );
  }

  Padding buildCategory(int index, BuildContext context, manageState){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: GestureDetector(
        onTap: () => manageState(index),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index][0],
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: index == selectedCategory
                        ? kTextColor
                        : Colors.black.withOpacity(0.4),
              ),
            ),
             Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              height: 6,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: index == selectedCategory
                    ? kSecondaryColor
                    : Colors.transparent,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: index == selectedCategory
                      ? [
                          Color(0xFFE63946),
                          Color(0xFF457b9d),
                        ]
                      : [
                          Colors.transparent,
                          Colors.transparent,
                        ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  final String genre;

  const GenreCard({key, required this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4, // 5 padding top and bottom
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        genre,
        style: TextStyle(color: kTextColor.withOpacity(0.8), fontSize: 16),
      ),
    );
  }
}

class Genres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> genres = [
      "Action",
      "Crime",
      "Comedy",
      "Drama",
      "Horror",
      "Animation"
    ];

    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) => GenreCard(genre: genres[index]),
      ),
    );
  }
}

class MovieCarousel extends StatefulWidget {
  final int selectedCategory;

  const MovieCarousel({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  _MovieCarouselState createState() => _MovieCarouselState(selectedCategory);
}

class _MovieCarouselState extends State<MovieCarousel> {
  late PageController _pageController;
  int initialPage = 1;
  late Future<List<Movie>> mooooviess;
  late List<Movie> values;
  String category = "no_playing";

  _MovieCarouselState(int selectedCategory) {
    if (selectedCategory == 0) {
      category = "now_playing";
    } else if (selectedCategory == 1) {
      category = "popular";
    } else if (selectedCategory == 2) {
      category = "upcoming";
    }
    // mooooviess = fetchMovies(category);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      // so that we can have small portion shown on left and right side
      viewportFraction: 0.8,
      // by default our movie poster
      initialPage: initialPage,
    );
    mooooviess = fetchMovies(category);
    print("type of mooovies is: ${mooooviess.runtimeType}");
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: AspectRatio(
        aspectRatio: 0.85,
        child: FutureBuilder(
          future: mooooviess,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    initialPage = value;
                  });
                },
                controller: _pageController,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => buildMovieSlider(index),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        )
      ),
    );
  }

  Future<List<Movie>> fetchMovies([selectedNow = "now_playing"]) async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/${selectedNow}?api_key=0ca75ba174c9f3648dffe5e8f05a3266"));
    if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    var results = body['results'];
    List<Movie> moviesResult = [];
    for (var movie in results) {
      moviesResult.add(Movie.fromJson(movie));
    }
    values = moviesResult;
    return moviesResult;
    } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movie');
  }
  }

  Widget buildMovieSlider(int index) => AnimatedBuilder(
    animation: _pageController,
    builder: (context, child) {
      double value = 0;
      if (_pageController.position.haveDimensions) {
        value = index - double.parse(_pageController.page.toString());
        value = (value * 0.038).clamp(-1, 1);
      }
      return AnimatedOpacity(
        duration: Duration(milliseconds: 350),
        opacity: initialPage == index ? 1 : 0.4,
        child: Transform.rotate(
          angle: math.pi * value,
          child: MovieCard(movie: values[index]),
        ),
      );
    },
  );
}