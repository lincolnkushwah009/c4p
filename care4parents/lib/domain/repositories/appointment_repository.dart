import 'package:care4parents/data/models/appointment_model.dart';
import 'package:care4parents/data/models/appointment_result_model.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/appointment_entity.dart';
import 'package:care4parents/domain/entities/appointment_params.dart';
import 'package:care4parents/domain/usecases/get_appointments.dart';
import 'package:dartz/dartz.dart';

abstract class AppiontmentRepository {
  Future<Either<AppError, List<AppointmentModel>>> getAppointments(int tab);
  Future<Either<AppError, List<Service>>> getServices(int tab);
  Future<Either<AppError, ObjectCommonResult>> createAppointment(
      AppointmentParams params);
  Future<Either<AppError, ObjectCommonResult>> createService(
      ServiceParams params);
}
