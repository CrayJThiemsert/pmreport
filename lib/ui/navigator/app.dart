import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:pmreport/blocs/authentication/authentication.dart';
import 'package:pmreport/blocs/categories/categories_bloc.dart';
import 'package:pmreport/ui/category/view/category_page.dart';
import 'package:pmreport/ui/home/home.dart';
import 'package:pmreport/ui/login/login.dart';
import 'package:pmreport/ui/measure/view/measure_page.dart';
import 'package:pmreport/ui/navigator/router.dart';
import 'package:pmreport/ui/report/view/report_page.dart';
import 'package:pmreport/ui/splash/splash.dart';
import 'package:pmreport/ui/theme.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

// class App extends StatefulWidget {
class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
  })
      : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

//   @override
//   _NestedRouterDemoState createState() => _NestedRouterDemoState(this.authenticationRepository);
// }
//
// class _NestedRouterDemoState extends State<App> {
//   final AuthenticationRepository authenticationRepository;
//   _NestedRouterDemoState(this.authenticationRepository);



  @override
  Widget build(BuildContext context) {
    // Very old - not used anymore
    // return RepositoryProvider.value(
    //   value: authenticationRepository,
    //   child: BlocProvider(
    //     create: (_) => AuthenticationBloc(
    //       authenticationRepository: authenticationRepository,
    //     ),
    //     child: AppView(),
    //   ),
    // );
    // ===================================

    // return AppView();
    // ===================================
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
  // AppRouterDelegate _routerDelegate = AppRouterDelegate();
  // AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   title: 'PM Report v.1',
    //   theme: theme,
    //   routeInformationParser: _routeInformationParser,
    //   routerDelegate: _routerDelegate,
    // );

    // Can used for previous multi bloc providers. ===============================
    return MaterialApp(
      title: "PM Report",
      theme: theme,
      navigatorKey: _navigatorKey,
      onGenerateRoute: (settings) {
        // Handle '/'
        switch (settings.name) {
          case '/':
            {
              return MaterialPageRoute(builder: (context) => HomePage());
            }
            break;
          case '/report':
            {
              return MaterialPageRoute(builder: (context) => ReportPage());
            }
            break;
          case '/measure':
            {
              return MaterialPageRoute(builder: (context) => MeasurePage());
            }
            break;
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'category') {
          var uid = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => CategoryPage(uid: uid));
        }

        return MaterialPageRoute(builder: (context) => SplashPage());
      },

      // routes: {
      //   '/': (context) {
      //     return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //       builder: (context, state) {
      //         switch (state.status) {
      //           case AuthenticationStatus.authenticated:
      //             {
      //               _navigator.pushAndRemoveUntil<void>(
      //                 HomePage.route(),
      //                     (route) => false,
      //               );
      //             }
      //             break;
      //           case AuthenticationStatus.unauthenticated:
      //             {
      //               _navigator.pushAndRemoveUntil<void>(
      //                 LoginPage.route(),
      //                     (route) => false,
      //               );
      //             }
      //             break;
      //           case AuthenticationStatus.unknown:
      //             {
      //               return Container();
      //             }
      //             break;
      //
      //           default:
      //             return Container();
      //             // _navigator.pushAndRemoveUntil<void>(
      //             //   SplashPage.route(),
      //             //       (route) => false,
      //             // );
      //             break;
      //         }
      //       },
      //     );
      //
      //   },
      //   // '/': (context) {
      //   // },
      // },
      // onGenerateRoute: (_) => SplashPage.route(),

    );

    // Very old not used anymore =============================
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

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'settings') {
      switch(uri.pathSegments.first) {
        case 'report': {
          return AppReportPath();
        }
        break;
        case 'measure': {
          return AppMeasurePath();
        }
        break;
        default: {
          return AppHomePath();
        }
        break;
      }

    } else {
      if (uri.pathSegments.length >= 2) {
        switch(uri.pathSegments[0]) {
          case 'category': {
            return AppCategoryPath(uri.pathSegments[1]);
          }
          break;
          case 'part': {
            return AppPartPath(uri.pathSegments[1]);
          }
          break;
          case 'topic': {
            return AppTopicPath(uri.pathSegments[1]);
          }
          break;
          case 'item': {
            return AppItemPath(uri.pathSegments[1]);
          }
          break;
          case 'form': {
            return AppFormPath(uri.pathSegments[1]);
          }
          break;
          default: {
            AppHomePath();
          }
          break;
        }
      }
      return AppHomePath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath configuration) {
    // Page without id ======================
    if (configuration is AppHomePath) {
      return RouteInformation(location: '/home');
    }
    if (configuration is AppReportPath) {
      return RouteInformation(location: '/report');
    }
    if (configuration is AppMeasurePath) {
      return RouteInformation(location: '/measure');
    }

    // Page with id =========================
    if (configuration is AppCategoryPath) {
      return RouteInformation(location: '/category/${configuration.uid}');
    }
    if (configuration is AppPartPath) {
      return RouteInformation(location: '/part/${configuration.uid}');
    }
    if (configuration is AppTopicPath) {
      return RouteInformation(location: '/topic/${configuration.uid}');
    }
    if (configuration is AppItemPath) {
      return RouteInformation(location: '/item/${configuration.uid}');
    }
    if (configuration is AppFormPath) {
      return RouteInformation(location: '/form/${configuration.uid}');
    }

    return null;
  }
}