import 'package:cred_assignment/blocs/api_data_bloc/api_data_bloc.dart';
import 'package:cred_assignment/blocs/home_screen_cubit/home_cubit.dart';
import 'package:cred_assignment/screens/home_screen.dart';
import 'package:cred_assignment/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/repo.dart';

void main() {
  setupServiceLocator();
  runApp(PersistentBottomSheets());
}

class PersistentBottomSheets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TestMintCubit(getIt<TestMintRepository>())
            ..fetchTestMintData(),
        ),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
