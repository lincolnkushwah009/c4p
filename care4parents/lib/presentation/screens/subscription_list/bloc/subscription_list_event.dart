part of 'subscription_list_bloc.dart';

abstract class SubscriptionListEvent extends Equatable {
  const SubscriptionListEvent();

  @override
  List<Object> get props => [];
}

class GetInvoices extends SubscriptionListEvent {
  const GetInvoices();

  @override
  List<Object> get props => [];
}
