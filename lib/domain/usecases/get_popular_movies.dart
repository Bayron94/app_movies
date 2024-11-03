import 'package:dartz/dartz.dart';
import 'package:test_app_2024/core/errors/errors.dart';
import 'package:test_app_2024/domain/entities/entities.dart';
import 'package:test_app_2024/domain/repositories/repositories.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await repository.getPopularMovies();
  }
}
