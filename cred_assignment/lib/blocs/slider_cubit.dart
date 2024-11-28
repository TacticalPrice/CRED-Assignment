import 'package:flutter_bloc/flutter_bloc.dart';


class SliderCubit extends Cubit<double> {
 SliderCubit() : super(150000);


 void updateAmount(double amount) => emit(amount);
}
