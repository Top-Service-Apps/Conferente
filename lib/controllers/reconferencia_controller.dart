
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:teste_tela/apis/cortesepara_api.dart';
import 'package:teste_tela/models/cortesepara.dart';

class ReconferenciaController extends GetxController {
  RxList produtos = RxList();

  RxString codigoBarras = "".obs;

  RxInt qtdCorte = 0.obs;

  RxBool troca = false.obs;

  RxString embalagem = "".obs;

  RxBool unidadeVenda = true.obs;

  final AudioCache audioCache = AudioCache();

  iniciar(CorteSepara corteSepara) {
    codigoBarras.value = corteSepara.codbarras!;
    qtdCorte.value = corteSepara.qtdcorte!;
    embalagem.value = corteSepara.embalagem!;
    unidadeVenda.value = true;
  }

  buscarProdutos(int separador) async {
    produtos.clear();
    produtos
        .addAll(await CorteSeparaApi.obterReconferenciasSeparador(separador));
  }

  reconferir() {}
}
