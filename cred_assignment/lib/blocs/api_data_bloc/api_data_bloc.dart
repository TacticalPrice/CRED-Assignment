import 'package:bloc/bloc.dart';
import 'package:cred_assignment/blocs/api_data_bloc/api_data_state.dart';
import 'package:cred_assignment/domain/repo.dart';
import 'package:meta/meta.dart';


class DataCubit extends Cubit<ApiDataState> {
 final TestMintRepository _repository;


 DataCubit(this._repository) : super(ApiDataInitial());


 Future<void> fetchData() async {
   emit(ApiDataLoading());
   try {
     final data = await _repository.fetchTestMintData();
     emit(ApiDataSuccess(data));
   } catch (e) {
     emit(ApiDataError(e.toString()));
   }
 }
}
