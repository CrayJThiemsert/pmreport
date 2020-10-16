import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pmreport/blocs/blocs.dart';
import 'package:pmreport/blocs/items/items_bloc.dart';
import 'package:pmreport/blocs/parts/parts.dart';
import 'package:pmreport/blocs/topics/topics_bloc.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';
import 'package:pmreport/utils/dialog_widget.dart';
import 'package:pmreport/utils/sizes_helpers.dart';
import 'package:preventive_maintenance_repository/src/models/item.dart';

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

          if(items.length > 0) {
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
                          height: displayHeight(context) * 0.5,
                          width: displayWidth(context),
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
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              buildDataArea(context, item),
                            ),
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
          } else {
            // DialogUtils().showMessageDialog(
            //   context,
            //   'Message',
            //   'Item data not found.',
            //   'OK',
            // );
            return AlertDialog(
              title: new Text("Message"),
              content: new Text("Item data not found."),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(false);
                  },
                ),
              ],
            );

            // return Container(
            //   child: Text('Item data not found'),
            // );
          }
        }
      },
    );
  }

  List<Widget> buildDataArea(BuildContext context, Item item) {
    List<Widget> widgets = new List();

    // item index + item name
    widgets.add(Text(
      "${item.index}. ${item.name}",
      style: TextStyle(fontSize: 20.0, color: Colors.brown),
    )
    );
    for(int i=2;i<item.headers.length;i++){
      switch(i % 2) {
        case 0: { // left
          print('left[${i}] ${item.headers[i].uid}');
          Widget leftWidget = buildDataItem(context, item, i);
          widgets.add(leftWidget);
        }
        break;
        case 1: { // right
          print('right[${i}] ${item.name}');
          Widget rightWidget = buildDataItem(context, item, i);
          widgets.add(rightWidget);
        }
        break;

        default:
        break;

      }
    }

    return widgets;
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [

        // }
    //   ],
    // );
  }

  String getDataValue(String headerUid, Item item) {
    String dataValue = 'n/a';
    for(int i=0; i<item.itemDatas.length;i++) {
      if(item.itemDatas[i].uid == headerUid) {
        dataValue = item.itemDatas[i].value;
        return dataValue;
      }
    }
    return dataValue;
  }

  Widget buildDataItem(BuildContext context, Item item, int i) {
    String dataValue = getDataValue(item.headers[i].uid, item);
    print('<<<${dataValue}>>> item no.${item.index} [${item.uid}] header[${item.headers[i].uid}');

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Bounce(
          duration: Duration(milliseconds: 100),
          child: Container(
            height: displayHeight(context) * 0.07,
            width: displayWidth(context) * 0.38,
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
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('${item.headers[i].name}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal
                  ),
                ),
                Text(
                  '${dataValue}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            DialogUtils().showEditTextDialog(
              context: context,
              title: 'Input Data',
              yesText: 'Save',
              noText: 'Cancel',
              inputType: item.headers[i].inputType,
              content: dataValue,
            );
            // DialogUtils().showMessageDialog(
            //   context,
            //   'Message',
            //   'Input Item data here.',
            //   'OK',
            // );
          },
        ),
    );
  }
}
