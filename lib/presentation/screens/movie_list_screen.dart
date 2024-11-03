import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app_2024/config/config.dart';
import 'package:test_app_2024/presentation/screens/movie_detail_screen.dart';
import 'package:test_app_2024/presentation/viewmodels/movie_list_viewmodel.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  static const name = 'movies';

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieListViewModel>(context, listen: false)
          .fetchPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MovieListViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Populares'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TODO(Bayron): No lo pude completar
                /* DropdownButton<String>(
                  hint: const Text('Seleccionar género'),
                  value: viewModel.selectedGenre,
                  items: [
                    'Acción',
                    'Comedia',
                    'Drama',
                    'Fantasía',
                  ].map((genre) {
                    return DropdownMenuItem<String>(
                      value: genre,
                      child: Text(genre),
                    );
                  }).toList(),
                  onChanged: (genre) {
                    viewModel.setGenreFilter(genre);
                  },
                ), */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Puntuación mínima:'),
                    Slider(
                      value: viewModel.minRating,
                      min: 0.0,
                      max: 10.0,
                      divisions: 10,
                      activeColor: customSecondaryColor,
                      label: viewModel.minRating.toString(),
                      onChanged: (rating) {
                        viewModel.setRatingFilter(rating);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.failure != null
                    ? Center(
                        child: Text('Error: ${viewModel.failure?.message}'))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        padding: const EdgeInsets.all(8),
                        itemCount: viewModel.movies.length,
                        itemBuilder: (context, index) {
                          final movie = viewModel.movies[index];
                          return MovieCard(
                            title: movie.title,
                            posterPath: movie.posterPath,
                            voteAverage: movie.voteAverage,
                            releaseDate: movie.releaseDate,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                    movieID: movie.id.toString()),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
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
                  '${CommonConstants.urlImages}/t/p/w500$posterPath',
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
                      style: const TextStyle(
                        fontSize: 12,
                        color: customHintColor,
                      ),
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
