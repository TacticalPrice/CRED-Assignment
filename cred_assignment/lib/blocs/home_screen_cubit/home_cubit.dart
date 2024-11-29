import 'package:cred_assignment/blocs/home_screen_cubit/home_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void addBottomSheet() {
    emit(state.copyWith(
      openedSheets: List.from(state.openedSheets)..add(state.openedSheets.length),
    ));
  }

  void removeTopSheet() {
    if (state.openedSheets.isNotEmpty) {
      emit(state.copyWith(
        openedSheets: List.from(state.openedSheets)..removeLast(),
      ));
    }
  }

  void setAnimatingIndex(int index) {
    emit(state.copyWith(animatingIndex: index));
  }
}