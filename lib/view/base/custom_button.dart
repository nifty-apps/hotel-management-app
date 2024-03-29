import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;
  final bool transparent;
  final double height;
  final double width;
  final double radius;
  CustomButton({
    required this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.width = 200,
    this.height = 42,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      minimumSize: Size(width, height),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(
      child: SizedBox(
        width: width,
        child: TextButton(
          onPressed: onPressed,
          style: _flatButtonStyle,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
