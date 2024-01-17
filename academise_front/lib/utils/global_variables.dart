import 'package:academise_front/screens/dashboard_screen.dart';
import 'package:academise_front/screens/chat_screen.dart';
import 'package:academise_front/screens/profile_screen.dart';
import 'package:academise_front/screens/student_screens/student_chat_screen.dart';
import 'package:academise_front/screens/student_screens/student_course_screen.dart';
import 'package:academise_front/screens/student_screens/student_dashboard_screen.dart';
import 'package:academise_front/screens/student_screens/student_explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:academise_front/screens/home_screen.dart';

const webScreenSize = 600;

var homeScreenItems = [
  DashboardScreen(),
  ChatScreen(),
  ProfileScreen(),
];

var StudenthomeScreenItems = [
  StudentDashboardScreen(),
  StudentExploreScreen(),
  ChatScreen(),
  ProfileScreen(),
];