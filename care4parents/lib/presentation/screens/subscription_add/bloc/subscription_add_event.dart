// part of 'subscription_flow_bloc.dart';

// abstract class SubscriptionAddEvent extends Equatable {
//   const SubscriptionAddEvent();

//   @override
//   List<Object> get props => [];
// }

// class SubscriptionAddNameChanged extends SubscriptionAddEvent {
//   const SubscriptionAddNameChanged(this.name);
//   final String name;

//   @override
//   List<Object> get props => [name];
// }

// class SubscriptionAddDobChanged extends SubscriptionAddEvent {
//   const SubscriptionAddDobChanged(this.dateOfBirth);

//   final String dateOfBirth;

//   @override
//   List<Object> get props => [dateOfBirth];
// }

// class SubscriptionAddBasicEvent extends SubscriptionAddEvent {
//   final String name;
//   // final String relation;

//   const SubscriptionAddBasicEvent(this.name);

//   @override
//   List<Object> get props => [name];
// }

// class SubscriptionAddStepIncrement extends SubscriptionAddEvent {
//   final int step_number;

//   const SubscriptionAddStepIncrement(this.step_number);

//   @override
//   List<Object> get props => [step_number];
// }

// class SubscriptionAddStepDecrement extends SubscriptionAddEvent {
//   final int step_number;
//   // final String relation;

//   const SubscriptionAddStepDecrement(this.step_number);

//   @override
//   List<Object> get props => [step_number];
// }

// class SubscriptionAddSubmitted extends SubscriptionAddEvent {
//   const SubscriptionAddSubmitted();
// }

// class SubscriptionAddBasicSubmitted extends SubscriptionAddEvent {
//   const SubscriptionAddBasicSubmitted();
// }

// class SubscriptionAddAddressSubmitted extends SubscriptionAddEvent {
//   const SubscriptionAddAddressSubmitted();
// }
