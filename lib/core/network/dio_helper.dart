// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:takatof/core/error/failure.dart';
// import 'package:takatof/core/network/api_constance.dart';
// import 'package:takatof/core/utils/enums.dart';
//
// class DioHelper<T,E>{
//
//   static final Dio _dio = Dio();
//
//   DioHelper(){
//     _dio.options = BaseOptions(
//         baseUrl: ApiConstance.baseUrl,
//         headers: {
//           'Accept' : 'application/json',
//           'Authorization' : 'Bearer ${ApiConstance.token}',
//         },
//         connectTimeout :const Duration(seconds: 8)
//     );
//   }
//
//   Future<Either<Failure,Response>> goApi({
//     required String url,
//     required RequestType method,
//     Map<String, dynamic>? params,
//   })async{
//     final Response response;
//     switch(method){
//       case RequestType.get:
//         response =await _dio.get(
//             url,
//             queryParameters: params
//         );
//         break;
//       case RequestType.post:
//         response =await _dio.post(
//             url,
//             queryParameters: params
//         );
//         break;
//       case RequestType.put:
//         response =await _dio.put(
//             url,
//             queryParameters: params
//         );
//         break;
//       case RequestType.delete:
//         response =await _dio.delete(
//             url,
//             queryParameters: params
//         );
//         break;
//     }
//
//     switch(response.statusCode){
//       case 200:
//       case 201:
//         return Right(response);
//       case 400:
//
//         // return Left(ServerFailure(message: failure.errorModel.statusMessage));
//     }
//     // return response;
//   }
// }