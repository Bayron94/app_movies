import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app_2024/config/constants/environment.dart';
import 'package:test_app_2024/config/constants/local_constants.dart';
import 'package:test_app_2024/config/router/app_router.dart';
import 'package:test_app_2024/data/datasources/datasources.dart';
import 'package:test_app_2024/data/repositories/repositories.dart';
import 'package:test_app_2024/domain/repositories/repositories.dart';
import 'package:test_app_2024/domain/usecases/usescases.dart';
import 'package:test_app_2024/presentation/viewmodels/movie_detail_viewmodel.dart';
import 'package:test_app_2024/presentation/viewmodels/movie_list_viewmodel.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initUser();
}

Future<void> initUser() async {
  // Viewmodels
  sl.registerFactory(() => MovieListViewModel(getPopularMovies: sl()));
  sl.registerFactory(() => MovieDetailViewModel(getMovieDetail: sl()));

  // Use-Cases
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => GetMovieDetail(sl()));

  // Repositories
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl()),
  );

  // Data-Sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sl()),
  );

  // Externals
  sl.registerLazySingleton(() => appRouter);
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: CommonConstants.urlServer + CommonConstants.apiPath,
        queryParameters: {'api_key': Environment.keyTMDB},
      ),
    ),
  );
}
