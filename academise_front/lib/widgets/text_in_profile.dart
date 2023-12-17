import 'package:academise_front/utils/color.dart';
import 'package:flutter/material.dart';

class TextInProfile extends StatelessWidget {
  String smallText;
  String mainText;
  TextInProfile({super.key, required this.smallText, required this.mainText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              smallText,
              style: TextStyle(color: secondaryColor, fontSize: 13),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: secondMobileBackgroundColor),
            ),
            width: double.infinity,
            child: Text(
              mainText,
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
