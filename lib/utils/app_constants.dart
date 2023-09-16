import 'package:flutter/material.dart';

const SizedBox v16px = SizedBox(height: 16);

const SizedBox v128px = SizedBox(height: 128);

const CircularProgressIndicator loadingWidget = CircularProgressIndicator(
  color: Colors.green,
);

// Function to get the vertical size of the screen
double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// Function to get the horizontal size of the screen
double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
