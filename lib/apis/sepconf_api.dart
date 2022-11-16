import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:teste_tela/config/service.dart';
import 'package:teste_tela/models/sepconf.dart';

abstract class SepConfApi {
  static Future<dynamic> login(String nomeusu, String senha) async {
    var response = await Dio().putUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/sepconf/login",
      ),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
      data: jsonEncode({
        "nome": nomeusu.toUpperCase().trim(),
        "senha": senha.trim(),
      }),
    );

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
        return SepConf.fromMap(data["data"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<int> findByStatusAndTipo(String status, String tipo) async {
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/sepconf",
        queryParameters: {
          "status": status.toUpperCase(),
          "tipo": tipo.toUpperCase(),
        },
      ),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
        return data["totalSize"];
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
