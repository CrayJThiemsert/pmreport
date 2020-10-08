import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/authentication/authentication.dart';
import 'package:pmreport/blocs/categories/categories.dart';
import 'package:pmreport/ui/home/home.dart';
import 'package:pmreport/ui/measure/widgets/categories_menu.dart';
import 'package:pmreport/ui/home/widgets/home_menu.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.bloc<AuthenticationBloc>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CategoriesBloc>(
              create: (context) {
                return CategoriesBloc(
                  categoriesRepository: FirebaseCategoriesRepository(),
                )..add(LoadCategories());
              },

            ),
          ],
          child: HomeMenu(),
        ),
      ),

      // body: BlocProvider<CategoriesBloc>(
      //     builder: (context, state) {
      //       HomeMenu();
      //     }
      //     create: (context) {
      //       return CategoriesBloc(
      //         categoriesRepository: FirebaseCategoriesRepository(),
      //       )..add(LoadCategories());
      //     },
      //
      //   ),
      // HomeMenu(),
      // body: CategoriesMenu(),


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
