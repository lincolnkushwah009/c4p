import 'package:dartz/dartz.dart';
import 'package:care4parents/domain/entities/app_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}
