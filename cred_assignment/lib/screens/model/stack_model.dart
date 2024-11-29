import 'package:flutter/material.dart';

class StackViewModel {
  final List<double> heights = [0.9, 0.8, 0.7];
  final List<int> openedSheets = [];
  int animatingIndex = -1;

  double getOpacity(int index) {
    if (index < openedSheets.length - 1) {
      return 0.5; // Fade effect for previous sheets
    } else if (index < openedSheets.length - 2) {
      return 0.3; // More fade for older sheets
    }
    return 1.0; // Fully visible for topmost sheet
  }

  void addBottomSheet(VoidCallback onUpdate) async {
    int nextIndex = openedSheets.length;
    if (nextIndex < heights.length) {
      animatingIndex = nextIndex;
      onUpdate();

      // Delay for animation
      await Future.delayed(const Duration(seconds: 1));

      openedSheets.add(nextIndex);
      animatingIndex = -1; // Reset animation index
      onUpdate();
    }
  }

  void removeTopSheet(VoidCallback onUpdate) {
    if (openedSheets.isNotEmpty) {
      openedSheets.removeLast();
      onUpdate();
    }
  }
}
