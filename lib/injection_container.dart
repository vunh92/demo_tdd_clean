import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:demo_tdd_clean/core/network/network_info.dart';
import 'package:demo_tdd_clean/core/util/input_converter.dart';
import 'package:demo_tdd_clean/features/upcoming/data/datasource/upcoming_local_data_source.dart';
import 'package:demo_tdd_clean/features/upcoming/data/datasource/upcoming_remote_data_source.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/repositories/upcoming_repository.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/usecases/get_upcoming_id.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/upcoming/data/repositories/upcoming_repositories.dart';
import 'features/upcoming/domain/usecases/get_upcoming.dart';
import 'features/upcoming/presentation/bloc/upcoming_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  getIt.registerFactory(
    () => UpcomingBloc(getUpcoming: getIt(), getUpcomingId: getIt(), inputConverter: getIt()),
  );
  // Use cases
  getIt.registerLazySingleton(() => GetUpcoming(getIt()));
  getIt.registerLazySingleton(() => GetUpcomingId(getIt()));

  // Repository
  getIt.registerLazySingleton<UpcomingRepository>(
    () => UpcomingRepositoryImpl(
      localDataSource: getIt(),
      networkInfo: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<UpcomingRemoteDataSource>(
    () => UpcomingRemoteDataSourceImpl(client: getIt()),
  );
  getIt.registerLazySingleton<UpcomingLocalDataSource>(
    () => UpcomingLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  //! Core
  getIt.registerLazySingleton(() => InputConverter());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => DataConnectionChecker());
}
