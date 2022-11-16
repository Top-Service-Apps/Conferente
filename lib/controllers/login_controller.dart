
import 'package:get/get.dart';
import 'package:teste_tela/apis/sepconf_api.dart';
import 'package:teste_tela/models/sepconf.dart';

class LoginController extends GetxController {
  RxInt idsepconf = 0.obs;

  RxString setor = "".obs;

  RxString nomeusu = "".obs;

  RxString tipo = "".obs;

  RxString status = "".obs;

  Future<String> login(String nomeusu, String senha) async {
    try {
      SepConf response = await SepConfApi.login(nomeusu, senha);
      idsepconf.value = response.idsepconf!;
      setor.value = response.setor!;
      this.nomeusu.value = response.usuario!.nomeusu!;
      tipo.value = response.tipo!;
      status.value = response.status!;
      return tipo.value;
    } catch (e) {
      return "Erro";
    }
  }
}
