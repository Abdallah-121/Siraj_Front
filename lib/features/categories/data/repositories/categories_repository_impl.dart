import 'package:dartz/dartz.dart';
import 'package:seraj/features/categories/data/model/category_request_model.dart';
import 'package:seraj/features/categories/domain/usecases/create_category_usecase.dart';
import 'package:seraj/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:seraj/features/categories/domain/usecases/update_category_usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/categories_page_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_data_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  const CategoriesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CategoriesPageEntity>> getCategories(
    GetCategoriesParams params,
  ) async {
    try {
      final result = await remoteDataSource.getCategories(
        pageNumber: params.pageNumber,
        pageSize: params.pageSize,
        search: params.search,
        sortBy: params.sortBy,
        descending: params.descending,
      );

      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById(int id) async {
    try {
      final result = await remoteDataSource.getCategoryById(id);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> createCategory(
    CreateCategoryParams params,
  ) async {
    try {
      final result = await remoteDataSource.createCategory(
        CategoryRequestModel(name: params.name),
      );

      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> updateCategory(
    UpdateCategoryParams params,
  ) async {
    try {
      final result = await remoteDataSource.updateCategory(
        id: params.id,
        request: CategoryRequestModel(name: params.name),
      );

      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(int id) async {
    try {
      await remoteDataSource.deleteCategory(id);
      return const Right(unit);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }
}
