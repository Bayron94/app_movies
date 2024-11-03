import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app_2024/core/errors/errors.dart';
import 'package:test_app_2024/domain/entities/entities.dart';
import 'package:test_app_2024/domain/usecases/usescases.dart';

class MovieDetailViewModel extends ChangeNotifier {
  final GetMovieDetail getMovieDetail;

  Movie? movie;
  bool isLoading = false;
  Failure? failure;

  MovieDetailViewModel({required this.getMovieDetail});

  Future<void> fetchMovieDetail(String movieId) async {
    isLoading = true;
    failure = null;
    notifyListeners();

    final Either<Failure, Movie> result = await getMovieDetail(movieId);

    result.fold(
      (error) {
        failure = error;
        movie = null;
      },
      (movieDetail) {
        movie = movieDetail;
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
