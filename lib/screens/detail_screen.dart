import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project_cinema_app/models/movie.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF27272a),
      appBar: AppBar(
        title: const Center(child: Text('Detail')),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Handle share button press
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                      color: Colors.amber,
                      height: 300,
                      width: double.infinity,
                      child: Image.network(
                        movie.artworkUrl100.replaceAll('100x100', '200x300'),
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          // Handle the error, for example, display a placeholder image
                          return Container(
                            color: Colors.amber, // Placeholder color
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
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movie.trackName,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "25k",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                      ]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: Text("Comedy",
                            style: GoogleFonts.aBeeZee(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600))),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text("Crime",
                            style: GoogleFonts.aBeeZee(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600))),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Synopsis ${movie.trackName}",
                        style: GoogleFonts.aBeeZee(
                            color: Colors.white, fontSize: 20)),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(movie.longDescription,
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white54, fontSize: 16)),
                    )),
              ]),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size.fromHeight(64.0)),
            ),
            child: const Text(
              'Buy Ticket',
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
