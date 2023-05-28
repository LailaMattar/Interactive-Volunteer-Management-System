import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:takatof/core/error/error_model.dart';
import 'package:takatof/core/error/exceptions.dart';
import 'package:takatof/core/network/api_constance.dart';
import 'package:takatof/core/utils/app_constance.dart';
import 'package:takatof/management/data/models/event_model.dart';
import 'package:takatof/management/data/models/initiative_model.dart';
import 'package:takatof/management/data/models/project_model.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';

abstract class BaseManagementDataSource{
  Future<String> login(Volunteer parameters);
  Future<List<ProjectModel>> getProjects();
  Future<List<EventModel>> getEvents();
  Future<List<EventModel>> getMyEvents();
  Future<InitiativeModel> getInitiativeDetails(int parameters);
  Future<String> registerInEvent(int parameters);
}

class ManagementDataSource implements BaseManagementDataSource{
  @override
  Future<List<ProjectModel>> getProjects() async{
    try {
      print(ApiConstance.baseUrl+ApiConstance.projectsPath);
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
        ApiConstance.baseUrl+ApiConstance.projectsPath,
        options: Options(
            headers: {
              'Authorization':ApiConstance.token,
              "Accept": "application/json",
              'Content-type': 'application/json'
            },
        )
      );
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        return List<ProjectModel>.from(
            (response.data['projects'] as List).map((object) =>
                ProjectModel.fromJson(object)));
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
      print("error response ${e.response!.data}");
      print("error response ${e.response!.statusCode}");
      throw ServerException(
          errorModel: const ErrorModel(
            statusMessage: "error",
            statusCode: 0,
            success: false
          )
      );
    }
  }

  @override
  Future<String> login(Volunteer parameters)async {
    try{
      print(ApiConstance.baseUrl+ApiConstance.loginPath);
      final response = await Dio().post(
        ApiConstance.baseUrl+ApiConstance.loginPath,
        queryParameters:{
          'email':parameters.email,
          'password':parameters.password,
        },
        options: Options(
          headers: {"Accept": "application/json", 'Content-type': 'application/json'},
          validateStatus: (status){
            return status == 404 || status == 401 || status == 200;
          }
        )
      );
      print('login response : ${response.data}');
      if(response.statusCode == 200){
        AppConstance.role = response.data['role'];
        return response.data['token'];
      }else{
        print('error login');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error login dio error');
      throw ServerException(
          errorModel: const ErrorModel(
              statusMessage: "error",
              statusCode: 0,
              success: false
          )
      );
    }
  }

  @override
  Future<List<EventModel>> getEvents() async{
    try {
      print(ApiConstance.baseUrl+ApiConstance.newEventsPath);
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.baseUrl+ApiConstance.newEventsPath,
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
      debugPrint('events response ${response.data.toString()}');
      if (response.statusCode == 200) {
        return List<EventModel>.from(
            (response.data['activity'] as List).map((object) =>
                EventModel.fromJson(object)));
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
          errorModel: const ErrorModel(
              statusMessage: "error",
              statusCode: 0,
              success: false
          )
      );
    }catch(e){
      throw AppException(
          errorModel: ErrorModel(
              statusMessage: e.toString(),
              statusCode: 0,
              success: false
          )
      );
    }
  }

  @override
  Future<List<EventModel>> getMyEvents() async{
    try {
      print(ApiConstance.baseUrl+ApiConstance.myEventsPath);
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.baseUrl+ApiConstance.myEventsPath,
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
      debugPrint('my events response ${response.data.toString()}');
      if (response.statusCode == 200) {
        return List<EventModel>.from(
            (response.data['activity'] as List).map((object) =>
                EventModel.fromJson(object)));
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
  Future<InitiativeModel> getInitiativeDetails(int parameters) async{
    try {
      print(ApiConstance.url(endPoint: ApiConstance.initiativeDetailsPath(parameters)));
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.url(endPoint: ApiConstance.initiativeDetailsPath(parameters)),
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
      debugPrint('initiative response ${response.data}');
      if (response.statusCode == 200) {
        return InitiativeModel.fromJson(response.data);
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
  Future<String> registerInEvent(int parameters) async{
    try{
      print(ApiConstance.baseUrl+ApiConstance.registerInEvent);
      final response = await Dio().post(
          ApiConstance.baseUrl+ApiConstance.registerInEvent,
          queryParameters:{
            'id_activity':parameters,
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
      print('register in activity response : ${response.data}');
      if(response.statusCode == 200){
        return response.data['message'];
      }else{
        print('error login');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error login dio error');
      throw ServerException(
          errorModel: const ErrorModel(
              statusMessage: "error",
              statusCode: 0,
              success: false
          )
      );
    }
  }

}