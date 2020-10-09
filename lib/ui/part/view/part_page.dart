import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/authentication/authentication.dart';
import 'package:pmreport/blocs/categories/categories.dart';
import 'package:pmreport/blocs/parts/parts.dart';
import 'package:pmreport/blocs/topics/topics_bloc.dart';
import 'package:pmreport/ui/category/widgets/category_menu.dart';
import 'package:pmreport/ui/part/widgets/part_menu.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class PartPage extends StatelessWidget {
  String categoryUid;
  String partUid;

  PartPage({this.categoryUid, this.partUid});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PartPage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.bloc<AuthenticationBloc>().state.user;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PartsBloc>(
            create: (context) {
              print('************ call load parts ***********');
              return PartsBloc(
                partsRepository: FirebasePartsRepository(),
              )..add(LoadParts(categoryUid));
            },

          ),
        ],
        child: BlocBuilder<PartsBloc, PartsState>(
          builder: (context, state) {
            if(state is PartsLoaded) {
              final parts = state.parts;
              print('${parts.length}');
              String partName = getPartNameByUid(parts);

              return buildPage(context, partName);
            } else if(state is PartsLoading) {
              return CircularProgressIndicator();
            }

          },
        ),
      ),
    );

  }

  String getPartNameByUid(List<Part> parts) {
    String result = '';
    parts.forEach((element) {
      if(partUid == element.uid) {
        result = element.name;
      }
    });
    return result;
  }

  Scaffold buildPage(BuildContext context, String partName) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${partName} - [Part]',
          style: TextStyle(
            fontSize: 14,

          ),),
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
            BlocProvider<TopicsBloc>(
              create: (context) {
                print('************ call load parts ***********');
                return TopicsBloc(
                  topicsRepository: FirebaseTopicsRepository(),
                )..add(LoadTopics(categoryUid, partUid));
              },
            ),
            BlocProvider<PartsBloc>(
              create: (context) {
                print('************ call load parts ***********');
                return PartsBloc(
                  partsRepository: FirebasePartsRepository(),
                )..add(LoadParts(categoryUid));
              },
            ),
            BlocProvider<CategoriesBloc>(
              create: (context) {
                print('************ call load categories ***********');
                return CategoriesBloc(
                  categoriesRepository: FirebaseCategoriesRepository(),
                )..add(LoadCategories());
              },

            ),
          ],

          child: PartMenu(categoryUid: categoryUid, partUid: partUid),
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
      // ),
    );
  }
}
