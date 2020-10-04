import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/blocs.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';
import 'package:pmreport/utils/sizes_helpers.dart';

class HomeMenu extends StatelessWidget {
  HomeMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Bounce(
            duration: Duration(milliseconds: 100),
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  buildBackgroundImage(
                      "assets/report_menu_normal.png",
                      displayWidth(context),
                      displayHeight(context) * 0.13,
                      displaySize(context),
                      Colors.lightBlueAccent,
                  ),
                  buildContentImage("assets/report_menu_normal.png",
                      displayHeight(context) * 0.10),
                  buildTapText('Report'),
                ],
              ),
            ),
            onPressed: () {
              print('Report pressed...');
            },
          ),

          Bounce(
            duration: Duration(milliseconds: 100),
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  buildBackgroundImage(
                      "assets/measurement_menu_normal.png",
                      displayWidth(context),
                      displayHeight(context) * 0.13,
                      displaySize(context),
                      Colors.deepOrangeAccent,
                  ),
                  buildContentImage("assets/measurement_menu_normal.png",
                      displayHeight(context) * 0.10),
                  buildTapText('Measure'),
                ],
              ),
            ),
            onPressed: () {
              print('Measurement pressed...');
            },
          ),
        ],
      ),
    );
  }

  Widget buildTapText(String name) {
    Color mBrown = Color(0xff81554E);
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          Text(name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  Widget buildBackgroundImage(
      String backgroundImage, double cardWidth, double cardHeight, Size size, Color blendColor) {
    return Container(
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: blendColor,

        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            backgroundImage,
            fit: BoxFit.contain,
            color: blendColor,
            colorBlendMode: BlendMode.darken,
          ),
        ),
      );
  }

  Widget buildContentImage(String contentImage, double contentHeight) {
    return Container(
        margin: EdgeInsets.all(4),
        child: Image.asset(
            contentImage,
            color: Colors.black87,
            colorBlendMode: BlendMode.overlay,
            height: contentHeight)
    );
  }
}
