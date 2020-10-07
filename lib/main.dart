import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pmreport/blocs/simple_bloc_observer.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:pmreport/ui/navigator/app.dart';
import 'package:pmreport/ui/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  EquatableConfig.stringify = kDebugMode;

  Bloc.observer = SimpleBlocObserver();
  runApp(App(authenticationRepository: AuthenticationRepository()));

  // runApp(AppView());

}



