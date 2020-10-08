import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:pmreport/blocs/blocs.dart';

import 'package:pmreport/ui/category/widgets/parts_menu.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/authentication/authentication.dart';
import 'package:pmreport/blocs/categories/categories.dart';
import 'package:pmreport/blocs/parts/parts.dart';
import 'package:pmreport/ui/category/widgets/category_menu.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class CategoryMenu extends StatelessWidget {
  String categoryUid;
  CategoryMenu({Key key, this.categoryUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<CategoriesBloc>().state.categories;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Part',
          style: TextStyle(
            fontSize: 18,
            color: Colors.brown
          ),),
          PartsMenu(categoryUid: categoryUid,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Bounce(
                duration: Duration(milliseconds: 100),
                // child: ToffeeButton('assets/report_menu_normal.png', 'Back'),
                child: Container(
                  // color: Colors.yellowAccent,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.brown,
                        ),
                      ),
                      Text('Back',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  print('Back pressed...');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
