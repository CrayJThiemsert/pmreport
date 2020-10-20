import 'dart:io';
import 'dart:ui' as ui show Gradient, TextBox, lerpDouble, Image;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmreport/utils/input_type_form.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class DialogUtils {

  BuildContext _context;

  Future<bool> showMessageDialog(BuildContext context,
      String title,
      String content,
      String yesText
      ) {
    _context = context;
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.limeAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                backgroundColor: Colors.grey[800],
                title: Text(title,
                  style: TextStyle(
                    fontFamily: 'K2D-ExtraBold',
                    color: Colors.white,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(content,
                      style: TextStyle(
                        fontFamily: 'K2D-Regular',
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 1
                              )
                          ),
                          onPressed: () => doFunction(context, 'close_dialog'),
                          child: Text(yesText,
                            style: TextStyle(
                              fontFamily: 'K2D-Medium',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {})
        ;
  }

  Future<bool> showConfirmationDialog(BuildContext context,
      String title,
      String content,
      String yesText,
      String noText,
      String yesFunc,
      String noFunc
      ) {
    _context = context;
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: doBorderColorByFunction(yesFunc),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                backgroundColor: Colors.grey[800],
                title: Text(title,
                  style: TextStyle(
                    fontFamily: 'K2D-ExtraBold',
                    color: Colors.white,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(content,
                      style: TextStyle(
                        fontFamily: 'K2D-Regular',
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 1
                              )
                          ),
                          onPressed: () => doFunction(context, noFunc),
                          child: Text(noText,
                            style: TextStyle(
                              fontFamily: 'K2D-Medium',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        FlatButton(
                          color: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 1
                              )
                          ),
                          onPressed: () => doFunction(context, yesFunc),
                          child: Text(yesText,
                            style: TextStyle(
                              fontFamily: 'K2D-Medium',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {})
//     ??
//    false
    ;
  }

  Future<bool> showInputDialog({BuildContext context,
    String title,
    String content,
    String yesText,
    String noText,
    String yesFunc,
    String key,
    String inputType,
    Item item,
    User byUser
  }) {
    print('Drawing input dialog...');
    String _value = content;
    String _key = key;
    _context = context;
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.limeAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                backgroundColor: Colors.grey[800],
                title: Text(title,
                  style: TextStyle(
                    fontFamily: 'K2D-ExtraBold',
                    color: Colors.white,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // buildInputTypeField(content, yesFunc, inputType, _value),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InputTypeForm(uid: _key, yesFunc: yesFunc, yesText: yesText, noText: noText, inputType: inputType, value: _value, item: item,),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {})
//     ??
//    false
        ;
  }

  Widget buildInputTypeField(String content, String yesFunc, String inputType, String _value) {
    Widget _widget = Container(
      height: 20,
      width: 30,
    );
    switch(inputType) {
      case 'integer':
      case 'decimal':
      case 'text':
      {
        _widget = TextFormField(
          initialValue: content,
          decoration: InputDecoration(
            prefixIcon: prefixIconByFunction(yesFunc),
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
          maxLength: maxLengthByFunction(yesFunc),
          maxLines: maxLinesByFunction(yesFunc),
          autofocus: false,
          keyboardType: keyboardTypeByFunction(inputType),
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
        );
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
      case 'single_options_testing':
      case 'multiple_options_condition':
      case 'multiple_options_lightning_arrester':
      case 'multiple_options_drop_fuse_cut_out':
      case 'multiple_options_connection':
      case 'multiple_options_ground':
        {
          bool _selected = false;
          _widget = FilterChip(
              selected: _selected,
              label: Text('Woolha'),
              selectedColor: Colors.lightGreen,
              onSelected: (bool selected) {
                // setState(() {
                //   _selected = !_selected;
                // });
              }
          );
          break;
        }
    }
    return _widget;
  }

  Icon prefixIconByFunction(String funcType) {
    Icon result = null;
    switch(funcType) {
      case 'shared_gunpla_comment':
        result = Icon(Icons.comment);
        break;
      case 'save_user_display_name':
      case 'save_user_email':
        result = Icon(Icons.person);
        break;
    }
    return result;
  }

  int maxLinesByFunction(String funcType) {
    int result = 1;
    switch(funcType) {
      case 'shared_gunpla_comment':
        result = 4;
        break;
    }
    return result;
  }

  TextInputType keyboardTypeByFunction(String funcType) {
    TextInputType result = TextInputType.text;
    switch(funcType) {
      case 'shared_gunpla_comment':
      case 'multiline':
        result = TextInputType.multiline;
        break;
      case 'number':
      case 'integer':
      case 'decimal':
        result = TextInputType.number;
        break;
    }
    return result;
  }

  int maxLengthByFunction(String funcType) {
    int result = 12;
    switch(funcType) {
      case 'shared_gunpla_comment':
        result = null;// TextField.noMaxLength;
        break;
    }
    return result;
  }

  Color doBorderColorByFunction(String command) {
    Color result = Colors.limeAccent;
    switch(command) {
      case 'warning':
        result = Colors.redAccent[400];
        break;
    }
    return result;
  }

  doFunction(BuildContext context, String command) {
    switch(command) {
      case 'close_app':
        exitApp();
        break;
      case 'close_dialog':
        Navigator.of(context, rootNavigator: true).pop(false);
        break;
      case 'sign_out':
        signOut(context);
        break;
    }
  }

  exitApp() =>
      exit(0);

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/SignInScreen", ModalRoute.withName("/HomeScreen"));
    });
  }

}