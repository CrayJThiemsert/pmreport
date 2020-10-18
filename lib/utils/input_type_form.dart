import 'package:flutter/material.dart';
import 'package:pmreport/utils/constants.dart';
import 'package:pmreport/utils/dialog_widget.dart';

class InputTypeForm extends StatefulWidget {
  String content;
  String yesFunc;
  String inputType;
  String value;

  InputTypeForm({Key key, this.content, this.yesFunc, this.inputType, this.value}) : super(key: key);

  @override
  _InputTypeFormState createState() => _InputTypeFormState(this.content, this.yesFunc, this.inputType, this.value);
}

class _InputTypeFormState extends State<InputTypeForm> with TickerProviderStateMixin {
  String content;
  String yesFunc;
  String inputType;
  String value;

  _InputTypeFormState(String content, String yesFunc, String inputType, String value) :
    this.content = content == 'n/a' ? '' : content,
    this.yesFunc = yesFunc,
    this.inputType = inputType,
    this.value = value;

  bool isSelected = false;
  List<bool> chipsIsSelectedList = List<bool>();

  @override
  Widget build(BuildContext context) {
    // Widget _widget = Container(
    //   height: 20,
    //   width: 30,
    // );
    List<Widget> _widgets = List<Widget>();
    List<String> chipsList = List<String>();

    switch(inputType) {
      case 'integer':
      case 'decimal':
      case 'text':
        {
          _widgets.add(TextFormField(
            initialValue: content,
            decoration: InputDecoration(
              prefixIcon: DialogUtils().prefixIconByFunction(yesFunc),
//                        border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
//                        contentPadding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
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
              // _value = value;
            },
            onChanged: (text) {
              // _value = text;
            },
            style: TextStyle(
              fontFamily: 'K2D-Regular',
              color: Colors.grey[800],
            ),
          ));
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
    for(int i=0;i < chipsList.length;i++) {
      chipsIsSelectedList.add(false);
      String chipName = chipsList[i];
      _widgets.add(buildFilterChip(chipName: chipName, index: i));
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: _widgets,
      ),
    );
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
            }
        );
  }
}
