import 'package:dio/dio.dart';


class DioService {
 final Dio _dio = Dio(BaseOptions(
   baseUrl: "",
   headers: {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
   },
 ));


 DioService() {
   _dio.interceptors.add(
     InterceptorsWrapper(
       onRequest: (options, handler) async {
         return handler.next(options); 
       },
       onResponse: (response, handler) {
         return handler.next(response); 
       },
       onError: (DioException error, handler) {
         if (error.response != null) {
           switch (error.response!.statusCode) {
             case 400:
               print('Bad request: ${error.response!.data}');
               break;
             case 401:
               print('Unauthorized: ${error.response!.data}');
               break;
             case 500:
               print('Server error: ${error.response!.data}');
               break;
             default:
               print('Error: ${error.response!.statusCode} - ${error.response!.data}');
           }
         } else {
           print('Unexpected error: ${error.message}');
         }
         return handler.next(error);
       },
     ),
   );
 }


 Dio get dio => _dio;
}

