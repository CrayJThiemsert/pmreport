import 'dart:io';
import 'dart:ui' as ui show Gradient, TextBox, lerpDouble, Image;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
//     ??
//    false
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

  Future<bool> showEditTextDialog(BuildContext context,
      String title,
      String content,
      String yesText,
      String noText,
      String yesFunc,
      String key,
      User byUser
      ) {
    String _value = content;
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
                    TextFormField(

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
                      keyboardType: keyboardTypeByFunction(yesFunc),
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
                          // onPressed: () => doFunctionWithValue(context, yesFunc, key, _value, byUser),
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
        result = TextInputType.multiline;
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