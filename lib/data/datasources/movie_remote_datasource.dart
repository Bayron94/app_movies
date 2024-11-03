import 'package:dio/dio.dart';
import 'package:test_app_2024/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<MovieModel> getMovieDetail(String movieId);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final Dio _dio;

  MovieRemoteDataSourceImpl(this._dio);

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await _dio.get('popular');

    if (response.statusCode == 200) {
      return (response.data['results'] as List)
          .map((json) => MovieModel.fromJson(json))
          .toList();
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: 'popular movies endpoint'),
        error: 'Failed to load popular movies',
      );
    }
  }

  @override
  Future<MovieModel> getMovieDetail(String movieId) async {
    final response = await _dio.get(movieId);

    if (response.statusCode == 200) {
      return MovieModel.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: 'movie detail endpoint'),
        error: 'Failed to load movie details',
      );
    }
  }
}
