import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app_2024/core/errors/errors.dart';
import 'package:test_app_2024/core/utils/utils.dart';
import 'package:test_app_2024/data/datasources/datasources.dart';
import 'package:test_app_2024/data/mappers/mappers.dart';
import 'package:test_app_2024/domain/entities/entities.dart';
import 'package:test_app_2024/domain/repositories/repositories.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final movies = await remoteDataSource.getPopularMovies();
      return Right(movies.map((movie) => MovieMapper.toEntity(movie)).toList());
    } on DioException catch (error) {
      return Left(mapDioErrorToFailure(error));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetail(String movieId) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(movieId);
      return Right(MovieMapper.toEntity(movie));
    } on DioException catch (error) {
      return Left(mapDioErrorToFailure(error));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
