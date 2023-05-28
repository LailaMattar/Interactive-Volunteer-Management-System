import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:takatof/core/error/error_model.dart';
import 'package:takatof/core/error/exceptions.dart';
import 'package:takatof/core/network/api_constance.dart';
import 'package:takatof/management/data/models/task_model.dart';

abstract class BaseTaskRemoteDataSource{
  Future<List<MyTaskModel>> getMyTasks();
  Future<String> acceptTask(int taskId);
  Future<String> rejectTask(int taskId);
}

class TaskRemoteDataSource extends BaseTaskRemoteDataSource{
  @override
  Future<List<MyTaskModel>> getMyTasks() async{
    try {
      print(ApiConstance.url(endPoint: ApiConstance.myTasksPath));
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.url(endPoint: ApiConstance.myTasksPath),
          options: Options(
              headers: {
                'Authorization':ApiConstance.token,
                "Accept": "application/json",
                'Content-type': 'application/json'
              },
              validateStatus: (status){
                return status == 404 || status == 401 || status == 200;
              }
          )
      );
      debugPrint('my tasks response ${response.data.toString()}');
      if (response.statusCode == 200) {
        return List<MyTaskModel>.from(
            (response.data['task'] as List).map((object) =>
                MyTaskModel.fromJson(object)));
      } else {
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print("error events response ${e.response!.data}");
      print("error events response ${e.response!.statusCode}");
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: "${e.response!.data} ${e.response!.statusCode}",
              statusCode: 0,
              success: false
          )
      );
    }catch(e){
      String error = e.toString();
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: error,
              statusCode: 0,
              success: false
          )
      );
    }
  }

  @override
  Future<String> acceptTask(int taskId) async{
    try {
      print(ApiConstance.url(endPoint: ApiConstance.acceptTask));
      print('token is ${ApiConstance.token}');
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.acceptTask),
          queryParameters: {
            'id_request':taskId,
          },
          options: Options(
              headers: {
                'Authorization':ApiConstance.token,
                "Accept": "application/json",
                'Content-type': 'application/json'
              },
              validateStatus: (status){
                return status == 404 || status == 401 || status == 200;
              }
          )
      );
      debugPrint('accept task response ${response.data.toString()}');
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print("error accept task response ${e.response!.data}");
      print("error accept task response ${e.response!.statusCode}");
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: "${e.response!.data} ${e.response!.statusCode}",
              statusCode: 0,
              success: false
          )
      );
    }catch(e){
      String error = e.toString();
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: error,
              statusCode: 0,
              success: false
          )
      );
    }
  }

  @override
  Future<String> rejectTask(int taskId) async{
    try {
      print('idddd : $taskId');
      print(ApiConstance.url(endPoint: ApiConstance.rejectTask));
      print('token is ${ApiConstance.token}');
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.rejectTask),
          queryParameters: {
            'id_request':taskId,
          },
          options: Options(
              headers: {
                'Authorization':ApiConstance.token,
                "Accept": "application/json",
                'Content-type': 'application/json'
              },
              validateStatus: (status){
                return status == 404 || status == 401 || status == 200;
              }
          )
      );
      debugPrint('reject task response ${response.data.toString()}');
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print("error accept task response ${e.response!.data}");
      print("error accept task response ${e.response!.statusCode}");
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: "${e.response!.data} ${e.response!.statusCode}",
              statusCode: 0,
              success: false
          )
      );
    }catch(e){
      String error = e.toString();
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: error,
              statusCode: 0,
              success: false
          )
      );
    }
  }

}