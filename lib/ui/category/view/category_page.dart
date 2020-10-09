import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/authentication/authentication.dart';
import 'package:pmreport/blocs/categories/categories.dart';
import 'package:pmreport/blocs/parts/parts.dart';
import 'package:pmreport/ui/category/widgets/category_menu.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class CategoryPage extends StatelessWidget {
  String categoryUid;

  CategoryPage({this.categoryUid});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CategoryPage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.bloc<AuthenticationBloc>().state.user;
    return Padding(
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
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if(state is CategoriesLoaded) {
                final categories = state.categories;
                print('${categories.length}');
                String categoryName = getCategoryNameByUid(categories);

                return buildPage(context, categoryName);
              } else if(state is CategoriesLoading) {
                return CircularProgressIndicator();
              }

            },
        ),
      ),
    );

  }

  String getCategoryNameByUid(List<Category> categories) {
    String result = '';
    categories.forEach((element) {
      if(categoryUid == element.uid) {
        result = element.name;
      }
    });
    return result;
  }

  Scaffold buildPage(BuildContext context, String categoryName) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${categoryName} - [Category]',
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

          child: CategoryMenu(categoryUid: categoryUid,),
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
