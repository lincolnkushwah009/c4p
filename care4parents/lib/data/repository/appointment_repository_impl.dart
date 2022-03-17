import 'dart:io';

import 'package:care4parents/data/data_sources/appointment_remote_data_source.dart';
import 'package:care4parents/data/models/appointment_model.dart';
import 'package:care4parents/data/models/appointment_result_model.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/appointment_entity.dart';
import 'package:care4parents/domain/entities/appointment_params.dart';
import 'package:care4parents/domain/repositories/appointment_repository.dart';
import 'package:dartz/dartz.dart';

class AppiontmentRepositoryImpl extends AppiontmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppiontmentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<AppointmentModel>>> getAppointments(
      int tab) async {
    try {
      final appointments = await remoteDataSource.getAppointments(tab);
      print('Right appointments >>>>>>>>>' + appointments.toString());
      return Right(appointments);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> createAppointment(
      AppointmentParams params) async {
    try {
      final result = await remoteDataSource.createAppointment(params);
      print('Right createAppointment' + result.toString());
      return Right(result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> createService(
      ServiceParams params) async {
    try {
      final result = await remoteDataSource.createService(params);
      print('Right createService' + result.toString());
      return Right(result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<Service>>> getServices(int tab) async {
    try {
      final services = await remoteDataSource.getServcies(tab);
      print('Right services >>>>>>>>>' + services.toString());
      return Right(services);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}
