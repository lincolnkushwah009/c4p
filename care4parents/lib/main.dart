import 'package:care4parents/presentation/care4_parents_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;

// import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  await Firebase.initializeApp();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  // HydratedBloc.storage = await HydratedStorage.build();
  runApp(Care4ParentsApp());
}
