// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:seraj/features/lessons/data/datasources/lessons_remote_datasource.dart';
import 'package:seraj/features/lessons/data/model/create_lesson_request_model.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_detail_entity.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_entity.dart';
import 'package:seraj/features/lessons/domain/usecases/create_lesson_usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/lessons_page_entity.dart';
import '../../domain/repositories/lessons_repository.dart';
import '../../domain/usecases/get_lessons_usecase.dart';

class LessonsRepositoryImpl implements LessonsRepository {
  final LessonsRemoteDataSource remoteDataSource;

  LessonsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LessonsPageEntity>> getLessons(
    GetLessonsParams params,
  ) async {
    try {
      final result = await remoteDataSource.getLessons(params);
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
  Future<Either<Failure, LessonEntity>> createLesson(
    CreateLessonParams params,
  ) async {
    try {
      final result = await remoteDataSource.createLesson(
        CreateLessonRequestModel(
          categoryId: params.categoryId,
          mosqueId: params.mosqueId,
          teacherId: params.teacherId,
          name: params.name,
          description: params.description,
          notes: params.notes,
          isItACompleteCourse: params.isItACompleteCourse,
          liveStreamingCapability: params.liveStreamingCapability,
        ),
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
  Future<Either<Failure, LessonDetailEntity>> getLessonDetail(
    int lessonId,
  ) async {
    try {
      final result = await remoteDataSource.getLessonDetail(lessonId);
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
  Future<Either<Failure, LessonEntity>> publishLesson(int lessonId) async {
    try {
      final result = await remoteDataSource.publishLesson(lessonId);
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
  Future<Either<Failure, LessonEntity>> unpublishLesson(int lessonId) async {
    try {
      final result = await remoteDataSource.unpublishLesson(lessonId);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }
}
