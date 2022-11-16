
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:teste_tela/config/service.dart';
import 'package:teste_tela/models/gruposepapp.dart';

class GrupoController extends GetxController {
  // RxInt page = 0.obs;
  RxList<GrupoSepApp> lista = RxList();

  fetch(String setor, String status, int page) async {
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/gruposepapp",
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      for (Map<String, dynamic> i in data["content"]) {
        lista.add(GrupoSepApp.fromMap(i));
      }
    }
    return lista;
    // this.page.value++;
  }
}
