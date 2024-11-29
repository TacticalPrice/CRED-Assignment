import 'package:flutter/material.dart';
import 'package:cred_assignment/screens/bottom_sheet1.dart';
import 'package:cred_assignment/screens/bottom_sheet2.dart';
import 'package:cred_assignment/screens/bottom_sheet3.dart';

class PersistentBottomSheetScreen extends StatefulWidget {
  @override
  State<PersistentBottomSheetScreen> createState() =>
      _PersistentBottomSheetScreenState();
}

class _PersistentBottomSheetScreenState
    extends State<PersistentBottomSheetScreen> {
  List<double> heights = [0.9, 0.80, 0.70];
  List<int> openedSheets = [];
  int animatingIndex = -1;

  void _addBottomSheet() async {
    int nextIndex = openedSheets.length;
    if (nextIndex < heights.length) {
      // Show animation for the next sheet
      setState(() {
        animatingIndex = nextIndex;
      });

      // Delay for 1 second
      await Future.delayed(Duration(seconds: 1));

      // Add the next sheet
      setState(() {
        openedSheets.add(nextIndex);
        animatingIndex = -1; // Reset animation index
      });
    }
  }

  void _removeTopSheet() {
    setState(() {
      if (openedSheets.isNotEmpty) {
        openedSheets.removeLast();
      }
    });
  }

  Widget _getBottomSheetContent(int index) {
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

  Widget _buildBottomSheet(int index) {
    double heightFactor = heights[index];
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: 0,
      top: MediaQuery.of(context).size.height *
          (animatingIndex == index ? 1 : 1 - heightFactor),
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: _getBottomSheetContent(index)),
            GestureDetector(
              onTap: () {
                _addBottomSheet();
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Open Next Sheet',
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (openedSheets.isNotEmpty) {
          _removeTopSheet();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Persistent Bottom Sheets")),
        body: Stack(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => _addBottomSheet(),
                child: const Text("Show Bottom Sheets"),
              ),
            ),
            for (int index in openedSheets) _buildBottomSheet(index),
          ],
        ),
      ),
    );
  }
}

