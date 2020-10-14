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
import 'package:pmreport/ui/part/widgets/topics_menu.dart';
import 'package:pmreport/ui/topic/widgets/items_menu.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class TopicMenu extends StatelessWidget {
  String categoryUid;
  String partUid;
  String topicUid;
  TopicMenu({Key key, this.categoryUid, this.partUid, this.topicUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<CategoriesBloc>().state.categories;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Items List',
          style: TextStyle(
            fontSize: 18,
            color: Colors.brown
          ),),
          ItemsMenu(categoryUid: categoryUid, partUid: partUid, topicUid: topicUid,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Bounce(
                duration: Duration(milliseconds: 100),
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
