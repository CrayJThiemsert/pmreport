import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/itemdatas/itemdatas_bloc.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';


import 'package:pmreport/utils/constants.dart';
import 'package:pmreport/utils/dialog_widget.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';


class InputTypeForm extends StatefulWidget {
  String uid;
  String yesFunc;
  String yesText;
  String noText;
  String inputType;
  String value;
  Item item;
  ItemData itemData;
  ItemDatasBloc itemDatasBloc;

  InputTypeForm(
      {Key key, this.uid, this.yesFunc, this.yesText, this.noText, this.inputType, this.value, this.item, this.itemData, this.itemDatasBloc})
      : super(key: key);

  @override
  _InputTypeFormState createState() => _InputTypeFormState(
      this.uid, this.yesFunc, this.yesText, this.noText, this.inputType, this.value, this.item, this.itemData, this.itemDatasBloc);
}

class _InputTypeFormState extends State<InputTypeForm>
    with TickerProviderStateMixin {
  String uid;
  String yesFunc;
  String yesText;
  String noText;
  String inputType;
  String _value;
  Item item;
  ItemData itemData;
  ItemDatasBloc itemDatasBloc;

  _InputTypeFormState(
      String uid, String yesFunc, String yesText, String noText, String inputType, String value, Item item, ItemData itemData, ItemDatasBloc itemDatasBloc)
      : this.uid = uid == 'n/a' ? '' : uid,
        this.yesFunc = yesFunc,
        this.yesText = yesText,
        this.noText = noText,
        this.inputType = inputType,
        this._value = value,
        this.item = item,
        this.itemData = itemData,
        this.itemDatasBloc = itemDatasBloc;

  bool isSelected = false;
  List<String> chipsList = List<String>();
  List<bool> chipsIsSelectedList = List<bool>();

  @override
  List<Object> get props => [chipsIsSelectedList, _value];

  @override
  void initState() {
    super.initState();

    switch (inputType) {
    // - single_options_ok {Ok, [default Empty or Blank]}
    // - single_options_testing {Pass, Monitoring, Maintenance} (ใช้ "Pass" แทนกรณีที่ค่าเป็น "Normal" ด้วยเลย)
    // - multiple_options_condition {Dirtiness, Degradation, Clean, Normal, [default Empty or Blank]}
    // - multiple_options_lightning_arrester {Dirtiness, Degradation, Clean, Normal, [default Empty or Blank]}
    // - multiple_options_drop_fuse_cut_out {Dirtiness, Damage, Degradation, Clean, Normal, [default Empty or Blank]}
    // - multiple_options_connection {Loosening, Burn, Damage, Normal, [default Empty or Blank]}
    // - multiple_options_ground {Burn, Damage, Normal, [default Empty or Blank]}
      case 'single_options_ok':
        {
          chipsList = Constants.single_options_ok;
          break;
        }
      case 'single_options_testing':
        {
          chipsList = Constants.single_options_testing;
          break;
        }
      case 'multiple_options_condition':
        {
          chipsList = Constants.multiple_options_condition;
          break;
        }
      case 'multiple_options_lightning_arrester':
        {
          chipsList = Constants.multiple_options_lightning_arrester;
          break;
        }
      case 'multiple_options_drop_fuse_cut_out':
        {
          chipsList = Constants.multiple_options_drop_fuse_cut_out;
          break;
        }
      case 'multiple_options_connection':
        {
          chipsList = Constants.multiple_options_connection;
          break;
        }
      case 'multiple_options_ground':
        {
          chipsList = Constants.multiple_options_ground;
          break;
        }
    }

    print('uid[${uid}] - chipsList.length[${chipsList.length}]');

    for (int i = 0; i < chipsList.length; i++) {
      print('add false to chipsIsSelectedList no. ${chipsIsSelectedList.length}');
      chipsIsSelectedList.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget _widget = Container(
    //   height: 20,
    //   width: 30,
    // );
    print('Building input form===');
    List<Widget> _widgets = List<Widget>();


    switch (inputType) {
      case 'integer':
      case 'decimal':
      case 'text':
        {
          _widgets.add(SingleChildScrollView(
            child: TextFormField(
              initialValue: _value,
              decoration: InputDecoration(
                prefixIcon: DialogUtils().prefixIconByFunction(yesFunc),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.limeAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.limeAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              maxLength: DialogUtils().maxLengthByFunction(yesFunc),
              maxLines: DialogUtils().maxLinesByFunction(yesFunc),
              autofocus: false,
              keyboardType: DialogUtils().keyboardTypeByFunction(inputType),
              onFieldSubmitted: (value) {
                print('onFieldSubmitted value[${value}]');
                _value = value;
              },
              onChanged: (text) {
                _value = text;
              },
              style: TextStyle(
                fontFamily: 'K2D-Regular',
                color: Colors.grey[800],
              ),
            ),
          ));
          break;
        }
    }

    // print('uid[${uid}] - chipsList.length[${chipsList.length}]');

    for (int i = 0; i < chipsList.length; i++) {
      String chipName = chipsList[i];
      _widgets.add(buildFilterChip(chipName: chipName, index: i));
    }

    _widgets.add(Divider(
      color: Colors.white,
    ));
    _widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          color: Colors.grey[800],
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1)),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
          child: Text(
            noText,
            style: TextStyle(
              fontFamily: 'K2D-Medium',
              color: Colors.white,
            ),
          ),
        ),
        FlatButton(
          color: Colors.grey[800],
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1)),
          onPressed: () => doFunctionWithValue(_value, chipsIsSelectedList),
          // onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
          child: Text(
            yesText,
            style: TextStyle(
              fontFamily: 'K2D-Medium',
              color: Colors.white,
            ),
          ),
        ),
      ],
    ));

    // return BlocBuilder<ItemDatasBloc, ItemDatasState> (
    //   builder: (context, state) {
      //   if(state is ItemDatasLoading) {
      //     return LoadingIndicator();
      //   } else if(state is ItemDatasNotLoaded) {
      //   } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: _widgets,
            ),
          );
        // }
      // },
    // );
    //   BlocProvider(
    //   create: (BuildContext context) => ItemDatasBloc(itemDatasRepository: FirebaseItemDatasRepository()),
    //   child: SingleChildScrollView(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       // crossAxisAlignment: CrossAxisAlignment.start,
    //       children: _widgets,
    //     ),
    //   ),
    // );
  }

  FilterChip buildFilterChip({String chipName, int index}) {
    return FilterChip(
        selected: chipsIsSelectedList[index],
        label: Text(chipName),
        selectedColor: Colors.lightGreen,
        // avatar: Text('W'),
        onSelected: (onSelected) {
          setState(() {
            chipsIsSelectedList[index] = !chipsIsSelectedList[index];
          });
        });
  }

  doFunctionWithValue(String value, List<bool> chipsIsSelectedList) {
    print('item: ${item}');
    print('itemData: ${itemData}');
    print('value: ${value}');
    print('itemData.inputType: ${itemData.inputType}');
    print('itemData.inputType: ${itemData.inputType}');
    print('chipsIsSelectedList: ${chipsIsSelectedList} = ${chipsIsSelectedList.toString()}');


    switch (itemData.inputType) {
      case 'integer':
      case 'decimal':
      case 'text':
        {
          itemData.value = value;
          break;
        }

      case 'single_options_ok':
      case 'single_options_testing':
      case 'multiple_options_condition':
      case 'multiple_options_lightning_arrester':
      case 'multiple_options_drop_fuse_cut_out':
      case 'multiple_options_connection':
      case 'multiple_options_ground':
        {
          if(chipsIsSelectedList.length > 0) {
            itemData.value = chipsIsSelectedList.toString();
            itemData.value = itemData.value.replaceAll('[', '').replaceAll(']', '');
          }
          break;
        }

    }
    print('value: ${itemData.value}');

    // ItemData itemData = ItemData(
    //   uid: uid,
    //   value: value,
    //   index:
    // );

    // final itemDatasBloc = BlocProvider.of<ItemDatasBloc>(context);
    //
    // if(itemDatasBloc != null) {
      itemDatasBloc.add(
        AddItemData(item.topic.part.category.uid,
            item.topic.part.uid,
            item.topic.uid,
            item.topic,
            item,
            itemData),
      );
    // }


    // BlocProvider<ItemDatasBloc>(
    //   create: (context) {
    //     return ItemDatasBloc(
    //       itemDatasRepository: FirebaseItemDatasRepository(),
    //     )..add(AddItemData(item.topic.part.category.uid,
    //         item.topic.part.uid,
    //         item.topic.uid,
    //         item.topic,
    //         item,
    //         itemData));
    //   },
    // );

    Navigator.of(context, rootNavigator: true).pop(false);
  }
}
