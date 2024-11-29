import 'package:cred_assignment/blocs/api_data_bloc/api_data_bloc.dart';
import 'package:cred_assignment/screens/persistant_bottom_sheet.dart';
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
    return BlocProvider(
      create: (context) => TestMintCubit(getIt<TestMintRepository>())
        ..fetchTestMintData(), // Ensures the API data is fetched on startup
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PersistentBottomSheetScreen(),
      ),
    );
  }
}
