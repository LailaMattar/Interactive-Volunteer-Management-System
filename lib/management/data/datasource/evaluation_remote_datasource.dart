import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:takatof/core/error/error_model.dart';
import 'package:takatof/core/error/exceptions.dart';
import 'package:takatof/core/network/api_constance.dart';
import 'package:takatof/management/data/models/evalation_model.dart';
import 'package:takatof/management/data/models/volunteer_model.dart';
import 'package:takatof/management/domain/entities/evaluation.dart';
import 'package:takatof/management/domain/usecases/get_evaluation_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_evaluate_usecase.dart';
import 'package:takatof/management/domain/usecases/save_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/save_evaluation_usecase.dart';

abstract class BaseEvaluationRemoteDataSource{
  Future<List<VolunteerModel>> getVolunteersForAttend(VolunteersForAttendParameters parameters);
  Future<String> saveAttend(SaveAttendParameters parameters);
  Future<List<VolunteerModel>> getVolunteersForEvaluate(VolunteersForEvaluateParameters parameters);
  Future<MyEvaluation> getEvaluation(EvaluationParameters parameters);
  Future<String> saveEvaluation(SaveEvaluationParameters parameters);
}

class EvaluationRemoteDataSource extends BaseEvaluationRemoteDataSource{
  @override
  Future<List<VolunteerModel>> getVolunteersForAttend(VolunteersForAttendParameters parameters) async{
    try {
      print(ApiConstance.url(endPoint: ApiConstance.volunteersForAttend(parameters)));
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.url(endPoint: ApiConstance.volunteersForAttend(parameters)),
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
      debugPrint('getVolunteersForAttend response ${response.data.toString()}');
      if (response.statusCode == 200) {

        return List<VolunteerModel>.from(
            (response.data as List).map((object) =>
                VolunteerModel.fromJsonAttend(object)));
      } else {
        print("error getVolunteersForAttend response rr ${response.data}");
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print("error getVolunteersForAttend response ${e.response!.data}");
      print("error getVolunteersForAttend response ${e.response!.statusCode}");
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: "${e.response!.data} ${e.response!.statusCode}",
              statusCode: 0,
              success: false
          )
      );
    }catch(e){
      String error = e.toString();
      print("error getVolunteersForAttend response catch ${error}");
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
  Future<String> saveAttend(SaveAttendParameters parameters) async{
    try{
      print(ApiConstance.url(endPoint: ApiConstance.saveAttend(parameters)));
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.saveAttend(parameters)),
          data:parameters.ids,
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
      print('saveAttend response : ${response.data}');
      if(response.statusCode == 200){
        return response.data;
      }else{
        print('error saveAttend');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error saveAttend dio error');
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: e.response!.data.toString(),
              statusCode: 0,
              success: false
          )
      );
    }
  }

  @override
  Future<List<VolunteerModel>> getVolunteersForEvaluate(VolunteersForEvaluateParameters parameters)async{
    try {
      print(ApiConstance.url(endPoint: ApiConstance.volunteersForEvaluate(parameters)));
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.url(endPoint: ApiConstance.volunteersForEvaluate(parameters)),
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
      debugPrint('getVolunteersForEvaluate response ${response.data.toString()}');
      if (response.statusCode == 200) {

        return List<VolunteerModel>.from(
            (response.data as List).map((object) =>
                VolunteerModel.fromJsonAttend(object)));
      } else {
        print("error getVolunteersForEvaluate response rr ${response.data}");
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print("error getVolunteersForEvaluate response ${e.response!.data}");
      print("error getVolunteersForEvaluate response ${e.response!.statusCode}");
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: "${e.response!.data} ${e.response!.statusCode}",
              statusCode: 0,
              success: false
          )
      );
    }catch(e){
      String error = e.toString();
      print("error getVolunteersForAttend response catch ${error}");
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
  Future<MyEvaluation> getEvaluation(EvaluationParameters parameters) async{
    try {
      print(ApiConstance.url(endPoint: ApiConstance.evaluation(parameters)));
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.url(endPoint: ApiConstance.evaluation(parameters)),
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
      debugPrint('getEvaluation response ${response.data.toString()}');
      if (response.statusCode == 200) {

        return MyEvaluationModel.fromJson(response.data);
      } else {
        print("error getEvaluation response rr ${response.data}");
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print("error getEvaluation response ${e.response!.data}");
      print("error getEvaluation response ${e.response!.statusCode}");
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: "${e.response!.data} ${e.response!.statusCode}",
              statusCode: 0,
              success: false
          )
      );
    }catch(e){
      String error = e.toString();
      print("error getEvaluation response catch ${error}");
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
  Future<String> saveEvaluation(SaveEvaluationParameters parameters)async{
    try{
      print(ApiConstance.url(endPoint: ApiConstance.saveEvaluation(parameters)));
      for(int i = 0 ; i < parameters.measurement.length ; i ++){
        print('id : ${parameters.measurement[i].id}');
        print('value : ${parameters.measurement[i].value}');
      }
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.saveEvaluation(parameters)),
          data: parameters.measurement.map((e) => e.toJson()).toList(),
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
      print('saveEvaluation response : ${response.data}');
      if(response.statusCode == 200){
        return response.data;
      }else{
        print('error saveEvaluation');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error saveEvaluation dio error');
      throw ServerException(
          errorModel: ErrorModel(
              statusMessage: e.response!.data.toString(),
              statusCode: 0,
              success: false
          )
      );
    }
  }

}