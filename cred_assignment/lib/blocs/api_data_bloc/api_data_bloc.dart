import 'package:bloc/bloc.dart';
import 'package:cred_assignment/blocs/api_data_bloc/api_data_state.dart';
import 'package:cred_assignment/domain/repo.dart';
import 'package:meta/meta.dart';


class TestMintCubit extends Cubit<TestMintState> {
 final TestMintRepository _repository;


 TestMintCubit(this._repository) : super(TestMintInitial());


 Future<void> fetchTestMintData() async {
   emit(TestMintLoading());
   try {
     final data = await _repository.fetchTestMintData();
     emit(TestMintSuccess(data));
   } catch (e) {
     emit(TestMintError(e.toString()));
   }
 }
}
