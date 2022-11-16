import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/conferencia_controller.dart';
import 'package:teste_tela/screens/minhas_separacoes_conferencias/conferente/minhas_conferencias_screen.dart';
import 'package:teste_tela/screens/produtos/conferente/produtos_conferidos_screen.dart';
import 'package:teste_tela/utils/produto_helper.dart';

import 'components/card_produto.dart';

class ProdutosConferenteScreen extends StatefulWidget {
  final int idsepconf;
  final int nrpreoc;
  final String setor;

  const ProdutosConferenteScreen({
    Key? key,
    required this.idsepconf,
    required this.nrpreoc,
    required this.setor,
  }) : super(key: key);

  @override
  _ProdutosConferenteScreenState createState() =>
      _ProdutosConferenteScreenState();
}

class _ProdutosConferenteScreenState extends State<ProdutosConferenteScreen> {
  final conferenciaController = Get.put(ConferenciaController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.offAll(const ConferenciasScreen());
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
                  Get.offAll(const ConferenciasScreen());
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
                        "QTD:\t\t${conferenciaController.produtos.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      Badge(
                        position: BadgePosition.topEnd(top: -5, end: -5),
                        animationType: BadgeAnimationType.scale,
                        badgeColor:
                            conferenciaController.produtosConferidos.isNotEmpty
                                ? Colors.green
                                : Colors.red,
                        badgeContent: Text(
                          conferenciaController.produtosConferidos.length
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
                              ProdutosConferidosScreen(
                                idsepconf: widget.idsepconf,
                                nrpreoc: widget.nrpreoc,
                                setor: widget.setor,
                                conferenciaController: conferenciaController,
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
                future: conferenciaController.buscarProdutos(
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
                          child: ListView.separated(
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
                            itemCount: conferenciaController.produtos.length,
                            itemBuilder: (context, i) {
                              ProdutoHelper produtoHelper =
                                  conferenciaController.produtos[i];
                              return CardProdutoConferente(
                                produtoHelper: produtoHelper,
                                conferenciaController: conferenciaController,
                              );
                            },
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
