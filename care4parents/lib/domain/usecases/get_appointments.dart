import 'package:care4parents/data/models/appointment_model.dart';
import 'package:care4parents/data/models/appointment_result_model.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/domain/entities/appointment_params.dart';
import 'package:dartz/dartz.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/appointment_entity.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/repositories/appointment_repository.dart';
import 'package:care4parents/domain/usecases/usecase.dart';

class GetUpcomingAppointments extends UseCase<List<AppointmentModel>, int> {
  final AppiontmentRepository repository;

  GetUpcomingAppointments(this.repository);

  @override
  Future<Either<AppError, List<AppointmentModel>>> call(int tab) async {
    return await repository.getAppointments(tab);
  }
}

class GetServices extends UseCase<List<Service>, int> {
  final AppiontmentRepository repository;

  GetServices(this.repository);

  @override
  Future<Either<AppError, List<Service>>> call(int tab) async {
    return await repository.getServices(tab);
  }
}

class GetRequestedAppointments extends UseCase<List<AppointmentModel>, int> {
  final AppiontmentRepository repository;

  GetRequestedAppointments(this.repository);

  @override
  Future<Either<AppError, List<AppointmentModel>>> call(int tab) async {
    return await repository.getAppointments(tab);
  }
}

class CreateAppointment extends UseCase<ObjectCommonResult, AppointmentParams> {
  final AppiontmentRepository repository;

  CreateAppointment(this.repository);

  @override
  Future<Either<AppError, ObjectCommonResult>> call(
      AppointmentParams params) async {
    return await repository.createAppointment(params);
  }
}

class CreateService extends UseCase<ObjectCommonResult, ServiceParams> {
  final AppiontmentRepository repository;

  CreateService(this.repository);

  @override
  Future<Either<AppError, ObjectCommonResult>> call(
      ServiceParams params) async {
    return await repository.createService(params);
  }
}


















