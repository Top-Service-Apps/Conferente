import 'package:get/get.dart';
import 'package:teste_tela/apis/cortesepara_api.dart';
import 'package:teste_tela/apis/gruposepapp_api.dart';

class LoadingSeparadorController extends GetxController {
  RxInt qtdMinhasSeparacoes = 0.obs;
  RxInt qtdMeuGrupo = 0.obs;
  RxInt qtdReconferencias = 0.obs;

  obterQtdMeuGrupo(String setor) async {
    qtdMeuGrupo.value =
        await GrupoSepAppApi.findByLocalizacaoAndStatus(setor, "D");
  }

  obterQtd() async {
    qtdMeuGrupo.value = await GrupoSepAppApi.findByStatus("D");
  }

  obterQtdMinhasSeparacoes(int separador) async {
    qtdMinhasSeparacoes.value = await GrupoSepAppApi.findBySeparador(separador);
  }

  obterQtdReconferencias(int separador) async {
    qtdReconferencias.value =
        await CorteSeparaApi.obterQtdReconferencias(separador);
  }
}
