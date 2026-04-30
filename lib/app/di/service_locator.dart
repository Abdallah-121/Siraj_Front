import 'package:get_it/get_it.dart';
import 'package:seraj/core/network/dio_client.dart';
import 'package:seraj/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:seraj/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:seraj/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:seraj/features/auth/domain/repositories/auth_repository.dart';
import 'package:seraj/features/auth/domain/usecases/login_usecase.dart';
import 'package:seraj/features/auth/domain/usecases/register_usecase.dart';
import 'package:seraj/features/auth/presentation/cubit/login_cubit.dart';
import 'package:seraj/features/auth/presentation/cubit/register_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/data/datasources/academies_remote_data_source.dart';
import 'package:seraj/features/explore/presentation/academies/data/datasources/academies_remote_data_source_impl.dart';
import 'package:seraj/features/explore/presentation/academies/data/repositories/academies_repository_impl.dart';
import 'package:seraj/features/explore/presentation/academies/domain/repositories/academies_repository.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academies_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/data/datasources/mosques_remote_data_source.dart';
import 'package:seraj/features/explore/presentation/mosques/data/datasources/mosques_remote_data_source_impl.dart';
import 'package:seraj/features/explore/presentation/mosques/data/repositories/mosques_repository_impl.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/repositories/mosques_repository.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/get_mosques_usecase.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosques_cubit.dart';

import '../../features/location/data/datasources/location_remote_data_source.dart';
import '../../features/location/data/datasources/location_remote_data_source_impl.dart';
import '../../features/location/data/repositories/location_repository_impl.dart';
import '../../features/location/domain/repositories/location_repository.dart';
import '../../features/location/domain/usecases/get_cities_usecase.dart';
import '../../features/location/presentation/cubit/cities_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetCitiesUseCase>(() => GetCitiesUseCase(sl()));

  sl.registerFactory<CitiesCubit>(() => CitiesCubit(sl()));

  sl.registerLazySingleton<MosquesRemoteDataSource>(
    () => MosquesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<MosquesRepository>(
    () => MosquesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetMosquesUseCase>(() => GetMosquesUseCase(sl()));

  sl.registerFactory<MosquesCubit>(() => MosquesCubit(sl()));

  sl.registerLazySingleton<AcademiesRemoteDataSource>(
    () => AcademiesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AcademiesRepository>(
    () => AcademiesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetAcademiesUseCase>(
    () => GetAcademiesUseCase(sl()),
  );

  sl.registerFactory<AcademiesCubit>(() => AcademiesCubit(sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));

  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));

  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit(sl()));
}
