import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:seraj/core/network/dio_client.dart';

import 'package:seraj/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:seraj/features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'package:seraj/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:seraj/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:seraj/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:seraj/features/auth/domain/repositories/auth_repository.dart';
import 'package:seraj/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:seraj/features/auth/domain/usecases/clear_auth_session_usecase.dart';
import 'package:seraj/features/auth/domain/usecases/get_auth_session_usecase.dart';
import 'package:seraj/features/auth/domain/usecases/login_usecase.dart';
import 'package:seraj/features/auth/domain/usecases/register_usecase.dart';
import 'package:seraj/features/auth/domain/usecases/save_auth_session_usecase.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/auth/presentation/cubit/change_password_cubit.dart';
import 'package:seraj/features/auth/presentation/cubit/login_cubit.dart';
import 'package:seraj/features/auth/presentation/cubit/register_cubit.dart';

import 'package:seraj/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:seraj/features/categories/data/datasources/categories_remote_data_source_impl.dart';
import 'package:seraj/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:seraj/features/categories/domain/repositories/categories_repository.dart';
import 'package:seraj/features/categories/domain/usecases/create_category_usecase.dart';
import 'package:seraj/features/categories/domain/usecases/delete_category_usecase.dart';
import 'package:seraj/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:seraj/features/categories/domain/usecases/get_category_by_id_usecase.dart';
import 'package:seraj/features/categories/domain/usecases/update_category_usecase.dart';
import 'package:seraj/features/categories/presentation/cubit/categories_cubit.dart';

import 'package:seraj/features/explore/presentation/academies/data/datasources/academies_remote_data_source.dart';
import 'package:seraj/features/explore/presentation/academies/data/datasources/academies_remote_data_source_impl.dart';
import 'package:seraj/features/explore/presentation/academies/data/repositories/academies_repository_impl.dart';
import 'package:seraj/features/explore/presentation/academies/domain/repositories/academies_repository.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/academy_favorites_usecases.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/create_academy_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/delete_academy_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_by_location_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academy_by_id_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/update_academy_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/upload_academy_image_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academies_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academy_favorites_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/manage_academy_cubit.dart';

import 'package:seraj/features/explore/presentation/mosques/data/datasources/mosques_remote_data_source.dart';
import 'package:seraj/features/explore/presentation/mosques/data/datasources/mosques_remote_data_source_impl.dart';
import 'package:seraj/features/explore/presentation/mosques/data/repositories/mosques_repository_impl.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/repositories/mosques_repository.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/add_mosque_to_favorites_usecase.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/create_mosque_usecase.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/get_favorite_mosques_usecase.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/get_mosques_by_lesson_category_usecase.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/get_mosques_usecase.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/remove_mosque_from_favorites_usecase.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/usecases/upload_mosque_image_usecase.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/create_mosque_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosque_favorites_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosques_cubit.dart';

import 'package:seraj/features/invitation_codes/data/datasources/invitation_codes_remote_data_source.dart';
import 'package:seraj/features/invitation_codes/data/datasources/invitation_codes_remote_data_source_impl.dart';
import 'package:seraj/features/invitation_codes/data/repositories/invitation_codes_repository_impl.dart';
import 'package:seraj/features/invitation_codes/domain/repositories/invitation_codes_repository.dart';
import 'package:seraj/features/invitation_codes/domain/usecaases/create_mosque_manager_invitation_code_usecase.dart';
import 'package:seraj/features/invitation_codes/domain/usecaases/redeem_invitation_code_usecase.dart';
import 'package:seraj/features/invitation_codes/presentation/cubit/create_invitation_code_cubit.dart';
import 'package:seraj/features/invitation_codes/presentation/cubit/redeem_invitation_code_cubit.dart';

import 'package:seraj/features/lessons/data/datasources/lessons_remote_datasource.dart';
import 'package:seraj/features/lessons/data/datasources/lessons_remote_datasource_impl.dart';
import 'package:seraj/features/lessons/data/repositories/lessons_repositoryI_impl.dart';
import 'package:seraj/features/lessons/domain/repositories/lessons_repository.dart';
import 'package:seraj/features/lessons/domain/usecases/create_lesson_usecase.dart';
import 'package:seraj/features/lessons/domain/usecases/get_lesson_detail_usecase.dart';
import 'package:seraj/features/lessons/domain/usecases/get_lessons_usecase.dart';
import 'package:seraj/features/lessons/domain/usecases/publish_lesson_usecase.dart';
import 'package:seraj/features/lessons/domain/usecases/unpublish_lesson_usecase.dart';
import 'package:seraj/features/lessons/presentation/cubit/create_lesson_cubit.dart';
import 'package:seraj/features/lessons/presentation/cubit/lesson_detail_cubit.dart';
import 'package:seraj/features/lessons/presentation/cubit/lessons_cubit.dart';

import 'package:seraj/features/location/data/datasources/location_remote_data_source.dart';
import 'package:seraj/features/location/data/datasources/location_remote_data_source_impl.dart';
import 'package:seraj/features/location/data/repositories/location_repository_impl.dart';
import 'package:seraj/features/location/domain/repositories/location_repository.dart';
import 'package:seraj/features/location/domain/usecases/get_cities_usecase.dart';
import 'package:seraj/features/location/presentation/cubit/cities_cubit.dart';
import 'package:seraj/features/prayer_times/data/datasources/prayer_times_remote_data_source.dart';
import 'package:seraj/features/prayer_times/data/datasources/prayer_times_remote_data_source_impl.dart';
import 'package:seraj/features/prayer_times/data/repositories/prayer_times_repository_impl.dart';
import 'package:seraj/features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'package:seraj/features/prayer_times/domain/usecases/get_today_prayer_times_usecase.dart';
import 'package:seraj/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';

import 'package:seraj/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:seraj/features/profile/data/datasources/profile_remote_data_source_impl.dart';
import 'package:seraj/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:seraj/features/profile/domain/repositories/profile_repository.dart';
import 'package:seraj/features/profile/domain/usecase/update_profile_usecase.dart';
import 'package:seraj/features/profile/presentation/cubit/edit_profile_cubit.dart';

import 'package:seraj/features/teachers/data/datasources/teacher_promotion_remote_data_source.dart';
import 'package:seraj/features/teachers/data/datasources/teacher_promotion_remote_data_source_impl.dart';
import 'package:seraj/features/teachers/data/repositories/teacher_promotion_repository_impl.dart';
import 'package:seraj/features/teachers/domain/repositories/teacher_promotion_repository.dart';
import 'package:seraj/features/teachers/domain/usecases/create_teacher_usecase.dart';
import 'package:seraj/features/teachers/domain/usecases/get_teachers_by_mosque_usecase.dart';
import 'package:seraj/features/teachers/domain/usecases/promote_user_to_teacher_usecase.dart';
import 'package:seraj/features/teachers/domain/usecases/search_users_for_promotion_usecase.dart';
import 'package:seraj/features/teachers/presentation/cubit/mosque_teachers_cubit.dart';
import 'package:seraj/features/teachers/presentation/cubit/teacher_promotion_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Core / Local
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));

  // Location
  sl.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetCitiesUseCase>(() => GetCitiesUseCase(sl()));
  sl.registerFactory<CitiesCubit>(() => CitiesCubit(sl()));

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));

  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit(sl()));

  sl.registerLazySingleton<SaveAuthSessionUseCase>(
    () => SaveAuthSessionUseCase(sl()),
  );

  sl.registerLazySingleton<GetAuthSessionUseCase>(
    () => GetAuthSessionUseCase(sl()),
  );

  sl.registerLazySingleton<ClearAuthSessionUseCase>(
    () => ClearAuthSessionUseCase(sl()),
  );

  sl.registerLazySingleton<AuthSessionCubit>(
    () => AuthSessionCubit(
      saveAuthSessionUseCase: sl(),
      getAuthSessionUseCase: sl(),
      clearAuthSessionUseCase: sl(),
    ),
  );

  // Mosques
  sl.registerLazySingleton<MosquesRemoteDataSource>(
    () => MosquesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<MosquesRepository>(
    () => MosquesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetMosquesUseCase>(() => GetMosquesUseCase(sl()));

  sl.registerLazySingleton<GetMosquesByLessonCategoryUseCase>(
    () => GetMosquesByLessonCategoryUseCase(sl()),
  );

  sl.registerLazySingleton<CreateMosqueUseCase>(
    () => CreateMosqueUseCase(sl()),
  );

  sl.registerLazySingleton<UploadMosqueImageUseCase>(
    () => UploadMosqueImageUseCase(sl()),
  );

  sl.registerLazySingleton<AddMosqueToFavoritesUseCase>(
    () => AddMosqueToFavoritesUseCase(sl()),
  );

  sl.registerLazySingleton<RemoveMosqueFromFavoritesUseCase>(
    () => RemoveMosqueFromFavoritesUseCase(sl()),
  );

  sl.registerLazySingleton<GetFavoriteMosquesUseCase>(
    () => GetFavoriteMosquesUseCase(sl()),
  );

  sl.registerFactory<MosquesCubit>(
    () => MosquesCubit(
      getMosquesUseCase: sl(),
      getMosquesByLessonCategoryUseCase: sl(),
    ),
  );

  sl.registerFactory<CreateMosqueCubit>(
    () => CreateMosqueCubit(
      sl<CreateMosqueUseCase>(),
      sl<UploadMosqueImageUseCase>(),
    ),
  );

  sl.registerFactory<MosqueFavoritesCubit>(
    () => MosqueFavoritesCubit(
      addMosqueToFavoritesUseCase: sl(),
      removeMosqueFromFavoritesUseCase: sl(),
      getFavoriteMosquesUseCase: sl(),
    ),
  );

  // Academies
  sl.registerLazySingleton<AcademiesRemoteDataSource>(
    () => AcademiesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AcademiesRepository>(
    () => AcademiesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetAcademiesUseCase>(
    () => GetAcademiesUseCase(sl()),
  );

  sl.registerLazySingleton<GetAcademiesByLocationUseCase>(
    () => GetAcademiesByLocationUseCase(sl()),
  );

  sl.registerLazySingleton<GetAcademyByIdUseCase>(
    () => GetAcademyByIdUseCase(sl()),
  );

  sl.registerLazySingleton<CreateAcademyUseCase>(
    () => CreateAcademyUseCase(sl()),
  );

  sl.registerLazySingleton<UpdateAcademyUseCase>(
    () => UpdateAcademyUseCase(sl()),
  );

  sl.registerLazySingleton<DeleteAcademyUseCase>(
    () => DeleteAcademyUseCase(sl()),
  );

  sl.registerLazySingleton<AddFavoriteAcademyUseCase>(
    () => AddFavoriteAcademyUseCase(sl()),
  );

  sl.registerLazySingleton<RemoveFavoriteAcademyUseCase>(
    () => RemoveFavoriteAcademyUseCase(sl()),
  );

  sl.registerLazySingleton<GetFavoriteAcademiesUseCase>(
    () => GetFavoriteAcademiesUseCase(sl()),
  );

  sl.registerFactory<AcademiesCubit>(
    () => AcademiesCubit(
      getAcademiesUseCase: sl(),
      getAcademiesByLocationUseCase: sl(),
    ),
  );

  sl.registerFactory<AcademyFavoritesCubit>(
    () => AcademyFavoritesCubit(
      addFavoriteAcademyUseCase: sl(),
      removeFavoriteAcademyUseCase: sl(),
      getFavoriteAcademiesUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<UploadAcademyImageUseCase>(
    () => UploadAcademyImageUseCase(sl()),
  );

  sl.registerFactory<ManageAcademyCubit>(
    () => ManageAcademyCubit(
      createAcademyUseCase: sl(),
      updateAcademyUseCase: sl(),
      deleteAcademyUseCase: sl(),
      uploadAcademyImageUseCase: sl(),
    ),
  );

  // Categories
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl()),
  );

  sl.registerLazySingleton<GetCategoryByIdUseCase>(
    () => GetCategoryByIdUseCase(sl()),
  );

  sl.registerLazySingleton<CreateCategoryUseCase>(
    () => CreateCategoryUseCase(sl()),
  );

  sl.registerLazySingleton<UpdateCategoryUseCase>(
    () => UpdateCategoryUseCase(sl()),
  );

  sl.registerLazySingleton<DeleteCategoryUseCase>(
    () => DeleteCategoryUseCase(sl()),
  );

  sl.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(
      getCategoriesUseCase: sl(),
      createCategoryUseCase: sl(),
      updateCategoryUseCase: sl(),
      deleteCategoryUseCase: sl(),
    ),
  );

  // Lessons
  sl.registerLazySingleton<LessonsRemoteDataSource>(
    () => LessonsRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<LessonsRepository>(
    () => LessonsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetLessonsUseCase>(() => GetLessonsUseCase(sl()));

  sl.registerLazySingleton<CreateLessonUseCase>(
    () => CreateLessonUseCase(sl()),
  );

  sl.registerLazySingleton<GetLessonDetailUseCase>(
    () => GetLessonDetailUseCase(sl()),
  );

  sl.registerLazySingleton<PublishLessonUseCase>(
    () => PublishLessonUseCase(sl()),
  );

  sl.registerLazySingleton<UnpublishLessonUseCase>(
    () => UnpublishLessonUseCase(sl()),
  );

  sl.registerFactory<LessonsCubit>(
    () => LessonsCubit(
      getLessonsUseCase: sl(),
      publishLessonUseCase: sl(),
      unpublishLessonUseCase: sl(),
    ),
  );

  sl.registerFactory<CreateLessonCubit>(() => CreateLessonCubit(sl()));

  sl.registerFactory<LessonDetailCubit>(() => LessonDetailCubit(sl()));

  // Invitation Codes
  sl.registerLazySingleton<InvitationCodesRemoteDataSource>(
    () => InvitationCodesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<InvitationCodesRepository>(
    () => InvitationCodesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<CreateMosqueManagerInvitationCodeUseCase>(
    () => CreateMosqueManagerInvitationCodeUseCase(sl()),
  );

  sl.registerLazySingleton<RedeemInvitationCodeUseCase>(
    () => RedeemInvitationCodeUseCase(sl()),
  );

  sl.registerFactory<CreateInvitationCodeCubit>(
    () => CreateInvitationCodeCubit(sl()),
  );

  sl.registerFactory<RedeemInvitationCodeCubit>(
    () => RedeemInvitationCodeCubit(sl()),
  );

  // Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl()),
  );

  sl.registerFactory<EditProfileCubit>(() => EditProfileCubit(sl()));

  // Teachers
  sl.registerLazySingleton<TeacherPromotionRemoteDataSource>(
    () => TeacherPromotionRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<TeacherPromotionRepository>(
    () => TeacherPromotionRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<SearchUsersForPromotionUseCase>(
    () => SearchUsersForPromotionUseCase(sl()),
  );

  sl.registerLazySingleton<PromoteUserToTeacherUseCase>(
    () => PromoteUserToTeacherUseCase(sl()),
  );

  sl.registerLazySingleton<CreateTeacherUseCase>(
    () => CreateTeacherUseCase(sl()),
  );

  sl.registerLazySingleton<GetTeachersByMosqueUseCase>(
    () => GetTeachersByMosqueUseCase(sl()),
  );

  sl.registerFactory<TeacherPromotionCubit>(
    () => TeacherPromotionCubit(
      searchUsersForPromotionUseCase: sl(),
      promoteUserToTeacherUseCase: sl(),
      createTeacherUseCase: sl(),
    ),
  );

  sl.registerFactory<MosqueTeachersCubit>(() => MosqueTeachersCubit(sl()));

  sl.registerLazySingleton<PrayerTimesRemoteDataSource>(
    () => PrayerTimesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<PrayerTimesRepository>(
    () => PrayerTimesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetTodayPrayerTimesUseCase>(
    () => GetTodayPrayerTimesUseCase(sl()),
  );

  sl.registerFactory<PrayerTimesCubit>(() => PrayerTimesCubit(sl()));

  sl.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(sl()),
  );

  sl.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(sl()));
}
