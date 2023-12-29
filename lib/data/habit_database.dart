// reference the box
import 'package:chain_habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';


final _myBox = Hive.box("Habit_Database");

class HabitStorage {
  List currentHabitList = [];


  // Create the default data
  void createDefaultData() {
    currentHabitList = [
      ["Run", false, 8, 0, 0],
      ["Walk", false, 7, 0, 0]
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // Load existing data
  void loadData() {
    // Check if it is a new day (any day after start, meaning boxes must be ticked agian)
    if (_myBox.get(todaysDateFormatted()) == null) {
      currentHabitList = _myBox.get("CURRENT_HABIT_LIST");

      // set everything back to false
      for (int i = 0; i < currentHabitList.length; i++) {
        currentHabitList[i][1] = false;
      }
    }

    // If its the same day (boxes don't have to all be set ot false)
    else {
      currentHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  // Update existing data
  void updateData() {
    // Update todays entry
    _myBox.put(todaysDateFormatted(), currentHabitList);

    // Update backend habit list (in case a habit is deleted, edited, or added)
    _myBox.put("CURRENT_HABIT_LIST", currentHabitList);
  }

}
