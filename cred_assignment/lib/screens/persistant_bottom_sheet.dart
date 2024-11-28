import 'package:cred_assignment/screens/bottom_sheet1.dart';
import 'package:cred_assignment/screens/bottom_sheet2.dart';
import 'package:cred_assignment/screens/bottom_sheet3.dart';
import 'package:flutter/material.dart';


class PersistentBottomSheetScreen extends StatefulWidget {
 @override
 State<PersistentBottomSheetScreen> createState() =>
     _PersistentBottomSheetScreenState();
}


class _PersistentBottomSheetScreenState
   extends State<PersistentBottomSheetScreen> {
 List<double> heights = [0.9, 0.85, 0.80];
 List<int> openedSheets = [];


 void _addBottomSheet() {
   setState(() {
     int nextIndex = openedSheets.length;
     if (nextIndex < heights.length) {
       openedSheets.add(nextIndex);
     }
   });
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
       return CreditSliderScreen() ;
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
   return Positioned(
     bottom: 0,
     top: MediaQuery.of(context).size.height * (1 - heightFactor),
     left: 0,
     right: 0,
     child: Container(
       decoration: BoxDecoration(
         color: Colors.black,
         //Colors.black87,
         borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
               child: Center(
                 child: Text(
                   'Open Next Sheet',
                   style: const TextStyle(fontSize: 18, color: Colors.white70),
                 ),
               ),
               decoration: BoxDecoration(
                 color: Colors.green,
                 borderRadius: BorderRadius.only(topLeft: Radius.circular(40) ,topRight: Radius.circular(40) )
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



