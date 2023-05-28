class ApiConstance{
  static String token = '';

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
  static const String myTasksPath =
      "/api/voluteer/task/my/task";
  static const String acceptTask =
      "/api/voluteer/task/accept";
  static const String rejectTask =
      "/api/voluteer/task/cancel";
  static const String registerInEvent =
      "/api/voluteer/activity/register";
  static String initiativeDetailsPath(int id) =>
      "/api/volunteer/initiative/$id}";
}