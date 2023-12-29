import 'package:flutter/material.dart';
import 'package:chain_habit_tracker/components/info_button.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Methodology"),
      content: Text(
        "On average habits are formed in a period of 66 days. However, "
            "I believe that this is wildly impractical number to track. "
            "Instead this habit tracker employs a delayed reward system "
            "that where users are compensated weekly rather than daily. "
            "This way instead of tracking a habit for 66 days you are "
            "tracking it for 7-8 weeks. Furthermore, psychologically if "
            "it takes a user a week to accumulate any progress on their "
            "habit, that habit will be worth more than if it was rewarded "
            "daily meaning a user will put in more effort to maintain their "
            "streak.",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close"),
        ),
      ],
    );
  }
}

