import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/separacao_controller.dart';
import 'package:teste_tela/screens/minhas_separacoes_conferencias/separador/minhas_separacoes_screen.dart';
import 'package:teste_tela/screens/produtos/separador/produtos_separados_screen.dart';
import 'package:teste_tela/utils/produto_helper.dart';
import 'components/card_produto.dart';

class ProdutosSeparadorScreen extends StatefulWidget {
  final int idsepconf;
  final int nrpreoc;
  final String setor;

  const ProdutosSeparadorScreen({
    Key? key,
    required this.idsepconf,
    required this.nrpreoc,
    required this.setor,
  }) : super(key: key);

  @override
  _ProdutosSeparadorScreenState createState() =>
      _ProdutosSeparadorScreenState();
}

class _ProdutosSeparadorScreenState extends State<ProdutosSeparadorScreen> {
  bool barraPesquisa = false;
  TextEditingController pesquisaController = TextEditingController();

  final separacaoController = Get.put(SeparacaoController());
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(const MinhasSeparacoesScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Atenção',
                content: const Text(
                  'Tem certeza que deseja sair?',
                ),
                onCancel: () {},
                textCancel: "Não",
                onConfirm: () {
                  Get.offAll(const MinhasSeparacoesScreen());
                },
                textConfirm: "Sim",
                confirmTextColor: Colors.white,
              );
            },
            color: Colors.black,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Produtos",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "PREOC:\t${widget.nrpreoc}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container()
            ],
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              height: 10.h,
              width: double.infinity,
              child: Obx(
                () {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "QTD:\t\t${separacaoController.produtos.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      Badge(
                        animationType: BadgeAnimationType.scale,
                        position: BadgePosition.topEnd(top: -5, end: -5),
                        badgeColor:
                            separacaoController.produtosSeparados.isNotEmpty
                                ? Colors.green
                                : Colors.red,
                        badgeContent: Text(
                          separacaoController.produtosSeparados.length
                              .toString(),
                        ),
                        // child: LottieBuilder.asset("assets/images/carrinho.json"),
                        child: IconButton(
                          color: Colors.black,
                          icon: Icon(
                            Entypo.shopping_bag,
                            size: 20.sp,
                          ),
                          onPressed: () async {
                            await Get.to(
                              ProdutosSeparadosScreen(
                                idsepconf: widget.idsepconf,
                                nrpreoc: widget.nrpreoc,
                                setor: widget.setor,
                                separacaoController: separacaoController,
                              ),
                              fullscreenDialog: true,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: separacaoController.buscarProdutos(
                  widget.idsepconf,
                  widget.nrpreoc,
                  widget.setor,
                ),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Carregando...',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );

                    case ConnectionState.done:
                      return Obx(
                        () => Scrollbar(
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: queryData.size.height * 0.4,
                                left: queryData.size.width * 0.5,
                                child: Image.asset(
                                  "assets/images/box.png",
                                  color: const Color.fromRGBO(196, 161, 109, 1)
                                      .withOpacity(0.4),
                                ),
                              ),
                              Positioned(
                                top: queryData.size.height * 0.4,
                                right: queryData.size.width * 0.5,
                                child: Image.asset(
                                  "assets/images/box2.png",
                                  color: const Color.fromRGBO(196, 161, 109, 1)
                                      .withOpacity(0.4),
                                ),
                              ),
                              ListView.separated(
                                separatorBuilder: (context, i) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      const Divider(
                                        thickness: 4,
                                        // indent: 10,
                                        color: Colors.white,
                                        height: 1,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  );
                                },
                                itemCount: separacaoController.produtos.length,
                                itemBuilder: (context, i) {
                                  ProdutoHelper produtoHelper =
                                      separacaoController.produtos[i];
                                  return CardProdutoSeparador(
                                    produtoHelper: produtoHelper,
                                    separacaoController: separacaoController,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );

                    case ConnectionState.none:
                      break;
                    case ConnectionState.active:
                      break;
                  }
                  return const Center(
                    child: Text("Unknown Error"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
