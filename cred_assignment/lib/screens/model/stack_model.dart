import 'package:flutter/material.dart';

class StackViewModel {
  final List<double> heights = [0.9, 0.8, 0.75];
  final List<int> openedSheets = [];
  int animatingIndex = -1;

  double getOpacity(int index) {
    if (index < openedSheets.length - 1) {
      return 0.5; 
    } else if (index < openedSheets.length - 2) {
      return 0.3; 
    }
    return 1.0; 
  }

  void addBottomSheet(VoidCallback onUpdate) async {
    int nextIndex = openedSheets.length;
    if (nextIndex < heights.length) {
      animatingIndex = nextIndex;
      onUpdate();

     
      await Future.delayed(const Duration(seconds: 1));

      openedSheets.add(nextIndex);
      animatingIndex = -1;
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
