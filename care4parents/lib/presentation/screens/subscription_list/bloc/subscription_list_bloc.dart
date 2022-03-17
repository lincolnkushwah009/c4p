import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/presentation/screens/subscription_list/subscription_list.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'subscription_list_event.dart';
part 'subscription_list_state.dart';

class SubscriptionListBloc
    extends Bloc<SubscriptionListEvent, SubscriptionListState> {
  OtherRemoteDataSource otherDataSource;

  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  SubscriptionListBloc({this.otherDataSource})
      : super(SubscriptionListInitial()) {
    on<GetInvoices>(
      (event, emit) async {
        emit(Loading());
        Either<AppError, List<Invoice>> inv =
            await otherDataSource.getInvoices();
        emit(inv.fold(
          (l) {
            print('left error >>>>>');
            return LoadError(
              errorType: l.appErrorType,
            );
          },
          (r) {
            return Loaded(
              invoices: r,
            );
          },
        ));
      },
      transformer: sequential(),
    );
  }

  @override
  Stream<SubscriptionListState> mapEventToState(
    SubscriptionListEvent event,
  ) async* {
    yield Loading();
    if (event is GetInvoices) {
      Either<AppError, List<Invoice>> inv = await otherDataSource.getInvoices();
      yield inv.fold(
        (l) {
          print('left error >>>>>');
          return LoadError(
            errorType: l.appErrorType,
          );
        },
        (r) {
          return Loaded(
            invoices: r,
          );
        },
      );
    }
  }
}
