import 'package:cred_assignment/stack_item.dart';
import 'package:flutter/material.dart';

class StackedView extends StatefulWidget {
  const StackedView({Key? key}) : super(key: key);

  @override
  _StackedViewState createState() => _StackedViewState();
}

class _StackedViewState extends State<StackedView> {
  int expandedIndex = -1; // No card is expanded by default
  final List<String> stackData = [
    "Plan 1: ₹4,247/mo for 12 months",
    "Plan 2: ₹5,580/mo for 9 months",
    "Plan 3: ₹8,200/mo for 6 months",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: List.generate(stackData.length, (index) {
          return Positioned(
            bottom: index * 80.0, // Offset each card slightly
            left: 0,
            right: 0,
            child: StackCard(
              title: stackData[index],
              isExpanded: expandedIndex == index,
              onTap: () {
                setState(() {
                  expandedIndex = expandedIndex == index ? -1 : index;
                });
              },
            ),
          );
        }),
      ),
    );
  }
}
