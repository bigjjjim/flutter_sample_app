import 'package:flutter/material.dart';

import '../../services/shirt_sizes.dart';
import '../../utils/home_constants.dart';
import 'size_selector_bottom_sheet.dart';

// this widget has one button to display bottom sheet and select height and weight,
// one button to compute the size and the text result
class SizeCalculatorWidget extends StatefulWidget {
  const SizeCalculatorWidget({super.key});

  @override
  createState() => _SizeCalculatorWidgetState();
}

class _SizeCalculatorWidgetState extends State<SizeCalculatorWidget> {
  int? height;
  int? weight;
  String? shirtSize;

  // call the bottom sheet and update the variables in this context
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizeSelectorBottomSheet(
        onDone: (selectedHeight, selectedWeight) {
          setState(() {
            height = selectedHeight;
            weight = selectedWeight;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // display the message if the size is computed
        if (shirtSize != null)
          Text(
            "$messageSize $shirtSize!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        const Spacer(),
        // button to input height and weight
        ElevatedButton(
          onPressed: _showBottomSheet,
          child: const Text(buttonSelectSize),
        ),
        // display button to compute size if height and weight are selected
        if (height != null && weight != null)
          ElevatedButton(
            onPressed: () {
              setState(() {
                shirtSize = determineShirtSize(
                  height: height!,
                  weight: weight!,
                ).name;
              });
            },
            child: const Text(buttonGetSize),
          ),
      ],
    );
  }
}
