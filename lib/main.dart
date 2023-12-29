import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/home_page.dart';

// App will be Called "Chain: Habit Tracker"
// Display will show Habits and then a chain below them for as the tracker.
// Green will mean that they were successful that day and red will show that they weren't
// Each day Users will be asked to state whether they broke their habit or not
// Not breaking will extend the chain and breaking it will break the chain


// Users will create chains that are 7 links long for every week
// If the goal is longer than 7 days the completed chain will be added to
// the already existing chain for the same habit to extend it by 7 days
// completed chains will be able to be viewed on a separate tab

// roughly 12 weeks to form a habit completely
// so habit will track habits on a weekly basis
// Idea is that it is easier to track habits by weeks then by days and helps people stay on track

// Create a class to store the habits that will have:
// 1. Name of Habit
// 2. Description of Habit
// 3. Start date of Habit
// 4. Goal for end Habit


// Possible API implementations
// Google Maps
// Firebase Cloud Messaging
// Google Calendar
// Google Analytics
// Share API or Flutter Social Share Plugin


void main() async{
  // Initialize a hive
  await Hive.initFlutter();

  // Open a box
  await Hive.openBox("Habit_Database");
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green

      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
  }