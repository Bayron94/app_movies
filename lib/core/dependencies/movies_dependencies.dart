import 'package:dio/dio.dart';
import 'package:test_app_2024/config/config.dart';
import 'package:test_app_2024/data/datasources/datasources.dart';
import 'package:test_app_2024/data/repositories/repositories.dart';
import 'package:test_app_2024/domain/usecases/usescases.dart';
import 'package:test_app_2024/presentation/viewmodels/movie_detail_viewmodel.dart';
import 'package:test_app_2024/presentation/viewmodels/movie_list_viewmodel.dart';

final movieDataSource = MovieRemoteDataSourceImpl(Dio(
  BaseOptions(
    baseUrl: CommonConstants.urlServer + CommonConstants.apiPath,
    queryParameters: {'api_key': Environment.keyTMDB},
  ),
));

final movieRepository = MovieRepositoryImpl(remoteDataSource: movieDataSource);

final getPopularMovies = GetPopularMovies(movieRepository);
final getMovieDetail = GetMovieDetail(movieRepository);

final movieListViewModel = MovieListViewModel(
  getPopularMovies: getPopularMovies,
);

final movieDetailViewModel = MovieDetailViewModel(
  getMovieDetail: getMovieDetail,
);

// TODO(Bayron): validate or remove
/* final authenticationProvider = AuthenticationProvider(
  appRouter,
  signinWithPassword: signinWithPassword,
); */
