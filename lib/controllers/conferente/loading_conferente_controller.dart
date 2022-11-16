
import 'package:get/get.dart';
import 'package:teste_tela/apis/gruposepapp_api.dart';
import 'package:teste_tela/apis/sepconf_api.dart';

class LoadingConferenteController extends GetxController {
  RxInt usuariosD = 0.obs;

  RxInt usuariosO = 0.obs;

  RxInt usuariosA = 0.obs;

  RxInt qtdDisponiveis = 0.obs;

  RxInt qtdEmAndamento = 0.obs;

  RxInt qtdLiberadas = 0.obs;

  RxInt qtdAtribuidas = 0.obs;

  RxInt minhasConferencias = 0.obs;

  buscarQtdUsuarios() async {
    usuariosD.value = await SepConfApi.findByStatusAndTipo("D", "S");
    usuariosO.value = await SepConfApi.findByStatusAndTipo("O", "S");
    usuariosA.value = await SepConfApi.findByStatusAndTipo("A", "S");
  }

  buscarStatusQtd() async {
    qtdDisponiveis.value = await GrupoSepAppApi.findByStatus("D");
    qtdEmAndamento.value = await GrupoSepAppApi.findByStatus("E");
    qtdLiberadas.value = await GrupoSepAppApi.findByStatus("L");
    qtdAtribuidas.value = await GrupoSepAppApi.findByStatus("A");
  }

  obterPreordensConferente(int idsepconf) async {
    minhasConferencias.value = await GrupoSepAppApi.findByConferente(idsepconf);
  }

  carregar(int idsepconf) async {
    await buscarStatusQtd();
    await obterPreordensConferente(idsepconf);
  }
}
