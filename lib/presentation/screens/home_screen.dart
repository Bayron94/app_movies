import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:test_app_2024/config/theme/app_theme.dart';
import 'package:test_app_2024/presentation/screens/movie_screen.dart';

const String apiKey = 'a5c8c9ea4fba4e0ebf46b3c872c0feae';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  static const name = 'movies';

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchMovies() async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/popular',
        queryParameters: {
          'api_key': apiKey,
        },
      );
      return response.data['results'];
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Populares'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final movies = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(
                  title: movie['title'],
                  posterPath: movie['poster_path'],
                  voteAverage: movie['vote_average'],
                  releaseDate: movie['release_date'],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailScreen(movieID: movie['id'].toString()),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: customBackground,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500$posterPath',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: customTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Fecha de lanzamiento: $releaseDate',
                      style:
                          const TextStyle(fontSize: 12, color: customHintColor),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: customSecondaryColor,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          voteAverage.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: customTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
