import 'package:dio/dio.dart';
import 'package:teste_tela/config/service.dart';
import 'package:teste_tela/models/cortesepara.dart';

abstract class CorteSeparaApi {
  static Future<List<CorteSepara>> obterReconferenciasSeparador(
      int separador) async {
    List<CorteSepara> lista = [];
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/cortesepara",
        queryParameters: {
          "separador": separador.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      for (Map<String, dynamic> i in data["content"]) {
        lista.add(CorteSepara.fromMap(i));
        lista.sort((a, b) => a.nrpreoc!.compareTo(b.nrpreoc!));
      }
    }
    return lista;
  }

  static Future<int> obterQtdReconferencias(int separador) async {
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/cortesepara",
        queryParameters: {
          "separador": separador.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      return data["totalSize"];
    } else {
      return 0;
    }
  }
}
