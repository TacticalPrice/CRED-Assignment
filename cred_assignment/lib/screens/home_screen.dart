import 'package:cred_assignment/screens/model/stack_model.dart';
import 'package:cred_assignment/screens/stack_contents.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() =>
      _PersistentBottomSheetScreenState();
}

class _PersistentBottomSheetScreenState
    extends State<HomeScreen> {
  final StackViewModel _viewModel =
      StackViewModel();

  Widget _buildBottomSheet(BuildContext context, int index) {
    double heightFactor = _viewModel.heights[index];
    double opacity = _viewModel.getOpacity(index);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: 0,
      top: MediaQuery.of(context).size.height *
          (_viewModel.animatingIndex == index ? 1 : 1 - heightFactor),
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: index == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  )
                : BorderRadius.zero,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: StackContent(index: index)),
              GestureDetector(
                onTap: () => _viewModel.addBottomSheet(() {
                  setState(() {});
                }),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Open Next Sheet',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_viewModel.openedSheets.isNotEmpty) {
          _viewModel.removeTopSheet(() {
            setState(() {});
          });
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
                onPressed: () => _viewModel.addBottomSheet(() {
                  setState(() {});
                }),
                child: const Text("Show Bottom Sheets"),
              ),
            ),
            for (int index in _viewModel.openedSheets)
              _buildBottomSheet(context, index),
          ],
        ),
      ),
    );
  }
}
