import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pmreport/authentication/authentication.dart';
import 'package:pmreport/blocs/authentication/authentication.dart';
import 'package:pmreport/blocs/categories/categories.dart';
import 'package:pmreport/ui/category/view/category_page.dart';
import 'package:pmreport/ui/home/home.dart';
import 'package:pmreport/ui/login/login.dart';
import 'package:pmreport/ui/measure/view/measure_page.dart';
import 'package:pmreport/ui/part/view/part_page.dart';
import 'package:pmreport/ui/report/view/report_page.dart';
import 'package:pmreport/ui/splash/splash.dart';
import 'package:pmreport/ui/topic/view/topic_page.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

import '../theme.dart';
// import 'package:pmreport/home/home.dart';
// import 'package:pmreport/login/login.dart';
// import 'package:pmreport/splash/splash.dart';
// import 'package:pmreport/theme.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: AppView(),
      ),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<AuthenticationBloc>(
    //       create: (context) {
    //         return AuthenticationBloc(
    //           authenticationRepository: authenticationRepository,
    //         );
    //       },
    //       child: AppView(),
    //     ),
    //     BlocProvider<CategoriesBloc>(
    //       create: (context) {
    //         return CategoriesBloc(
    //           categoriesRepository: FirebaseCategoriesRepository(),
    //         )..add(LoadCategories());
    //       },
    //     ),
    //   ],
    //   child: AppView(),
    // );
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
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
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
          child: child,
        );
      },
      // onGenerateRoute: (_) => SplashPage.route(),
      onGenerateRoute: (settings) {
        // Handle '/'
        if(settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomePage());
        } else if(settings.name == '/report') {
          return MaterialPageRoute(builder: (context) => ReportPage());
        } else if(settings.name == '/measure') {
          return MaterialPageRoute(builder: (context) => MeasurePage());
        }
        var uri = Uri.parse(settings.name);
        if(uri.pathSegments.length == 2) {
          var uid = uri.pathSegments[1];
          Category category = settings.arguments;
          switch (uri.pathSegments.first) {
            case 'category':
              {
                return MaterialPageRoute(builder: (context) => CategoryPage(categoryUid: uid, category: category));
              }
              break;
          }
        }

        if(uri.pathSegments.length == 4) {
          var path = uri.pathSegments[2];
          var categoryUid = uri.pathSegments[1];
          var partUid = uri.pathSegments[3];
          Part part = settings.arguments;
          switch (path) {
            case 'part':
              {
                return MaterialPageRoute(builder: (context) => PartPage(categoryUid: categoryUid, partUid: partUid, part: part));
              }
              break;
          }
        }

        if(uri.pathSegments.length == 6) {
          var path = uri.pathSegments[4];
          var categoryUid = uri.pathSegments[1];
          var partUid = uri.pathSegments[3];
          var topicUid = uri.pathSegments[5];
          Topic topic = settings.arguments;
          switch (path) {
            case 'topic':
              {
                return MaterialPageRoute(builder: (context) => TopicPage(categoryUid: categoryUid, partUid: partUid, topicUid: topicUid, topic: topic));
              }
              break;
          }
        }
        return MaterialPageRoute(builder: (context) => UnknownScreen());
      },

    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404 - Page not found'),
      ),
    );
  }
}
