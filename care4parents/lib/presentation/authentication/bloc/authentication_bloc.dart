// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:care4parents/data/models/user.dart';
// import 'package:care4parents/data/repository/athentication_repository_impl.dart';
// import 'package:care4parents/domain/repositories/authentication_repository.dart';
// import 'package:care4parents/domain/repositories/user_repository.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';

// part 'authentication_event.dart';
// part 'authentication_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   AuthenticationBloc({
//     @required AuthenticationRepository authenticationRepository,
//     @required UserRepository userRepository,
//   })  : assert(authenticationRepository != null),
//         assert(userRepository != null),
//         _authenticationRepository = authenticationRepository,
//         _userRepository = userRepository,
//         super(const AuthenticationState.unknown()) {
//     // _authenticationStatusSubscription = _authenticationRepository.status.listen(
//     //   (status) => add(AuthenticationStatusChanged(status)),
//     // );
//   }

//   final AuthenticationRepository _authenticationRepository;
//   final UserRepository _userRepository;
//   StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

//   @override
//   Stream<AuthenticationState> mapEventToState(
//     AuthenticationEvent event,
//   ) async* {
//     if (event is AuthenticationStatusChanged) {
//       yield await _mapAuthenticationStatusChangedToState(event);
//     } else if (event is AuthenticationLogoutRequested) {
//       _authenticationRepository.logOut();
//     }
//   }

//   @override
//   Future<void> close() {
//     _authenticationStatusSubscription?.cancel();
//     _authenticationRepository.dispose();
//     return super.close();
//   }

//   Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
//     AuthenticationStatusChanged event,
//   ) async {
//     switch (event.status) {
//       case AuthenticationStatus.unauthenticated:
//         return const AuthenticationState.unauthenticated();
//       case AuthenticationStatus.authenticated:
//         final user = await _tryGetUser();
//         return user != null
//             ? AuthenticationState.authenticated(user)
//             : const AuthenticationState.unauthenticated();
//       default:
//         return const AuthenticationState.unknown();
//     }
//   }

//   Future<User> _tryGetUser() async {
//     try {
//       final user = await _userRepository.getUser();
//       return user;
//     } on Exception {
//       return null;
//     }
//   }
// }
