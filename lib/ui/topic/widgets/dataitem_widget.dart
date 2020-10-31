import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:pmreport/blocs/itemdatas/itemdatas.dart';
import 'package:pmreport/blocs/items/items.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';
import 'package:pmreport/utils/constants.dart';
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
  List<String> availableOptionsList = List<String>();

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
                          if(itemDataStream.uid == null) {
                            itemDataStream = ItemData(
                              id: header.uid,
                              uid: header.uid,
                              index: header.index,
                              inputType: header.inputType,
                              name: header.name,
                              itemUid: item.uid,
                              value: '',
                            );
                          }

                          if(header.uid == itemDataStream.uid) {
                            displayValue = '${itemDataStream.value}';
                          }
                          
                          displayValue = getSelectedDisplayValue(header.inputType, itemDataStream.value);
                          print('displayValue[${displayValue}] displayValue.length[${displayValue.length}]');

                          return Text(
                            '${displayValue}',
                            style: TextStyle(
                              fontSize: (displayValue.length > 20) ? 8 : 14,
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
          content: itemDataStream.value,
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

  String getSelectedDisplayValue(String inputType, String value) {
    String result = '';

    if(value == null) {
      print('result=${result}');
      return result;
    }
    switch (inputType) {
      case 'integer':
      case 'decimal':
      case 'text':
        {
          return value;
          break;
        }
    // - single_options_ok {Ok, [default Empty or Blank]}
    // - single_options_testing {Pass, Monitoring, Maintenance} (ใช้ "Pass" แทนกรณีที่ค่าเป็น "Normal" ด้วยเลย)
    // - multiple_options_condition {Dirtiness, Degradation, Clean, Normal, [default Empty or Blank]}
    // - multiple_options_lightning_arrester {Dirtiness, Degradation, Clean, Normal, [default Empty or Blank]}
    // - multiple_options_drop_fuse_cut_out {Dirtiness, Damage, Degradation, Clean, Normal, [default Empty or Blank]}
    // - multiple_options_connection {Loosening, Burn, Damage, Normal, [default Empty or Blank]}
    // - multiple_options_ground {Burn, Damage, Normal, [default Empty or Blank]}
      case 'single_options_ok':
        {
          availableOptionsList = Constants.single_options_ok;
          break;
        }
      case 'single_options_testing':
        {
          availableOptionsList = Constants.single_options_testing;
          break;
        }
      case 'multiple_options_condition':
        {
          availableOptionsList = Constants.multiple_options_condition;
          break;
        }
      case 'multiple_options_lightning_arrester':
        {
          availableOptionsList = Constants.multiple_options_lightning_arrester;
          break;
        }
      case 'multiple_options_drop_fuse_cut_out':
        {
          availableOptionsList = Constants.multiple_options_drop_fuse_cut_out;
          break;
        }
      case 'multiple_options_connection':
        {
          availableOptionsList = Constants.multiple_options_connection;
          break;
        }
      case 'multiple_options_ground':
        {
          availableOptionsList = Constants.multiple_options_ground;
          break;
        }
    }

    print('db value[${value}] - availableOptionsList[${availableOptionsList}]');

    final valueList = value.split(',');
    print('valueList[${valueList}]');

    if(value == null || value == '') {
      print('result=${result}');
      return result;
    }

    for (int i = 0; i < availableOptionsList.length; i++) {
      if(valueList[i].trim() == 'true') {
        print(
            'availableOptionsList[$i]=${availableOptionsList[i]}');
        if(result == '') {
          result = '${availableOptionsList[i]}';
        } else {
          result = result + ', ${availableOptionsList[i]}';
        }
      }
    }
    print('result=${result}');
    return result;
  }
}
