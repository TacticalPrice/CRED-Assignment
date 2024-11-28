import 'package:cred_assignment/blocs/card_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CardSelectionScreen extends StatelessWidget {
 final List<Map<String, String>> repaymentPlans = [
   {'amount': '₹4,247', 'duration': '12 months'},
   {'amount': '₹5,580', 'duration': '9 months', 'tag': 'recommended'},
   {'amount': '₹8,220', 'duration': '6 months'},
 ];


 @override
 Widget build(BuildContext context) {
   return BlocProvider(
     create: (_) => CardSelectionCubit(),
     child: Scaffold(
       backgroundColor: Colors.black,
       appBar: AppBar(
         backgroundColor: Colors.black,
         elevation: 0,
         title: Text(
           "how do you wish to repay?",
           style: TextStyle(color: Colors.white),
         ),
       ),
       body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Text(
               "Choose one of our recommended plans or make your own",
               style: TextStyle(color: Colors.grey, fontSize: 16),
             ),
           ),
           BlocBuilder<CardSelectionCubit, int>(
             builder: (context, selectedIndex) {
               return SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(
                   children: List.generate(repaymentPlans.length, (index) {
                     final plan = repaymentPlans[index];
                     final isSelected = selectedIndex == index;


                     return GestureDetector(
                       onTap: () {
                         context.read<CardSelectionCubit>().selectCard(index);
                       },
                       child: AnimatedContainer(
                         duration: Duration(milliseconds: 300),
                         curve: Curves.easeInOut,
                         margin: EdgeInsets.symmetric(horizontal: 8.0),
                         padding: EdgeInsets.all(16.0),
                         height: isSelected ? 200 : 160, // Bigger on selection
                         width: isSelected ? 220 : 200,
                         decoration: BoxDecoration(
                           color: isSelected
                               ? Colors.brown[700]
                               : Colors.grey[850], // Hover color
                           borderRadius: BorderRadius.circular(12),
                           boxShadow: isSelected
                               ? [
                                   BoxShadow(
                                     color: Colors.brown.withOpacity(0.5),
                                     blurRadius: 10,
                                     spreadRadius: 2,
                                   )
                                 ]
                               : [],
                           border: isSelected
                               ? Border.all(color: Colors.white, width: 2)
                               : null,
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             if (plan.containsKey('tag'))
                               Container(
                                 padding: EdgeInsets.symmetric(
                                   horizontal: 8,
                                   vertical: 4,
                                 ),
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                                 child: Text(
                                   plan['tag']!,
                                   style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 12,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ),
                             SizedBox(height: 8),
                             Text(
                               plan['amount']!,
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 24,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             Text(
                               plan['duration']!,
                               style: TextStyle(
                                 color: Colors.grey,
                                 fontSize: 16,
                               ),
                             ),
                             SizedBox(height: 8),
                             Text(
                               "See calculations",
                               style: TextStyle(
                                 color: Colors.blue,
                                 fontSize: 14,
                                 decoration: TextDecoration.underline,
                               ),
                             ),
                           ],
                         ),
                       ),
                     );
                   }),
                 ),
               );
             },
           ),
           Spacer(),
           Center(
             child: TextButton(
               onPressed: () {
                 // Handle "Create your own plan" action
               },
               child: Text(
                 "Create your own plan",
                 style: TextStyle(color: Colors.white),
               ),
             ),
           ),
         ],
       ),
     ),
   );
 }
}
