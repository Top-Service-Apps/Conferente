
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/conferencia_controller.dart';
import 'package:teste_tela/utils/produto_helper.dart';

class CardProdutoConferido extends StatefulWidget {
  final ProdutoHelper produtoHelper;
  final ConferenciaController conferenciaController;

  const CardProdutoConferido({
    Key? key,
    required this.produtoHelper,
    required this.conferenciaController,
  }) : super(key: key);

  @override
  _CardProdutoConferidoState createState() => _CardProdutoConferidoState();
}

class _CardProdutoConferidoState extends State<CardProdutoConferido> {
  final AudioCache audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.cancel,
          color: Colors.white,
        ),
      ),
      key: ValueKey<int>(widget.produtoHelper.id!),
      onDismissed: (DismissDirection direction) async {
        await widget.conferenciaController
            .removerProduto(
              widget.produtoHelper,
            )
            .then(
              (value) => audioCache.play('musics/remover.mp3').then(
                    (value) => {Get.back()},
                  ),
            );
      },
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "${widget.produtoHelper.codprod ?? "000"} - " +
                    widget.produtoHelper.descrprod!,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "CONTROLE: ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.produtoHelper.controle ?? "",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "CODFORN: ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.produtoHelper.codprodforn ?? "000",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "EAN: ",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.produtoHelper.codbarras ?? "",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "EMB: ",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.produtoHelper.embalagem ?? "",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "QTD.NEG: ",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${widget.produtoHelper.qtdneg ?? "0"}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    widget.produtoHelper.qtdneg! ==
                                widget.produtoHelper.qtdconf! ||
                            widget.produtoHelper.qtdconf! ==
                                widget.produtoHelper.qtdnegund!
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                const Text(
                                  "Conferido",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : widget.produtoHelper.qtdneg! >
                                    widget.produtoHelper.qtdconf! ||
                                widget.produtoHelper.qtdnegund! >
                                    widget.produtoHelper.qtdconf!
                            ? Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    const Text(
                                      "Falta / Corte",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    const Text(
                                      "Acrescimo",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "QTD. CONFERIDA:\t\t\t${widget.produtoHelper.qtdconf ?? ""}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
