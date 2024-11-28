import 'package:flutter/material.dart';

class StackCard extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;

  const StackCard({
    Key? key,
    required this.title,
    required this.isExpanded,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isExpanded ? Colors.deepPurple : Colors.grey[800],
          borderRadius: BorderRadius.circular(16),
        ),
        height: isExpanded ? 200 : 100, // Expanded or collapsed height
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isExpanded)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Additional Details...',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
