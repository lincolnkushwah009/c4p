import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;
  final String message;

  const AppError(this.appErrorType, {this.message});

  @override
  List<Object> get props => [appErrorType, message];
}

enum AppErrorType { api, network, database, message }
