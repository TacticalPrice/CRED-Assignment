import 'package:flutter_bloc/flutter_bloc.dart';


class CardSelectionCubit extends Cubit<int> {
 CardSelectionCubit() : super(0); 


 void selectCard(int index) {
   emit(index);
 }
}
