import 'package:flutter/material.dart';

import '../common_widgets/sign_out_button.dart';
import '../common_widgets/size_calculator_widget.dart';
import '../../utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            v128px,
            SignOutButton(),
            Spacer(),
            Expanded(child: SizeCalculatorWidget()),
            v128px,
          ],
        ),
      ),
    );
  }
}
