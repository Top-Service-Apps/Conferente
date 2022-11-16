abstract class ServiceApp {
  static String ip = "187.8.165.202";
  static String port = "15656";

  static changeService(String ip, String port) {
    ServiceApp.ip = ip;
    ServiceApp.port = port;
  }
}
