import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pmreport/blocs/blocs.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';
import 'package:pmreport/utils/sizes_helpers.dart';

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
          return Container(
            height: displayHeight(context) * 0.15,
            width: displayWidth(context),
            child: Expanded(
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Bounce(
                    duration: Duration(milliseconds: 100),
                    child: Image.asset(
                      'assets/measurement_menu_normal.png',
                      fit: BoxFit.fill,
                    ),
                    onPressed: () {
                      print('${categories[index].name} pressed...');
                    },
                  );
                },
                autoplay: false,
                itemCount: categories.length,
                pagination: new SwiperPagination(
                    margin: new EdgeInsets.all(0.0),
                    builder: new SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return new ConstrainedBox(
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              "${categories[config.activeIndex].name} ${config.activeIndex + 1}/${config.itemCount}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            new Expanded(
                              child: new Align(
                                alignment: Alignment.centerRight,
                                child: new DotSwiperPaginationBuilder(
                                    color: Colors.black12,
                                    activeColor: Colors.black,
                                    size: 10.0,
                                    activeSize: 20.0)
                                    .build(context, config),
                              ),
                            )
                          ],
                        ),
                        constraints: new BoxConstraints.expand(height: 50.0),
                      );
                    }
                    )
                ),
                control: new SwiperControl(color: Colors.redAccent),
              ),
            ),
          );
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
}
