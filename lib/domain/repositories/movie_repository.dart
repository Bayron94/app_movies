import 'package:dartz/dartz.dart';
import 'package:test_app_2024/core/errors/errors.dart';
import 'package:test_app_2024/domain/entities/entities.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, Movie>> getMovieDetail(String movieId);
}
