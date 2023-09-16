import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;

  const CustomLoginButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          //adjust the size minimum of the button
          minimumSize: const Size(200, 50),
          //reduce shadow
          elevation: 1),
      icon: Image.asset(
        imagePath,
        height: 16,
      ),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}
