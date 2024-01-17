import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:flutter/material.dart';

class CourseWidget extends StatelessWidget {
  String courseTitle;
  String courseDescription;
  String coursePrice;
  String image_path;
  CourseWidget({super.key , required this.courseTitle, required this.courseDescription, required this.coursePrice, required this.image_path});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage("$Url$image_path"),
                fit: BoxFit.fill,
              ),
            ),
            
          ),
          Container(
            decoration:const  BoxDecoration(
              color: secondMobileBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )
            ),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$courseTitle".length > 15 ? "${courseTitle.substring(0, 15)}..." : "$courseTitle",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$courseDescription".length > 20 ? "${courseDescription.substring(0, 20)}..." : "$courseDescription",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

              ],
            )
          ),
        ],
    );
  }
}
