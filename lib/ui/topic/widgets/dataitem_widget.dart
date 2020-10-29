import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:pmreport/blocs/itemdatas/itemdatas.dart';
import 'package:pmreport/blocs/items/items.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';
import 'package:pmreport/utils/dialog_widget.dart';
import 'package:pmreport/utils/sizes_helpers.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class DataItemWidget extends StatefulWidget {
  String categoryUid;
  String partUid;
  String topicUid;
  Topic topic;
  Item item;
  Header header;
  ItemDatasBloc itemDatasBloc;

  DataItemWidget({Key key,
    this.categoryUid,
    this.partUid,
    this.topicUid,
    this.topic,
    this.item,
    this.header,
    this.itemDatasBloc,
  }) : super(key: key);

  @override
  _DataItemWidgetState createState() => _DataItemWidgetState(
    categoryUid: this.categoryUid,
    partUid: this.partUid,
    topicUid: this.topicUid,
    topic: this.topic,
    item: this.item,
    header: this.header,
    itemDatasBloc: this.itemDatasBloc,
  );
}

class _DataItemWidgetState extends State<DataItemWidget> {
  String categoryUid;
  String partUid;
  String topicUid;
  Topic topic;
  Item item;
  Header header;
  ItemDatasBloc itemDatasBloc;

  ItemData itemDataStream;
  String displayValue = '';

  _DataItemWidgetState({
    String categoryUid,
    String partUid,
    String topicUid,
    Topic topic,
    Item item,
    Header header,
    ItemDatasBloc itemDatasBloc,
  }) :
        this.categoryUid = categoryUid,
        this.partUid = partUid,
        this.topicUid = topicUid,
        this.topic = topic,
        this.item = item,
        this.header = header,
        this.itemDatasBloc = itemDatasBloc
      ;

  @override
  Widget build(BuildContext context) {
    print('DataItemWidget****item.uid[${item.uid}] => header|(itemdata).uid[${header.uid}]');

    return Bounce(
      duration: Duration(milliseconds: 100),
      child: Container(
          height: displayHeight(context) * 0.07,
          width: displayWidth(context) * 0.45,
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
              Text('${header.name}',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<ItemDatasBloc>(
                      create: (context) {
                        print('************ call load item data ***********');
                        return ItemDatasBloc(
                          itemDatasRepository: FirebaseItemDatasRepository(),
                          itemsBloc: context.bloc<ItemsBloc>(),
                        )
                        // ..add(LoadTemplateItems(categoryUid, partUid, topicUid, topic));
                        ..add(LoadItemData(categoryUid, partUid, topicUid, topic, item, header.uid));
                      },
                    ),
                  ],
                  child: BlocBuilder<ItemDatasBloc, ItemDatasState>(
                    // buildWhen: (previous, current) {
                    //   print('*previous.itemDataUid[${previous.itemDataUid}] - current.itemDataUid[${current.itemDataUid}]');
                    //   (previous.itemDataUid != current.itemDataUid);
                    //   if(previous is ItemDataLoaded && current is ItemDataLoaded) {
                    //     return (previous.itemData != current.itemData);
                    //   } else {
                    //     return false;
                    //   }
                    //   },
                      builder: (context, state) {
                        if (state is ItemDatasLoading) {
                          print('ItemDatasLoading...');
                          return LoadingIndicator();
                        } else if(state is ItemDatasNotLoaded) {
                          print('ItemDatasNotLoaded...');
                          return Text(
                            'Data not found',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if(state is ItemDataLoaded) {
                          print('ItemDataLoaded...');
                          print('#### item.uid[${item.uid}]=> ${header.uid} - state.itemDatas[${state.itemData}]');
                          itemDataStream = state.itemData;
                          print('>>>itemDataStream=${itemDataStream}');

                          if(header.uid == itemDataStream.uid) {
                            displayValue = '${itemDataStream.value}';
                          }

                          return Text(
                            '${displayValue}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }
                  ),
                ),
              ),
            ],
          ),
      ),
      onPressed: () async {
        print('hit ${itemDataStream.uid}!!');
        // String value = '';
        // if(header.uid == itemDataStream.uid) {
        //   value = '${itemDataStream.value}';
        // }

        print('onpressed >>>itemDataStream.uid=${itemDataStream.uid}');
        final result = await DialogUtils().showInputDialog(
          context: context,
          title: 'Input ${header.name} Data',
          yesText: 'Save',
          noText: 'Cancel',
          inputType: header.inputType,
          key: itemDataStream.uid,
          content: displayValue,
          item: item,
          itemData: itemDataStream,
          itemDatasBloc: itemDatasBloc,
        ).then((value) => refreshItemDataValue());

      },
    );
  }

  refreshItemDataValue() {
    setState(() {
      // Just for help refresh value after submit save dialog
      itemDataStream.value;
    });
  }
}
