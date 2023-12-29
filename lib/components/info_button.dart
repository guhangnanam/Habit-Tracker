import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  final Function()? onPressed;
  const InfoButton({
    super.key,
    required this.onPressed
  });



  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(
          Icons.question_mark,
        ),
        onPressed: onPressed

    );
  }
}