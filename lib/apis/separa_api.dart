import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:teste_tela/config/service.dart';
import 'package:teste_tela/models/separa.dart';

abstract class SeparaApi {
  static Future<dynamic> iniciarSeparacao(
      {required int nrpreoc,
      required String local,
      required int separador}) async {
    List<Separa> lista = [];
    var response = await Dio().putUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/separa/iniciar/separacao",
      ),
      data: jsonEncode(
        {
          "nrpreoc": nrpreoc,
          "local": local,
          "separador": separador,
        },
      ),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
        for (Map<String, dynamic> i in data["data"]) {
          lista.add(Separa.fromMap(i));
        }
        return lista;
      } else if (response.statusCode == 404) {
        return lista;
      }
    } catch (e) {
      return lista;
    }
  }

  static Future<dynamic> iniciarConferencia({
    required int nrpreoc,
    required String local,
    required int conferente,
  }) async {
    List<Separa> lista = [];
    var response = await Dio().putUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/separa/iniciar/conferencia",
      ),
      data: jsonEncode(
        {
          "nrpreoc": nrpreoc,
          "local": local,
          "conferente": conferente,
        },
      ),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
        for (Map<String, dynamic> i in data["data"]) {
          lista.add(Separa.fromMap(i));
        }
        return lista;
      } else if (response.statusCode == 404) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> atribuirSeparacao(
      {required int nrpreoc,
      required String local,
      required int separador}) async {
    var response = await Dio().putUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/separa/atribuir/separacao",
      ),
      data: jsonEncode(
        {
          "nrpreoc": nrpreoc,
          "local": local,
          "separador": separador,
        },
      ),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> retirarSeparacao(
      {required int nrpreoc,
      required String local,
      required int separador}) async {
    var response = await Dio().putUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/separa/retirar/separacao",
      ),
      data: jsonEncode(
        {
          "nrpreoc": nrpreoc,
          "local": local,
          "separador": separador,
        },
      ),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> liberarSeparacao(
      {required int id,
      required String statuschecagem,
      required int qtdsep}) async {
    var response = await Dio().putUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/separa/liberar/separacao",
      ),
      data: jsonEncode(
        {
          "id": id,
          "statuschecagem": statuschecagem,
          "qtdsep": qtdsep,
        },
      ),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> finalizarConferencia(
      {required int id,
      required String conferido,
      required int qtdconf}) async {
    var response = await Dio().putUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/separa/finalizar/conferencia",
      ),
      data: jsonEncode(
        {
          "id": id,
          "conferido": conferido,
          "qtdconf": qtdconf,
        },
      ),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
