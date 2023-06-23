import 'package:takatof/management/domain/usecases/accept_register_request_usecase.dart';
import 'package:takatof/management/domain/usecases/get_evaluation_usecase.dart';
import 'package:takatof/management/domain/usecases/get_event_details_usecase.dart';
import 'package:takatof/management/domain/usecases/get_profile_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_evaluate_usecase.dart';
import 'package:takatof/management/domain/usecases/save_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/save_evaluation_usecase.dart';

class ApiConstance{
  static String token = '';
  static String fcmToken = '';

  static const String baseUrl = "https://iii0.com";

  static String url({required String endPoint})=> baseUrl+endPoint;

  ///END POINTS
  static const String loginPath =
      "/login/volunteer";
  static const String projectsPath =
      "/api/volunteer/project";
  static const String newEventsPath =
      "/api/voluteer/activity/new";
  static const String myEventsPath =
      "/api/voluteer/activity/myActivity";
  static const String adminEventsPath =
      "/api/voluteer/activity/admin";
  static const String myTasksPath =
      "/api/voluteer/task/my/task";
  static const String newTasksPath =
      "/api/voluteer/task/new";
  static const String registerToTask =
      "/api/voluteer/task/register";
  static const String rejectTask =
      "/api/voluteer/task/end";
  static const String registerInEvent =
      "/api/voluteer/activity/register";
  static const String endEvent =
      "/api/voluteer/activity/end";
  static const String addAdminNote =
      "/api/voluteer/activity/note/admin";
  static const String addVolunteerComment =
      "/api/voluteer/activity/comment";
  static const String likeEvent =
      "/api/voluteer/activity/like";
  static const String scanQRCode =
      "/api/attend/save/qr";
  static const String getRegisterRequests =
      "/api/voluteer/activity/show/volutter/request";
  static const String uploadProfileImage =
      "/api/upload";
  static String getProfile(GetProfileParameters parameters) =>
      "/volunteer/profile/${parameters.id}";
  static String getEventDetails(GetEventDetailsParameters parameters) =>
      "/profile/activity/${parameters.eventId}";
  static String acceptRegisterRequest(AcceptRegisterRequestParameters parameters) =>
      "/api/voluteer/activity/accept/volutter/request/${parameters.volunteerId}";
  static String volunteersForAttend(VolunteersForAttendParameters parameters) =>
      "/api/attend/table/${parameters.eventId}/${parameters.day}";
  static String saveAttend(SaveAttendParameters parameters) =>
      "/api/attend/table/${parameters.eventId}/${parameters.day}";
  static String volunteersForEvaluate(VolunteersForEvaluateParameters parameters) =>
      "/api/evaluation/table/${parameters.eventId}/${parameters.day}";
  static String evaluation(EvaluationParameters parameters) =>
      "/api/evaluation/volunteer/${parameters.volunteerId}/activity/${parameters.eventId}/day/${parameters.day}";
  static String saveEvaluation(SaveEvaluationParameters parameters) =>
      "/api/evaluation/volunteer/${parameters.volunteerId}/activity/${parameters.eventId}/day/${parameters.day}";
  static String initiativeDetailsPath(int id) =>
      "/api/volunteer/initiative/$id}";
  static String getQRCode(int id) =>
      "/qr-code/$id";
}