import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_constants.dart';
import '../../utils/home_constants.dart';

class SizeSelectorBottomSheet extends StatefulWidget {
  final void Function(int height, int weight) onDone;

  const SizeSelectorBottomSheet({super.key, required this.onDone});

  @override
  createState() => _SizeSelectorBottomSheetState();
}

class _SizeSelectorBottomSheetState extends State<SizeSelectorBottomSheet> {
  int? _height;
  int? _weight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // scroll view for forms to go up with keyboard
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // input for height
            TextField(
              onChanged: (value) => _height = int.tryParse(value),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(labelText: labelHeight),
            ),
            v16px,
            // input for weight
            TextField(
              onChanged: (value) => _weight = int.tryParse(value),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(labelText: labelWeight),
            ),
            v16px,
            // button to complete and send back sizes
            ElevatedButton(
              onPressed: () {
                if (_height != null && _weight != null) {
                  widget.onDone(_height!, _weight!);
                }
                Navigator.of(context).pop();
              },
              child: const Text(completedButtonLabel),
            )
          ],
        ),
      ),
    );
  }
}
