import 'package:dartz/dartz.dart';
import 'package:test_app_2024/core/errors/errors.dart';
import 'package:test_app_2024/domain/entities/entities.dart';
import 'package:test_app_2024/domain/repositories/repositories.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, Movie>> call(String movieId) async {
    return await repository.getMovieDetail(movieId);
  }
}
