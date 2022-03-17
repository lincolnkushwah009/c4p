// part of 'subscription_flow_bloc.dart';

// class SubscriptionAddState extends Equatable {
//   const SubscriptionAddState({
//     this.step_number = 1,
//     this.status = FormzStatus.pure,
//     this.address_status = FormzStatus.pure,
//     this.name = const NotEmptyField.pure(),
//     this.relation = const NotEmptyField.pure(),
//     this.dateOfBirth = const NotEmptyField.pure(),
//     this.gender = const NotEmptyField.pure(),
//   });

//   final FormzStatus status;
//   final FormzStatus address_status;
//   final NotEmptyField name;
//   final NotEmptyField relation;
//   final NotEmptyField dateOfBirth;
//   final NotEmptyField gender;
//   final int step_number;

//   SubscriptionAddState copyWith({
//     FormzStatus status,
//     FormzStatus address_status,
//     NotEmptyField name,
//     NotEmptyField relation,
//     NotEmptyField dateOfBirth,
//     NotEmptyField gender,
//     int step_number,
//   }) {
//     return SubscriptionAddState(
//       step_number: step_number ?? this.step_number,
//       status: status ?? this.status,
//       address_status: address_status ?? this.address_status,
//       name: name ?? this.name,
//       relation: relation ?? this.relation,
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//       gender: gender ?? this.gender,
//     );
//   }

//   @override
//   List<Object> get props => [
//         status,
//         address_status,
//         dateOfBirth,
//         gender,
//         relation,
//         name,
//         step_number
//       ];
// }

// class SubscriptionAddInitial extends SubscriptionAddState {}

// // class SubscriptionAddLoaded extends SubscriptionAddState {
// //   final SubscriptionAdd sub;

// //   // SubscriptionAddLoaded(this.sub) : super([]);
// // }
