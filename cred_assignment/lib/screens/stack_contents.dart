import 'package:flutter/material.dart';
import 'package:cred_assignment/screens/credit_slider_screen.dart';
import 'package:cred_assignment/screens/card_selection_screen.dart';
import 'package:cred_assignment/screens/account_screen.dart';

class StackContent extends StatelessWidget {
  final int index;

  const StackContent({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return CreditSliderScreen();
      case 1:
        return CardSelectionScreen();
      case 2:
        return AccountScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}
