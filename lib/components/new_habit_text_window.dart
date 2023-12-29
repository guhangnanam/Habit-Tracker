import 'package:flutter/material.dart';

class NewHabitTextWindow extends StatelessWidget {
  final habitController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final goalController;

  const NewHabitTextWindow({
    super.key,
    required this.habitController,
    required this.goalController,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: habitController,
            decoration: InputDecoration(
                labelText: "Habit Name",
                hintText: "Enter Habit Name",
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green))
            ),
          ),
          SizedBox(height: 6),
          TextField(
            controller: goalController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Goal",
              hintText: "Enter Goal Streak",
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
            ),
          )
        ],
      ),
      actions: [
        MaterialButton(
            onPressed: onSave,
            child: Text("Save", style: const TextStyle(color: Colors.white),),
            color: Colors.grey.shade700),
        MaterialButton(
          onPressed: onCancel,
          child: Text("Cancel", style: const TextStyle(color: Colors.white),),
          color: Colors.grey.shade700,)
      ],
    );
  }
}


