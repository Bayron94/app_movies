import 'package:go_router/go_router.dart';
import 'package:test_app_2024/presentation/screens/home_screen.dart';
import 'package:test_app_2024/presentation/screens/movie_screen.dart';

final appRouter = GoRouter(
  // errorBuilder: (context, state) => const InProgressScreen(),
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: MoviesListScreen.name,
      builder: (context, state) => const MoviesListScreen(),
    ),
    // Ruta dinámica para la pantalla de detalles
    GoRoute(
      path: '/movie-detail/:id',
      name: MovieDetailScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? '';
        return MovieDetailScreen(movieID: movieId);
      },
    ),
  ],
);
