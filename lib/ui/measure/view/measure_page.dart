import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/authentication/authentication.dart';
import 'package:pmreport/blocs/categories/categories.dart';
import 'package:pmreport/ui/home/widgets/home_menu.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';
import 'package:pmreport/ui/measure/widgets/measure_menu.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class MeasurePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MeasurePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.bloc<AuthenticationBloc>().state.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Measure'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .bloc<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),

      // stable version ===================
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CategoriesBloc>(
              create: (context) {
                print('************ call load category ***********');
                return CategoriesBloc(
                  categoriesRepository: FirebaseCategoriesRepository(),
                )..add(LoadCategories());
              },

            ),
          ],
          child: MeasureMenu(),
        ),
      ),




      // body: Align(
      //   alignment: const Alignment(0, -1 / 3),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       Avatar(photo: user.photoURL),
      //       const SizedBox(height: 4.0),
      //       Text(user.email, style: textTheme.headline6),
      //       const SizedBox(height: 4.0),
      //       Text(user.displayName ?? '', style: textTheme.headline5),
      //     ],
      //   ),
      // ),
    );
  }
}
