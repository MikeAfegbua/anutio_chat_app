import 'package:flutter/material.dart';

void pushScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context) => screen,
    ),
  );
}
