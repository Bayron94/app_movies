import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app_2024/config/config.dart';
import 'package:test_app_2024/presentation/viewmodels/movie_detail_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieID});

  final String movieID;
  static const name = 'movie-detail';

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Future<void> _openUrl(String movieTitle) async {
    final url = Uri.parse("${CommonConstants.urlGoogle}/search?q=$movieTitle");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieDetailViewModel>(context, listen: false)
          .fetchMovieDetail(widget.movieID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MovieDetailViewModel>();

    return Scaffold(
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.failure != null
              ? Center(child: Text('Error: ${viewModel.failure?.message}'))
              : viewModel.movie == null
                  ? const Center(child: Text('No movie details available'))
                  : CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 300.0,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(
                              viewModel.movie?.title ?? 'Título desconocido',
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
                                  '${CommonConstants.urlImages}/t/p/w500${viewModel.movie!.posterPath}',
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
                                    if (viewModel.movie?.genres != null)
                                      Text(
                                        'Género: ${viewModel.movie!.genres!.isNotEmpty ? viewModel.movie!.genres!.map((genre) => genre.name).join(', ') : 'No disponible'}',
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
                                          'Rating: ${viewModel.movie!.voteAverage}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
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
                                      viewModel.movie!.overview,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    /* TODO(Bayron): Implement call to /credits
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
                                        itemCount: viewModel.castList.length,
                                        itemBuilder: (context, index) {
                                          final actor =
                                              viewModel.castList[index];
                                          return Container(
                                            width: 100,
                                            margin: const EdgeInsets.only(
                                                right: 16),
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage:
                                                      NetworkImage(
                                                    actor['profile_path'] !=
                                                            null
                                                        ? 'https://image.tmdb.org/t/p/w200${actor['profile_path']}'
                                                        : 'https://via.placeholder.com/100',
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  actor['name'] ??
                                                      'Nombre desconocido',
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
                                    ), */
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
                                        onPressed: () => _openUrl(
                                          viewModel.movie?.title ?? '',
                                        ),
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
