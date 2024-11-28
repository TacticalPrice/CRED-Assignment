import 'package:cred_assignment/domain/repo.dart';
import 'package:cred_assignment/network/dio_service.dart';
import 'package:get_it/get_it.dart';


final GetIt getIt = GetIt.instance;


void setupServiceLocator() {
 getIt.registerSingleton<DioService>(DioService());
 getIt.registerLazySingleton<TestMintRepository>(
   () => TestMintRepository(getIt<DioService>()),
 );
}



