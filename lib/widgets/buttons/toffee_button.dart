import 'package:flutter/material.dart';
import 'package:pmreport/utils/sizes_helpers.dart';

class ToffeeButton extends StatelessWidget {
  final String buttonImage;
  final String buttonCaption;

  const ToffeeButton(this.buttonImage, this.buttonCaption);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          buildBackgroundImage(
            buttonImage,
            displayWidth(context),
            displayHeight(context) * 0.13,
            displaySize(context),
            Colors.lightBlueAccent,
          ),
          buildContentImage(buttonImage,
              displayHeight(context) * 0.10),
          buildTapText(buttonCaption),
        ],
      ),
    );
  }

  Widget buildTapText(String name) {
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
