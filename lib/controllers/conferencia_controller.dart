
import 'package:get/get.dart';
import 'package:teste_tela/models/separa.dart';
import 'package:teste_tela/utils/database_resource.dart';
import 'package:teste_tela/utils/produto_helper.dart';

class ConferenciaController extends GetxController {
  RxList produtos = RxList();

  RxList produtosConferidos = RxList();

  final DatabaseResource db = DatabaseResource();

  iniciarConferencia(List<Separa> lista) async {
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
    produtos.addAll(await db.obterProdutosConferente(nrpreoc, setor));
    produtos.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
    buscarProdutosConferidos(idsepconf, nrpreoc, setor);
  }

  buscarProdutosConferidos(int idsepconf, int nrpreoc, String setor) async {
    produtosConferidos.clear();
    produtosConferidos
        .addAll(await db.obterProdutosConferidos(idsepconf, nrpreoc, setor));
    produtosConferidos.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
  }

  conferirProduto(
    String conferido,
    int qtdconf,
    ProdutoHelper produtoHelper,
  ) async {
    List<ProdutoHelper> s =
        await db.conferirProduto(produtoHelper.id!, conferido, qtdconf);
    produtos.remove(produtoHelper);
    produtosConferidos.addAll(s);
    produtos.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
    produtosConferidos.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
  }

  removerProduto(ProdutoHelper produtoHelper) async {
    List<ProdutoHelper> s = await db.removerConferencia(produtoHelper.id!);
    produtosConferidos.remove(produtoHelper);
    produtos.addAll(s);
    produtos.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
    produtosConferidos.sort((a, b) => a.descrprod!.compareTo(b.descrprod!));
  }

  // @action
  // finalizarSeparacao(SeparacaoHelpers db) {
  //   produtos.clear();
  //   produtosSeparados.clear();
  // }
}
