
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/models/separa.dart';
import 'package:teste_tela/utils/database_resource.dart';
import 'package:teste_tela/utils/produto_helper.dart';

class SeparacaoController extends GetxController {
  RxList produtos = RxList();

  RxList produtosSeparados = RxList();

  RxString codigoBarras = "".obs;

  RxInt qtdNegociada = 0.obs;

  RxBool troca = false.obs;

  RxString embalagem = "".obs;

  RxBool unidadeVenda = true.obs;

  final AudioCache audioCache = AudioCache();

  final DatabaseResource db = DatabaseResource();

  iniciarSeparacao(List<Separa> lista) async {
    for (Separa separa in lista) {
      ProdutoHelper s = ProdutoHelper(
        id: separa.id,
        nrpreoc: separa.nrpreoc,
        sku: separa.sku,
        codemp: separa.codemp,
        codprod: separa.codprod,
        descrprod: separa.descrprod,
        controle: separa.controle,
        qtdneg: separa.qtdneg,
        codbarras: separa.codbarras,
        embalagem: separa.embalagem,
        idseparador: separa.idseparador,
        idconferente: separa.idconferente,
        status: separa.status,
        qrcode: separa.qrcode,
        dtini: separa.dtini,
        dtfim: separa.dtfim,
        statuschecagem: separa.statuschecagem,
        qtdsep: separa.qtdsep,
        conferido: separa.conferido,
        codprodforn: separa.codprodforn,
        setor: separa.setor,
        qtdnegund: separa.qtdnegund,
        codbarraund: separa.codbarraund,
      );
      db.inserirSeparacao(s);
    }
  }

  buscarProdutos(
    int idsepconf,
    int nrpreoc,
    String setor,
  ) async {
    produtos.clear();
    produtos.addAll(await db.obterProdutos(idsepconf, nrpreoc, setor));
    produtos.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
    buscarProdutosSeparados(idsepconf, nrpreoc, setor);
  }

  buscarProdutosSeparados(int idsepconf, int nrpreoc, String setor) async {
    produtosSeparados.clear();
    produtosSeparados
        .addAll(await db.obterProdutosSeparados(idsepconf, nrpreoc, setor));
    produtosSeparados.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
  }

  separarProduto(
    String statuschecagem,
    int qtdsep,
    ProdutoHelper produtoHelper,
  ) async {
    List<ProdutoHelper> s =
        await db.separarProduto(statuschecagem, qtdsep, produtoHelper.id!);
    produtos.remove(produtoHelper);
    produtosSeparados.addAll(s);
    produtos.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
    produtosSeparados.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
  }

  removerProduto(ProdutoHelper produtoHelper) async {
    List<ProdutoHelper> s = await db.removerSeparacao(produtoHelper.id!);
    produtosSeparados.remove(produtoHelper);
    produtos.addAll(s);
    produtos.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
    produtosSeparados.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
  }

  Future<String> camera() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    return barcodeScanRes;
  }

  iniciar(ProdutoHelper produtoHelper) {
    codigoBarras.value = produtoHelper.codbarras!;
    qtdNegociada.value = produtoHelper.qtdneg!;
    embalagem.value = produtoHelper.embalagem!;
    unidadeVenda.value = true;
  }

  String trocarUnidadeVenda(ProdutoHelper produtoHelper) {
    if (unidadeVenda.isTrue) {
      unidadeVenda.value = false;
      codigoBarras.value = produtoHelper.codbarraund!;
      // this.qtdNegociada.value = produtoHelper.qtdnegund!;
      embalagem.value = "UN/${qtdNegociada.value}/UN";
      return qtdNegociada.value.toString();
    } else {
      unidadeVenda.value = true;
      codigoBarras.value = produtoHelper.codbarras!;
      // this.qtdNegociada.value = produtoHelper.qtdneg!;
      embalagem.value = produtoHelper.embalagem!;
      return qtdNegociada.value.toString();
    }
  }

  validarProduto(
      ProdutoHelper produtoHelper, int qtd, FocusNode focusNode) async {
    String codigo = await camera();
    if (codigo == "-1") {
      return;
    }
    if (codigo != codigoBarras.value) {
      focusNode.unfocus();
      audioCache.play('musics/error.mp3').then(
            (value) => Get.defaultDialog(
              title: "Erro",
              content: const Text("Código de barras inválido!"),
              onCancel: () {},
              textCancel: "Voltar",
            ),
          );
    } else if ((codigo.substring(7) == codigoBarras.substring(7) &&
        qtd == qtdNegociada.value)) {
      audioCache.play('musics/sucesso.mp3').then(
            (value) => separarProduto("S", qtd, produtoHelper).then(
              (value) => Get.back(),
            ),
          );
    } else if (codigo == codigoBarras.value &&
        qtd != qtdNegociada.value) {
      Get.defaultDialog(
        title: "Atenção",
        content: Column(
          children: [
            const Text("Quantidades divergentes"),
            SizedBox(
              height: 2.h,
            ),
            Text("QTDNEG:\t\t$qtdNegociada"),
            SizedBox(
              height: 2.h,
            ),
            Text("QTDSEP:\t\t$qtd"),
            SizedBox(
              height: 2.h,
            ),
            const Text("Deseja continuar?"),
          ],
        ),
        textCancel: "Não",
        onCancel: () {},
        textConfirm: "Sim",
        confirmTextColor: Colors.white,
        onConfirm: () {
          audioCache.play('musics/sucesso.mp3').then(
                (value) => separarProduto("C", qtd, produtoHelper).then(
                  (value) => {Get.back(), Get.back()},
                ),
              );
        },
      );
    }
  }

  // @action
  // finalizarSeparacao(SeparacaoHelpers db) {
  //   produtos.clear();
  //   produtosSeparados.clear();
  // }
}
