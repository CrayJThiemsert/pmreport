import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';


import 'package:authentication_repository/authentication_repository.dart';
import 'package:pmreport/authentication/authentication.dart';
import 'package:pmreport/blocs/categories/categories_bloc.dart';
import 'package:pmreport/home/home.dart';
import 'package:pmreport/login/login.dart';
import 'package:pmreport/splash/splash.dart';
import 'package:pmreport/theme.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    // return RepositoryProvider.value(
    //   value: authenticationRepository,
    //   child: BlocProvider(
    //     create: (_) => AuthenticationBloc(
    //       authenticationRepository: authenticationRepository,
    //     ),
    //     child: AppView(),
    //   ),
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            );
          },
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) {
            return CategoriesBloc(
              categoriesRepository: FirebaseCategoriesRepository(),
            )..add(LoadCategories());
          },
        ),
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PM Report",
      theme: theme,
      navigatorKey: _navigatorKey,
      routes: {
        '/': (context) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(),
                        (route) => false,
                  );
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                        (route) => false,
                  );
                  break;

                default:
                  break;
              }
            },
          );

        },
        // '/': (context) {
        // },
      },
      onGenerateRoute: (_) => SplashPage.route(),

    );

    // return MaterialApp(
    //   theme: theme,
    //   navigatorKey: _navigatorKey,
    //   builder: (context, child) {
    //     return BlocListener<AuthenticationBloc, AuthenticationState>(
    //       listener: (context, state) {
    //         switch (state.status) {
    //           case AuthenticationStatus.authenticated:
    //             _navigator.pushAndRemoveUntil<void>(
    //               HomePage.route(),
    //                   (route) => false,
    //             );
    //             break;
    //           case AuthenticationStatus.unauthenticated:
    //             _navigator.pushAndRemoveUntil<void>(
    //               LoginPage.route(),
    //                   (route) => false,
    //             );
    //             break;
    //           default:
    //             break;
    //         }
    //       },
    //       child: child,
    //     );
    //   },
    //   onGenerateRoute: (_) => SplashPage.route(),
    // );
  }
}