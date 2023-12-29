import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habit_name;
  final bool daily_completion;
  final int goal_streak;
  final int cur_streak;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsPressed;
  final Function(BuildContext)? deletePressed;

  const HabitTile({
    super.key,
    required this.habit_name,
    required this.daily_completion,
    required this.onChanged,
    required this.goal_streak,
    required this.cur_streak,
    required this.settingsPressed,
    required this.deletePressed
  });

  @override
  Widget build(BuildContext context) {
    final int week_streak;
    if(cur_streak < 7){
      week_streak = 0;
    }
    else{
      week_streak = cur_streak ~/ 7;
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // Settings option
            SlidableAction(
              onPressed: settingsPressed,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
              
            ),

            // Delete option
            SlidableAction(
              onPressed: deletePressed,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),

            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Checkbox(value: daily_completion, onChanged: onChanged),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(habit_name),
                    SizedBox(width: 20), // Add some spacing between habit name and streaks
                  ],
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Goal: " + goal_streak.toString()),
                    SizedBox(height: 8),
                    Text("Streak: " + cur_streak.toString()),
                    SizedBox(height: 8),
                    Text("Weeks Completed: " + week_streak.toString())

                  ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}

