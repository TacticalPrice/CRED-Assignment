import 'package:cred_assignment/blocs/home_screen_cubit/home_cubit.dart';
import 'package:cred_assignment/blocs/home_screen_cubit/home_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cred_assignment/screens/model/stack_model.dart';
import 'package:cred_assignment/screens/stack_contents.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final StackViewModel _viewModel = StackViewModel();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildWelcomeSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Cred Assignment!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Your personalized experience awaits.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context, int index) {
  double heightFactor = _viewModel.heights[index];
  double opacity = _viewModel.getOpacity(index);

  List<String> buttonTexts = [
    'Proceed to EMI Selection',
    'Select your bank account',
    'Tap for 1-click KYC',
  ];

  List<Color> sheetColors = [
    Color(0xFF18181B), 
    Color(0Xff27272a), 
    Color(0xFF18181B), 
  ];

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
          color: sheetColors[index], // Apply color based on the index
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: StackContent(index: index)),
            GestureDetector(
              onTap: () => context.read<HomeCubit>().addBottomSheet(),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Text(
                    buttonTexts[index], 
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
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
      if (context.read<HomeCubit>().state.openedSheets.isNotEmpty) {
        context.read<HomeCubit>().removeTopSheet();
        return false;
      }
      return true;
    },
    child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Home" , style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Center(child: _buildWelcomeSection()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => context.read<HomeCubit>().addBottomSheet(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  "Start Exploring",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Stack(
                children: [
                  for (int index in state.openedSheets)
                    _buildBottomSheet(context, index),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}
}

//   Widget _buildBottomSheet(BuildContext context, int index) {
//     double heightFactor = _viewModel.heights[index];
//     double opacity = _viewModel.getOpacity(index);

//     // Define the list of button texts for each index
//     List<String> buttonTexts = [
//       'Proceed to EMI Selection',
//       'Select your bank account',
//       'Tap for 1-click KYC',
//     ];

//     return AnimatedPositioned(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       bottom: 0,
//       top: MediaQuery.of(context).size.height *
//           (_viewModel.animatingIndex == index ? 1 : 1 - heightFactor),
//       left: 0,
//       right: 0,
//       child: AnimatedOpacity(
//         duration: const Duration(milliseconds: 300),
//         opacity: opacity,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius:
//                 const BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   )
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(child: StackContent(index: index)),
//               GestureDetector(
//                 onTap: () => context.read<HomeCubit>().addBottomSheet(),
//                 child: Container(
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.blue[900],
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       buttonTexts[index], // Get the text from the list based on the index
//                       style: const TextStyle(fontSize: 18, color: Colors.white70),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (context.read<HomeCubit>().state.openedSheets.isNotEmpty) {
//           context.read<HomeCubit>().removeTopSheet();
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Home"),
//           centerTitle: true,
//         ),
//         body: Stack(
//           children: [
//             Center(child: _buildWelcomeSection()),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: () => context.read<HomeCubit>().addBottomSheet(),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   ),
//                   child: const Text(
//                     "Start Exploring",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             BlocBuilder<HomeCubit, HomeState>(
//               builder: (context, state) {
//                 return Stack(
//                   children: [
//                     for (int index in state.openedSheets)
//                       _buildBottomSheet(context, index),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
