import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.onPressed,
    required this.myText,
    required this.myColor,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback onPressed;
  final String myText;
  final Color myColor;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: myColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: isLoading
              ? CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2,
                )
              : Text(
                  myText,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
