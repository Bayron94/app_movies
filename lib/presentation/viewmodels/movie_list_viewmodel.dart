import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app_2024/core/errors/errors.dart';
import 'package:test_app_2024/domain/entities/entities.dart';
import 'package:test_app_2024/domain/usecases/usescases.dart';

class MovieListViewModel extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  List<Movie> _allMovies = [];
  List<Movie> movies = [];
  bool isLoading = false;
  Failure? failure;

  String? selectedGenre;
  double minRating = 0.0;

  MovieListViewModel({required this.getPopularMovies});

  Future<void> fetchPopularMovies() async {
    isLoading = true;
    failure = null;
    notifyListeners();

    final Either<Failure, List<Movie>> result = await getPopularMovies();

    result.fold(
      (error) {
        failure = error;
        movies = [];
      },
      (movieList) {
        _allMovies = movieList;
        _applyFilters();
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void setGenreFilter(String? genre) {
    selectedGenre = genre;
    _applyFilters();
  }

  void setRatingFilter(double rating) {
    minRating = rating;
    _applyFilters();
  }

  void _applyFilters() {
    movies = _allMovies.where((movie) {
      final matchesGenre = selectedGenre == null ||
          (movie.genres != null &&
              movie.genres!.any((genre) => genre.name == selectedGenre));
      final matchesRating = movie.voteAverage >= minRating;
      return matchesGenre && matchesRating;
    }).toList();
    notifyListeners();
  }
}
