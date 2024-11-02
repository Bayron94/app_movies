import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initUser();
}

Future<void> initUser() async {
  // Providers
  // sl.registerFactory(
  //   () => AuthenticationProvider(sl(), signinWithPassword: sl()),
  // );

  // Use Cases
  // sl.registerLazySingleton(() => SigninWithPassword(sl()));

  // Repository
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Data sources
  // sl.registerLazySingleton<AuthDataSource>(() => AuthDatasourceImpl(sl()));

  // External
  // sl.registerLazySingleton(() => appRouter);
  // sl.registerLazySingleton(
  //   () => Dio(
  //     BaseOptions(
  //       baseUrl: Environment.urlServerDev + CommonConstants.apiPath,
  //     ),
  //   ),
  // );
}
