import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pmreport/blocs/blocs.dart';
import 'package:pmreport/blocs/items/items_bloc.dart';
import 'package:pmreport/blocs/parts/parts.dart';
import 'package:pmreport/blocs/topics/topics_bloc.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';
import 'package:pmreport/utils/sizes_helpers.dart';

class ItemsMenu extends StatelessWidget {
  String categoryUid;
  String partUid;
  String topicUid;
  ItemsMenu({Key key, this.categoryUid, this.partUid, this.topicUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {

        if(state is ItemsLoading) {
          return LoadingIndicator();
        } else if(state is ItemsNotLoaded) {
          return Container(
            child: Text('Data not found'),
          );
        } else if(state is ItemsLoaded) {

          final items = state.items;
          // final templateItems = state.items;

          return Container(
            height: displayHeight(context) * 0.6,
            width: displayWidth(context),
            color: Colors.lightGreen[50],
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                // final item = (items.length == 0) ? templateItems[index] : items[index];
                final item = items[index];
                return Column(
                    children: [
                      // Image.asset(
                      //   'assets/${categoryUid}_h96.png',
                      //   fit: BoxFit.fitHeight,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0,),
                        child: Container(
                          height: displayHeight(context) * 0.6,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.amber[600],
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.brown[400],
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.brown[400], Colors.brown[50]]
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${item.name}",
                                style: TextStyle(fontSize: 20.0, color: Colors.brown),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Bounce(
                                    duration: Duration(milliseconds: 100),
                                    child: Container(
                                      height: displayHeight(context) * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.amber[800],
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [Colors.amber[800], Colors.amber[50]]
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text('${item.headers[1].name}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal
                                            ),
                                          ),
                                          Text('${item.name}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Bounce(
                                    duration: Duration(milliseconds: 100),
                                    child: Container(
                                      height: displayHeight(context) * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.amber[800],
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [Colors.amber[800], Colors.amber[50]]
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text('${item.headers[2].name}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal
                                            ),
                                          ),
                                          Text('${item.itemDatas.length > 0 ?? item.itemDatas[2].value ?? '0'}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Bounce(
                                    duration: Duration(milliseconds: 100),
                                    child: Container(
                                      height: displayHeight(context) * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.amber[800],
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [Colors.amber[800], Colors.amber[50]]
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text('${item.headers[3].name}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal
                                            ),
                                          ),
                                          Text('${0}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
              },
              autoplay: false,
              // itemCount: (items.length == 0) ? templateItems.length : items.length,
              itemCount: items.length,
              itemWidth: 300.0,
              itemHeight: 400.0,
              layout: SwiperLayout.TINDER,
              pagination: new SwiperPagination(
                  margin: new EdgeInsets.all(0.0),
                  builder: new SwiperCustomPagination(builder:
                      (BuildContext context, SwiperPluginConfig config) {
                        return DotSwiperPaginationBuilder(
                                  color: Colors.black12,
                                  activeColor: Colors.brown,
                                  size: 5.0,
                                  activeSize: 10.0
                          ).build(context, config);
                  }
                  )
              ),
              control: new SwiperControl(color: Colors.redAccent),
            ),
          );
        }
      },
    );
  }
}
