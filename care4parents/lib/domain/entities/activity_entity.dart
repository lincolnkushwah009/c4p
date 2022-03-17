import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ActivityEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String schedule_date;
  final String execution_date;

  ActivityEntity({
    @required this.id,
    @required this.name,
    @required this.status,
    @required this.schedule_date,
    @required this.execution_date,
  });

  @override
  List<Object> get props => [id, name, status, schedule_date, execution_date];
}
