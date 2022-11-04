import 'package:air_line_task/features/data/dataSource/localDataSource.dart';
import 'package:air_line_task/features/data/dataSource/remoteDataSource.dart';
import 'package:air_line_task/features/data/repository/airlineRepository.dart';
import 'package:air_line_task/features/domain/repository/baseRepository.dart';
import 'package:air_line_task/features/domain/useCase/airLineUseCase.dart';
import 'package:air_line_task/features/presentation/controllers/bloc/air_line_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../error/internetCheck.dart';

final sl = GetIt.instance;

Future<void> init() async
{
  ///bloc
  sl.registerFactory(() => AirLineBloc(getAirLineUseCase: sl()));


  ///Use case
  sl.registerLazySingleton(() => GetAirLineUseCase( baseAirLineRepository: sl(),));

  ///Repositary
  sl.registerLazySingleton<BaseAirLineRepository>(() => AirLineRepository(networkInfo: sl(), airLineRemoteDateSource: sl(), airLineLocalDateSource: sl()));

  ///Data source
  sl.registerLazySingleton<AirLineRemoteDateSource>(() => AirLineRemoteDataSourceImp( dio: sl(),));
  sl.registerLazySingleton<AirLineLocalDateSource>(() => AirLineLocalDataSourceImp(sharedPreferences: sl()));

  ///core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));

  ///External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);


  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());





}