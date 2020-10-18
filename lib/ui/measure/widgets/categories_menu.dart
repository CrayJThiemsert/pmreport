import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pmreport/blocs/blocs.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';
import 'package:pmreport/utils/sizes_helpers.dart';
import 'package:preventive_maintenance_repository/src/models/category.dart';

class CategoriesMenu extends StatelessWidget {
  CategoriesMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {

        if(state is CategoriesLoading) {
          return LoadingIndicator();
        } else if(state is CategoriesNotLoaded) {
          return Container(
            child: Text('Data not found'),
          );
        } else if(state is CategoriesLoaded) {
          final categories = state.categories;
          return buildBottomSwiperMenu(context, categories);
          // return Container(
          //   child: ListView.builder(
          //     itemCount: categories.length,
          //     itemBuilder: (context, index) {
          //       final category = categories[index];
          //       return Container(
          //         child: Center(
          //           child: Text('${category.name}'),
          //         ),
          //       );
          //     },
          //   ),
          // );
        }
      },
    );
  }

  Container buildBottomSwiperMenu(BuildContext context, List<Category> categories) {
    return Container(
          height: displayHeight(context) * 0.28,
          width: displayWidth(context),
          // color: Colors.blueAccent,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Bounce(
                duration: Duration(milliseconds: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/${categories[index].uid}_h96.png',
                      fit: BoxFit.fitHeight,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0,),
                      child: new Text(
                        "${categories[index].index}. ${categories[index].name}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0, color: Colors.brown),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  String uri = '/category/${categories[index].uid}';
                  print('${uri} pressed...');
                  Navigator.pushNamed(context, uri);
                },
              );
            },
            autoplay: false,
            itemCount: categories.length,
            pagination: new SwiperPagination(
                margin: new EdgeInsets.all(0.0),
                builder: new SwiperCustomPagination(builder:
                    (BuildContext context, SwiperPluginConfig config) {
                  // return new ConstrainedBox(
                  //   child: new Row(
                  //     children: <Widget>[
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 16),
                        //   child: new Text(
                        //     "${categories[config.activeIndex].name} ${config.activeIndex + 1}/${config.itemCount}",
                        //     style: TextStyle(fontSize: 20.0),
                        //   ),
                        // ),
                        // new Expanded(
                        //   child: new Align(
                        //     alignment: Alignment.bottomCenter,
                        //     child: new
                      return      DotSwiperPaginationBuilder(
                                color: Colors.black12,
                                activeColor: Colors.brown,
                                size: 5.0,
                                activeSize: 10.0)
                                 .build(context, config);
                           // );
                        // )
                      // ],
                    // ),
                    // constraints: new BoxConstraints.expand(height: 30.0),
                  // );
                }
                )
            ),
            control: new SwiperControl(color: Colors.redAccent),
          ),
        );
  }
}
