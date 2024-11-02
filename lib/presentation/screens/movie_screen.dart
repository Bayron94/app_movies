import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:test_app_2024/config/theme/app_theme.dart';

const String apiKey = 'a5c8c9ea4fba4e0ebf46b3c872c0feae';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieID});

  final String movieID;
  static const name = 'movie-detail';

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final Dio _dio = Dio();
  Map<String, dynamic>? movieDetails;
  List<dynamic> castList = [];

  @override
  void initState() {
    super.initState();
    fetchMovieDetail();
    fetchMovieCast();
  }

  Future<void> fetchMovieDetail() async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/${widget.movieID}',
        queryParameters: {
          'api_key': apiKey,
        },
      );
      setState(() {
        movieDetails = response.data;
      });
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }

  Future<void> fetchMovieCast() async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/${widget.movieID}/credits',
        queryParameters: {
          'api_key': apiKey,
        },
      );
      setState(() {
        castList = response.data['cast'];
      });
    } catch (e) {
      throw Exception('Failed to load movie cast: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: movieDetails == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      movieDetails!['title'] ?? 'Título desconocido',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${movieDetails!['backdrop_path']}',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Género: ${movieDetails!['genres'].map((g) => g['name']).join(', ')}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.yellow, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  'Rating: ${movieDetails!['vote_average']}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Sinopsis',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movieDetails!['overview'] ?? 'Sin descripción',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Reparto',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: castList.length,
                                itemBuilder: (context, index) {
                                  final actor = castList[index];
                                  return Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                            actor['profile_path'] != null
                                                ? 'https://image.tmdb.org/t/p/w200${actor['profile_path']}'
                                                : 'https://via.placeholder.com/100', // Imagen por defecto
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          actor['name'] ?? 'Nombre desconocido',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: customSecondaryColor,
                                ),
                                onPressed: () async {
                                  /* final url = Uri.parse(
                                                        "https://www.google.com/search?q=${movie['title']}");
                                                    if (await canLaunch(url.toString())) {
                                                      await launch(url.toString());
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    } */
                                },
                                child: const Text(
                                  'Ver más información en la web',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
