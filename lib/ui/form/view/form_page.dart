import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/authentication/authentication.dart';
import 'package:pmreport/ui/home/widgets/home_menu.dart';

class FormPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => FormPage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.bloc<AuthenticationBloc>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
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
      body: HomeMenu(),
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
