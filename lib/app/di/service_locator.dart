import 'package:get_it/get_it.dart';
import 'package:seraj/core/network/dio_client.dart';

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
}
