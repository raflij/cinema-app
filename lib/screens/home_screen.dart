// home screen
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project_cinema_app/category_list.dart';
import 'package:mini_project_cinema_app/models/movie.dart';
import 'package:mini_project_cinema_app/screens/detail_screen.dart';
import 'package:http/http.dart' as http;

class MovieState {
  final List<Movie> movies;

  MovieState(this.movies);
}

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieState([]));

  Future<List<Movie>> searchMovies(String term) async {
    final response = await http.get(
      Uri.parse('https://itunes.apple.com/search?term=$term&entity=movie'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      final List<Movie> movies = results.map((result) {
        return Movie(
          trackName: result['trackName'],
          artworkUrl100: result['artworkUrl100'],
          longDescription: result['longDescription'] ?? "",
        );
      }).toList();

      emit(MovieState(movies));
      return movies;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final MovieCubit movieCubit = MovieCubit();

  @override
  void dispose() {
    movieCubit.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => movieCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF27272a),
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 24),
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // Align the content to the left
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: const DecorationImage(
                                          image:
                                              AssetImage("assets/9440461.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 2,
                                      top: 2,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          // color: kButtonCol
                                        ),
                                        height: 10,
                                        width: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to the left
                                  children: [
                                    Text(
                                      "Welcome",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "Kim Na - Young",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/notification');
                                  },
                                  child: Stack(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.bell_fill,
                                        color: Colors.white,
                                      ),
                                      Positioned(
                                        right: 2,
                                        top: 2,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors
                                                .amber, // Adjust color as needed
                                          ),
                                          height: 10,
                                          width: 10,
                                          child: const Center(
                                            child: Text(
                                              '.', // You can use any text or icon as per your preference
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                    child: const Icon(
                                      CupertinoIcons.power,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      logout(context);
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF404040),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextFormField(
                            autofocus: false,
                            controller: searchController,
                            onChanged: (value) {},
                            style: GoogleFonts.aBeeZee(
                                color: Colors.white, fontSize: 18),
                            decoration: const InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.white),
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              suffixIcon: Icon(
                                Icons.mic,
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Categories',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 25, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CategoryList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Popular',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 25, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return FutureBuilder<List<Movie>>(
                              future: context.read<MovieCubit>().searchMovies(
                                    searchController.text.isNotEmpty
                                        ? searchController.text
                                        : 'iron man',
                                  ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final List<Movie> movies = snapshot.data!;

                                  return Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              movie: movies[index],
                                            ),
                                          ),
                                        );
                                        // debugPrint(movies[index].longDescription);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          color: Colors.amber,
                                          height: 300,
                                          width: 220,
                                          child: AspectRatio(
                                            aspectRatio: 220 /
                                                300, // Set the aspect ratio
                                            child: Image.network(
                                              movies[index]
                                                  .artworkUrl100
                                                  .replaceAll(
                                                      '100x100', '200x300'),
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                // Handle the error, for example, display a placeholder image
                                                return Container(
                                                  color: Colors
                                                      .amber, // Placeholder color
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.error,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF18181b),
                  icon: Icon(
                    FontAwesomeIcons.house,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.calendar,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.ticket,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.user,
                  ),
                  label: "",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/');
  }
}
