import 'package:cred_assignment/blocs/amount_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AccountScreen extends StatelessWidget {
 const AccountScreen({Key? key}) : super(key: key);


 @override
 Widget build(BuildContext context) {
   return BlocProvider(
     create: (context) => AccountCubit(),
     child: Scaffold(
       backgroundColor: const Color(0xFF1C1C1E), // Dark background
       body: SafeArea(
         child: Padding(
           padding: const EdgeInsets.all(16.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 "where should we send the money?",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               const SizedBox(height: 8),
               Text(
                 "amount will be credited to this bank account, EMI will also be debited from this bank account",
                 style: TextStyle(
                   color: Colors.white60,
                   fontSize: 14,
                 ),
               ),
               const SizedBox(height: 32),
               BlocBuilder<AccountCubit, AccountState>(
                 builder: (context, state) {
                   return Container(
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(
                       color: const Color(0xFF2C2C2E),
                       borderRadius: BorderRadius.circular(12),
                     ),
                     child: Row(
                       children: [
                         CircleAvatar(
                           backgroundColor: Colors.white,
                           child: Icon(Icons.account_balance_wallet_outlined,
                               color: Colors.blueAccent),
                         ),
                         const SizedBox(width: 16),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               state.bankName,
                               style: const TextStyle(
                                 color: Colors.white,
                                 fontSize: 16,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             const SizedBox(height: 4),
                             Text(
                               state.accountNumber,
                               style: const TextStyle(
                                 color: Colors.white70,
                                 fontSize: 14,
                               ),
                             ),
                           ],
                         ),
                         const Spacer(),
                         Radio(
                           value: true,
                           groupValue: true,
                           onChanged: (_) {},
                           activeColor: Colors.blueAccent,
                         ),
                       ],
                     ),
                   );
                 },
               ),
               const SizedBox(height: 16),
               Center(
                 child: ElevatedButton(
                   onPressed: () {
                     // Handle account change
                     context
                         .read<AccountCubit>()
                         .changeAccount("New Bank", "1234567890");
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: const Color(0xFF3A3A3C),
                     padding: const EdgeInsets.symmetric(
                         vertical: 12, horizontal: 24),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),
                     ),
                   ),
                   child: const Text(
                     "Change account",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                     ),
                   ),
                 ),
               ),
             ],
           ),
         ),
       ),
     ),
   );
 }
}

