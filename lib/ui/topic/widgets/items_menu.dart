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
            height: displayHeight(context) * 0.22,
            width: displayWidth(context),
            // color: Colors.blueAccent,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                // final item = (items.length == 0) ? templateItems[index] : items[index];
                final item = items[index];
                return Bounce(
                  duration: Duration(milliseconds: 100),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/${categoryUid}_h96.png',
                        fit: BoxFit.fitHeight,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0,),
                        child: new Text(
                          "${item.name}",
                          style: TextStyle(fontSize: 20.0, color: Colors.brown),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    print('${item.name} pressed...');
                    // String uri = '/category/${categoryUid}/part/${partUid}/topic/${topicUid}/item/${items[index].uid}';
                    // print('${uri} pressed...');
                    // Navigator.pushNamed(context, uri);
                  },
                );
              },
              autoplay: false,
              // itemCount: (items.length == 0) ? templateItems.length : items.length,
              itemCount: items.length,
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
