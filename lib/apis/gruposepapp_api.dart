import 'package:dio/dio.dart';
import 'package:teste_tela/config/service.dart';

abstract class GrupoSepAppApi {
  static Future<dynamic> findBySeparador(int idseparador) async {
    var totalSize = 0;
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/gruposepapp",
        queryParameters: {
          "idseparador": idseparador.toString(),
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
        for (int i = 0; i < data["data"].length; i++) {
          totalSize++;
        }
        return totalSize;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<dynamic> findByStatus(String status) async {
    int totalSize = 0;
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/gruposepapp",
        queryParameters: {
          "status": status.toUpperCase(),
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

        for (int i = 0; i < data["data"].length; i++) {
          totalSize++;
        }
        return totalSize;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  static Future<dynamic> findByConferente(int idconferente) async {
    int totalSize = 0;
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/gruposepapp",
        queryParameters: {
          "idconferente": idconferente.toString(),
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

        for (int i = 0; i < data["data"].length; i++) {
          totalSize++;
        }
        return totalSize;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<dynamic> findByLocalizacaoAndStatus(
      String setor, String status) async {
    int totalSize = 0;
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/gruposepapp",
        queryParameters: {
          "localizacao": setor,
          "status": status,
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
        for (int i = 0; i < data["data"].length; i++) {
          totalSize++;
        }
        // for (Map<String, dynamic> i in data["data"]) {
        //   totalSize++;
        // }
        return totalSize;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
