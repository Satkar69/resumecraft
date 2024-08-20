class Config {
  static const String appName = "resumecraft";
  // static const String apiUrl = "http://localhost:3000/api/"; // for web
  // static const String apiUrl = "10.0.0.7:4000/api/"; // for android emulator
  static const String apiUrl =
      "http://192.168.1.65:3000/api/"; // for physical device

  // ===================== public Routes ===========================
  static const String register = "user/register";

  // ===================== Auth Routes ===========================
  static const String login = "auth/login";
  static const String userProfile = "user/profile";
}
