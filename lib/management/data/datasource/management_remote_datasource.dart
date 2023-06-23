import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:takatof/core/error/error_model.dart';
import 'package:takatof/core/error/exceptions.dart';
import 'package:takatof/core/network/api_constance.dart';
import 'package:takatof/core/utils/app_constance.dart';
import 'package:takatof/management/data/models/event_details_model.dart';
import 'package:takatof/management/data/models/event_model.dart';
import 'package:takatof/management/data/models/initiative_model.dart';
import 'package:takatof/management/data/models/profile_model.dart';
import 'package:takatof/management/data/models/project_model.dart';
import 'package:takatof/management/data/models/register_request_model.dart';
import 'package:takatof/management/domain/entities/auth.dart';
import 'package:takatof/management/domain/usecases/accept_register_request_usecase.dart';
import 'package:takatof/management/domain/usecases/add_admin_note_usecase.dart';
import 'package:takatof/management/domain/usecases/add_volunteer_comment_usecase.dart';
import 'package:takatof/management/domain/usecases/generate_qr_code_usecase.dart';
import 'package:takatof/management/domain/usecases/get_event_details_usecase.dart';
import 'package:takatof/management/domain/usecases/get_profile_usecase.dart';
import 'package:takatof/management/domain/usecases/get_register_requests_usecase.dart';
import 'package:takatof/management/domain/usecases/like_event_usecase.dart';
import 'package:takatof/management/domain/usecases/scan_qr_code_usecase.dart';
import 'package:takatof/management/domain/usecases/upload_profile_image_usecase.dart';

abstract class BaseManagementDataSource{
  Future<String> login(Auth parameters);
  Future<List<ProjectModel>> getProjects();
  Future<List<EventModel>> getEvents();
  Future<List<EventModel>> getMyEvents();
  Future<List<EventModel>> getAdminEvents();
  Future<InitiativeModel> getInitiativeDetails(int parameters);
  Future<String> registerInEvent(int parameters);
  Future<String> endEvent(int parameters);
  Future<String> addAdminNote(AdminNoteParameters parameters);
  Future<String> addVolunteerComment(VolunteerCommentParameters parameters);
  Future<String> likeEvent(LikeEventParameters parameters);
  Future<String> generateQRCode(GenerateQRCodeParameters parameters);
  Future<String> scanQRCode(ScanQRCodeParameters parameters);
  Future<List<RegisterRequestModel>> getRegisterRequests(GetRegisterRequestsParameters parameters);
  Future<String> acceptRegisterRequest(AcceptRegisterRequestParameters parameters);
  Future<ProfileModel> getProfile(GetProfileParameters parameters);
  Future<String> uploadProfileImage(UploadProfileImageParameters parameters);
  Future<EventDetailsModel> getEventDetails(GetEventDetailsParameters parameters);
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
  Future<String> login(Auth parameters)async {
    try{
      print(ApiConstance.baseUrl+ApiConstance.loginPath);
      final response = await Dio().post(
        ApiConstance.baseUrl+ApiConstance.loginPath,
        queryParameters:{
          'email':parameters.email,
          'password':parameters.password,
          'fcm_token':ApiConstance.fcmToken,
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
        AppConstance.id = response.data['id'];
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
        List<EventModel> state1 = List<EventModel>.from(
            (response.data['1'] ?? []).map((object) =>
                EventModel.fromJson(object)));
        List<EventModel> state2 = List<EventModel>.from(
            (response.data['2'] ?? []).map((object) =>
                EventModel.fromJson(object)));
        List<EventModel> state3 = List<EventModel>.from(
            (response.data['3'] ?? []).map((object) =>
                EventModel.fromJson(object)));
        List<EventModel> stateAll = [];
        stateAll.addAll(state1);
        stateAll.addAll(state2);
        stateAll.addAll(state3);
        print('state1 length : ${state1.length}');
        print('state2 length : ${state2.length}');
        print('state3 length : ${state3.length}');
        return stateAll;
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
        print('error registerInEvent');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error registerInEvent dio error');
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
  Future<String> endEvent(int parameters) async{
    try{
      print(ApiConstance.baseUrl+ApiConstance.endEvent);
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.endEvent),
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
      print('end activity response : ${response.data}');
      if(response.statusCode == 200){
        return response.data['message'];
      }else{
        print('error end activity');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error end activity dio error');
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
  Future<String> addAdminNote(AdminNoteParameters parameters) async{
    try{
      print(ApiConstance.baseUrl+ApiConstance.addAdminNote);
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.addAdminNote),
          queryParameters:{
            'id_activity':parameters.activityId,
            'note': parameters.note,
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
      print('addAdminNote response : ${response.data}');
      if(response.statusCode == 200){
        return response.data['message'];
      }else{
        print('error addAdminNote');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error addAdminNote dio error');
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
  Future<String> addVolunteerComment(VolunteerCommentParameters parameters) async{
    try{
      print(ApiConstance.baseUrl+ApiConstance.addVolunteerComment);
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.addVolunteerComment),
          queryParameters:{
            'id_activity':parameters.eventId,
            'comment': parameters.comment,
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
      print('addVolunteerComment response : ${response.data}');
      if(response.statusCode == 200){
        return response.data['message'];
      }else{
        print('error addVolunteerComment');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error addVolunteerComment dio error');
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
  Future<String> likeEvent(LikeEventParameters parameters) async{
    try{
      print(ApiConstance.baseUrl+ApiConstance.likeEvent);
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.likeEvent),
          queryParameters:{
            'id_activity':parameters.activityId,
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
      print('likeEvent response : ${response.data}');
      if(response.statusCode == 200){
        return response.data['message'];
      }else{
        print('error likeEvent');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error likeEvent dio error');
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
  Future<List<EventModel>> getAdminEvents() async{
    try {
      print(ApiConstance.baseUrl+ApiConstance.adminEventsPath);
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.baseUrl+ApiConstance.adminEventsPath,
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
        List<EventModel> state1 = List<EventModel>.from(
            (response.data['1'] ?? []).map((object) =>
                EventModel.fromJson(object)));
        List<EventModel> state2 = List<EventModel>.from(
            (response.data['2'] ?? []).map((object) =>
                EventModel.fromJson(object)));
        List<EventModel> state3 = List<EventModel>.from(
            (response.data['3'] ?? []).map((object) =>
                EventModel.fromJson(object)));
        List<EventModel> stateAll = [];
        stateAll.addAll(state1);
        stateAll.addAll(state2);
        stateAll.addAll(state3);
        print('state1 length : ${state1.length}');
        print('state2 length : ${state2.length}');
        print('state3 length : ${state3.length}');
        return stateAll;
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
  Future<String> generateQRCode(GenerateQRCodeParameters parameters) async{
    try {
      print(ApiConstance.baseUrl+ApiConstance.getQRCode(parameters.eventId));
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.baseUrl+ApiConstance.getQRCode(parameters.eventId),
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
      debugPrint('generateQRCode response ${response.data}');
      if (response.statusCode == 200) {
        return response.data['id']+','+response.data['randomString'];
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
      print("error generateQRCode response ${e.response!.data}");
      print("error generateQRCode response ${e.response!.statusCode}");
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
  Future<String> scanQRCode(ScanQRCodeParameters parameters) async{
    try{
      print('body request : ${{
        'id':parameters.volunteerId,
        'randomString':parameters.qrString,
        'id_activity':parameters.eventId,
      }}');
      print(ApiConstance.baseUrl+ApiConstance.scanQRCode);
      final response = await Dio().post(
          ApiConstance.baseUrl+ApiConstance.scanQRCode,
          queryParameters:{
            'id':parameters.volunteerId,
            'randomString':parameters.qrString,
            'id_activity':parameters.eventId,
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
      print('scanQRCode response : ${response.data}');
      if(response.statusCode == 200){
        return response.data;
      }else{
        print('error scanQRCode');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error scanQRCode dio error');
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
  Future<List<RegisterRequestModel>> getRegisterRequests(GetRegisterRequestsParameters parameters) async{
    try {
      print(ApiConstance.baseUrl+ApiConstance.getRegisterRequests);
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.baseUrl+ApiConstance.getRegisterRequests,
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
      debugPrint('getRegisterRequests response ${response.data.toString()}');
      if (response.statusCode == 200) {
        return List<RegisterRequestModel>.from(
            (response.data ?? []).map((object) =>
                RegisterRequestModel.fromJson(object)));
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
      print("error getRegisterRequests response ${e.response!.data}");
      print("error getRegisterRequests response ${e.response!.statusCode}");
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
  Future<String> acceptRegisterRequest(AcceptRegisterRequestParameters parameters) async{
    try{
      print(ApiConstance.baseUrl+ApiConstance.acceptRegisterRequest(parameters));
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.acceptRegisterRequest(parameters)),
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
      print('acceptRegisterRequest response : ${response.data}');
      if(response.statusCode == 200){
        return response.data['message'];
      }else{
        print('error acceptRegisterRequest');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error acceptRegisterRequest dio error');
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
  Future<ProfileModel> getProfile(GetProfileParameters parameters) async{
    try {
      print(ApiConstance.baseUrl+ApiConstance.getProfile(parameters));
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.baseUrl+ApiConstance.getProfile(parameters),
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
      debugPrint('getProfile response ${response.data.toString()}');
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
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
      print("error getProfile response ${e.response!.data}");
      print("error getProfile response ${e.response!.statusCode}");
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
  Future<String> uploadProfileImage(UploadProfileImageParameters parameters) async{
    try{
      print(ApiConstance.baseUrl+ApiConstance.uploadProfileImage);
      String path = parameters.path;
      String fileName = parameters.imageName;
      FormData formData =  FormData.fromMap({
        "image": await MultipartFile.fromFile(path, filename:fileName),
        'id_volunteer':parameters.volunteerId,
      });
      final response = await Dio().post(
          ApiConstance.url(endPoint: ApiConstance.uploadProfileImage),
          data: formData,
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
      print('acceptRegisterRequest response : ${response.data}');
      if(response.statusCode == 200){
        return response.data;
      }else{
        print('error acceptRegisterRequest');
        throw ServerException(
            errorModel: ErrorModel(
                statusMessage: response.data['message'],
                success: false,
                statusCode: response.statusCode!
            )
        );
      }
    }on DioError catch(e){
      print('error acceptRegisterRequest dio error');
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
  Future<EventDetailsModel> getEventDetails(GetEventDetailsParameters parameters) async{
    try {
      print(ApiConstance.baseUrl+ApiConstance.getEventDetails(parameters));
      print('token is ${ApiConstance.token}');
      final response = await Dio().get(
          ApiConstance.baseUrl+ApiConstance.getEventDetails(parameters),
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
      debugPrint('getProfile response ${response.data.toString()}');
      if (response.statusCode == 200) {
        return EventDetailsModel.fromJson(response.data);
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
      print("error getProfile response ${e.response!.data}");
      print("error getProfile response ${e.response!.statusCode}");
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