import 'package:cred_assignment/network/dio_service.dart';
import 'package:dio/dio.dart';


class TestMintRepository {
 final DioService _dioService;


 TestMintRepository(this._dioService);


 Future<Map<String, dynamic>> fetchTestMintData() async {
   try {
     final response = await _dioService.dio.get('https://api.mocklets.com/p6764/test_mint');
     return response.data;
   } on DioException catch (e) {
     throw Exception('Failed to fetch data: ${e.message}');
   }
 }
}



