

import 'package:chain_habit_tracker/data/habit_database.dart';
import 'package:chain_habit_tracker/pages/info_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../components/habit_tile.dart';
import '../components/new_habit_text_window.dart';
import '../components/add_habit_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chain_habit_tracker/components/info_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  // Current habits list
  HabitStorage db = HabitStorage();
  final _myBox = Hive.box("Habit_Database");

   void initState(){

     // If there is an empty habit list (first time opening app) Create an empty list
     if (_myBox.get("CURRENT_HABIT_LIST") == null){
       db.createDefaultData();
     }

     // Else if the data already exists (Not first itme using app) Return filled list
     else{
       db.loadData();
     }
     super.initState();
   }


  void checkBoxTapped(bool? value, int index){
    setState(() {
      db.currentHabitList[index][1] = value!;   // Make the checkbox function
      if(db.currentHabitList[index][1] == true){
        db.currentHabitList[index][3]++; // Increment current streak
      }
      else{
        db.currentHabitList[index][3]--; // Decrement current streak
      }


    });

    db.updateData();
  }


  final _newHabitTextWindowController = TextEditingController(); // Controller is used to save and manipulate whats within the text window
  final _goalTextWindowController = TextEditingController();
  void createNewHabit(){
    showDialog(
        context: context,
        builder: (context){
          return NewHabitTextWindow(

            habitController: _newHabitTextWindowController,
            goalController: _goalTextWindowController,
            onCancel: cancelNewHabit,   // Pass in functions into NewHabitTextWindow constructor
            onSave: saveNewHabit,

          );
    },
    );

    db.updateData();
  }
  // Save a new habit
  void saveNewHabit(){
    final String goalText = _goalTextWindowController.text; // convert Goal streak to text
    final int goalStreak = int.tryParse(goalText) ?? 0;
    setState(() {
      db.currentHabitList.add([_newHabitTextWindowController.text, false, goalStreak, 0]); // Add to habit list
    });
    _goalTextWindowController.clear();    // Clear the text boxes
    _newHabitTextWindowController.clear();
    Navigator.of(context).pop();

    db.updateData();
  }
  // Cancel a new habit
  void cancelNewHabit(){
    _newHabitTextWindowController.clear();
    _goalTextWindowController.clear();
    Navigator.of(context).pop();

    db.updateData();
  }

// Delete an existing habit
  void deleteHabit(int index){
    setState(() {
      db.currentHabitList.removeAt(index);
    });

    db.updateData();
  }
// Edit an existing habit
  void openHabitSettings(int index){
    showDialog(context: context, builder: (context){
      return NewHabitTextWindow(
          habitController: _newHabitTextWindowController,
          goalController: _goalTextWindowController,
          onCancel: cancelNewHabit,
          onSave: () => saveExistingHabit(index),
      );
    });

    db.updateData();
  }

  // Save the new inputted name when settings box is opened
  void saveExistingHabit(int index){
    setState(() {
      db.currentHabitList[index][0] = _newHabitTextWindowController.text;

      final String goalText = _goalTextWindowController.text; // convert Goal streak to text
      final int goalStreak = int.tryParse(goalText) ?? 0;

      if (goalStreak > db.currentHabitList[index][3]){    // check to make sure that current streak is less than new goal
        db.currentHabitList[index][2] = goalStreak;
      }

      _newHabitTextWindowController.clear();
      _goalTextWindowController.clear();
    });
    Navigator.pop(context);

    db.updateData();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: db.currentHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habit_name: db.currentHabitList[index][0],
                  daily_completion: db.currentHabitList[index][1],
                  goal_streak: db.currentHabitList[index][2],
                  cur_streak: db.currentHabitList[index][3],
                  onChanged: (value) => checkBoxTapped(value, index),
                  deletePressed: (context) => deleteHabit(index),
                  settingsPressed: (context) => openHabitSettings(index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 1.0),
            child: InfoButton(onPressed:() {
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return InfoPage();
                }
              );
            }
            ), // Your InfoButton
          ),
          AddHabitButton(onPressed: createNewHabit),
        ],
      ),
    );
  }
}

