part of 'subscription_list_bloc.dart';

abstract class SubscriptionListState extends Equatable {
  const SubscriptionListState();

  @override
  List<Object> get props => [];
}

class SubscriptionListInitial extends SubscriptionListState {}

class Loading extends SubscriptionListState {}

class Loaded extends SubscriptionListState {
  final List<Invoice> invoices;

  const Loaded({
    this.invoices,
  }) : super();

  @override
  List<Object> get props => [
        invoices,
      ];
}

class LoadError extends SubscriptionListState {
  final AppErrorType errorType;

  const LoadError({
    @required this.errorType,
  }) : super();
}
