
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/apis/separa_api.dart';
import 'package:teste_tela/controllers/conferencia_controller.dart';
import 'package:teste_tela/screens/home/conferente/home_screen.dart';
import 'package:teste_tela/utils/produto_helper.dart';

import 'components/card_produto_conferido.dart';

class ProdutosConferidosScreen extends StatefulWidget {
  final int idsepconf;
  final int nrpreoc;
  final String setor;
  final ConferenciaController conferenciaController;
  const ProdutosConferidosScreen({
    Key? key,
    required this.idsepconf,
    required this.nrpreoc,
    required this.setor,
    required this.conferenciaController,
  }) : super(key: key);

  @override
  _ProdutosConferidosScreenState createState() =>
      _ProdutosConferidosScreenState();
}

class _ProdutosConferidosScreenState extends State<ProdutosConferidosScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Feather.x,
              color: Colors.black,
              // size: 18.sp,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Carrinho",
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
                        "QTD:\t${widget.conferenciaController.produtosConferidos.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                        width: 25.w,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          child: Text(
                            "Finalizar",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                          onPressed: () async {
                            Get.defaultDialog(
                              title: "Finalizar conferência?",
                              content: Column(
                                children: [
                                  Text(
                                    "A conferência será finalizada",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Retorne ao menu principal",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  )
                                ],
                              ),
                              onCancel: () {},
                              textCancel: "Não",
                              textConfirm: "Sim",
                              confirmTextColor: Colors.white,
                              onConfirm: () async {
                                if (widget.conferenciaController.produtos
                                    .isNotEmpty) {
                                  Get.defaultDialog(
                                    title: "Atenção",
                                    content: Column(
                                      children: [
                                        const Text(
                                          "Você possui produtos pendentes!",
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        const Text(
                                          "Deseja continuar a finalização?",
                                        ),
                                      ],
                                    ),
                                    textCancel: "Não",
                                    onCancel: () {},
                                    textConfirm: "Sim",
                                    onConfirm: () async {
                                      for (ProdutoHelper produto in widget
                                          .conferenciaController
                                          .produtosConferidos) {
                                        await SeparaApi.finalizarConferencia(
                                          id: produto.id!,
                                          conferido: "S",
                                          qtdconf: produto.qtdconf!,
                                        );
                                      }
                                      for (ProdutoHelper produto in widget
                                          .conferenciaController.produtos) {
                                        await SeparaApi.finalizarConferencia(
                                          id: produto.id!,
                                          conferido: "C",
                                          qtdconf: 0,
                                        );
                                      }
                                      Get.defaultDialog(
                                        barrierDismissible: false,
                                        title:
                                            "Conferência finalizada com sucesso!",
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Lottie.asset(
                                              'assets/images/sucesso.json',
                                              width: 140,
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "PRÉ-ORDEM:\t\t${widget.nrpreoc}",
                                              style: TextStyle(
                                                fontSize: 12.0.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              "SETOR:\t\t${widget.setor}",
                                              style: TextStyle(
                                                fontSize: 12.0.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textConfirm: "Ok",
                                        confirmTextColor: Colors.white,
                                        onConfirm: () {
                                          Get.offAll(
                                            const HomeConferenteScreen(),
                                          );
                                        },
                                      );
                                    },
                                    confirmTextColor: Colors.white,
                                  );
                                } else {
                                  for (ProdutoHelper produto in widget
                                      .conferenciaController
                                      .produtosConferidos) {
                                    await SeparaApi.finalizarConferencia(
                                      id: produto.id!,
                                      conferido: "S",
                                      qtdconf: produto.qtdconf!,
                                    );
                                  }
                                  Get.defaultDialog(
                                    barrierDismissible: false,
                                    title:
                                        "Conferência finalizada com sucesso!",
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Lottie.asset(
                                          'assets/images/sucesso.json',
                                          width: 140,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          "PRÉ-ORDEM:\t\t${widget.nrpreoc}",
                                          style: TextStyle(
                                            fontSize: 12.0.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          "SETOR:\t\t${widget.setor}",
                                          style: TextStyle(
                                            fontSize: 12.0.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textConfirm: "Ok",
                                    confirmTextColor: Colors.white,
                                    onConfirm: () {
                                      Get.offAll(
                                        const HomeConferenteScreen(),
                                      );
                                    },
                                  );
                                }
                              },
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
              child: Obx(
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
                    itemCount:
                        widget.conferenciaController.produtosConferidos.length,
                    itemBuilder: (context, i) {
                      ProdutoHelper produtoHelper =
                          widget.conferenciaController.produtosConferidos[i];
                      return CardProdutoConferido(
                        produtoHelper: produtoHelper,
                        conferenciaController: widget.conferenciaController,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
