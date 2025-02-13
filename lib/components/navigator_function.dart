import 'package:flutter/material.dart';

// PUSH BETWEEN SCREENS
void pushScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context) => screen,
    ),
  );
}
