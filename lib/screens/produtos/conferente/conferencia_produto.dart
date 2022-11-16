import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/conferencia_controller.dart';
import 'package:teste_tela/utils/produto_helper.dart';

class ConferenciaProdutoScreen extends StatefulWidget {
  final ProdutoHelper produtoHelper;
  final ConferenciaController conferenciaController;
  const ConferenciaProdutoScreen({
    Key? key,
    required this.produtoHelper,
    required this.conferenciaController,
  }) : super(key: key);

  @override
  _ConferenciaProdutoScreenState createState() =>
      _ConferenciaProdutoScreenState();
}

class _ConferenciaProdutoScreenState extends State<ConferenciaProdutoScreen> {
  final FocusNode _myFocusNode = FocusNode();

  final FocusNode _myFocusNode2 = FocusNode();

  final _codbarrasController = TextEditingController();

  final _qtdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AudioCache audioCache = AudioCache();

  Future<String> camera() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (barcodeScanRes == "-1") {
      return "";
    } else {
      return barcodeScanRes;
    }
  }

  @override
  Widget build(BuildContext context) {
    _qtdController.text = "";
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        // return true;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                _codbarrasController.text = await camera();
                if (_codbarrasController.text
                            .substring(_codbarrasController.text.length - 6) ==
                        widget.produtoHelper.codbarras!.substring(
                            widget.produtoHelper.codbarras!.length - 6) ||
                    _codbarrasController.text
                            .substring(_codbarrasController.text.length - 6) ==
                        widget.produtoHelper.codbarraund!.substring(
                            widget.produtoHelper.codbarraund!.length - 6)) {
                  _myFocusNode2.requestFocus();
                } else {
                  _codbarrasController.text = "";
                  _myFocusNode.requestFocus();
                  audioCache.play('musics/error.mp3').then(
                        (value) => Get.defaultDialog(
                          title: "Erro",
                          content: const Text("Código de barras inválido"),
                          onCancel: () {},
                          textCancel: "Voltar",
                        ),
                      );
                }
              },
              icon: Icon(
                Feather.camera,
                size: 16.sp,
                color: Colors.black,
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Feather.x,
              color: Colors.black,
              size: 16.sp,
            ),
          ),
          title: const Text(
            "Conferência",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            _myFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          widget.produtoHelper.descrprod!,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    widget.produtoHelper.controle != null
                        ? Column(
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                "CONTROLE:\t\t${widget.produtoHelper.controle}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "CODPROD:\t\t${widget.produtoHelper.codprod}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "CODFORN:\t\t${widget.produtoHelper.codprodforn}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "EAN:\t\t${widget.produtoHelper.codbarras}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "EMB:\t\t${widget.produtoHelper.embalagem}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite ou insira o código de barras";
                        }
                        return null;
                      },
                      autofocus: true,
                      controller: _codbarrasController,
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          if (_codbarrasController.text.substring(7) ==
                                  widget.produtoHelper.codbarras!
                                      .substring(7) ||
                              _codbarrasController.text.substring(7) ==
                                  widget.produtoHelper.codbarraund!
                                      .substring(7)) {
                            _myFocusNode.unfocus();
                            _myFocusNode2.requestFocus();
                          } else {
                            _codbarrasController.text = "";
                            _myFocusNode.requestFocus();
                            audioCache.play('musics/error.mp3').then(
                                  (value) => Get.defaultDialog(
                                    title: "Erro",
                                    content:
                                        const Text("Código de barras inválido"),
                                    onCancel: () {},
                                    textCancel: "Voltar",
                                  ),
                                );
                          }
                        } else {
                          return;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _myFocusNode,
                      decoration: const InputDecoration(
                        labelText: "Cód. barras",
                        hintText: "Código de barras",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      // autofocus: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite a quantidade";
                        }
                        return null;
                      },
                      controller: _qtdController,
                      focusNode: _myFocusNode2,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) async {
                        if (_formKey.currentState!.validate()) {
                          if (value.isNotEmpty) {
                            if ((_codbarrasController.text.substring(_codbarrasController.text.length - 6) ==
                                        widget.produtoHelper.codbarras!.substring(
                                            widget.produtoHelper.codbarras!.length -
                                                6) &&
                                    _qtdController.text ==
                                        widget.produtoHelper.qtdneg
                                            .toString()) ||
                                (_codbarrasController.text.substring(
                                            _codbarrasController.text.length -
                                                6) ==
                                        widget.produtoHelper.codbarraund!.substring(
                                            widget.produtoHelper.codbarraund!.length -
                                                6) &&
                                    _qtdController.text ==
                                        widget.produtoHelper.qtdnegund.toString())) {
                              audioCache.play('musics/sucesso.mp3').then(
                                    (value) => widget.conferenciaController
                                        .conferirProduto(
                                            "S",
                                            int.parse(_qtdController.text),
                                            widget.produtoHelper)
                                        .then(
                                          (value) => {Get.back()},
                                        ),
                                  );
                            } else if ((_codbarrasController.text.substring(_codbarrasController.text.length - 6) ==
                                        widget.produtoHelper.codbarras!
                                            .substring(widget.produtoHelper
                                                    .codbarras!.length -
                                                6) &&
                                    int.parse(_qtdController.text) <
                                        widget.produtoHelper.qtdneg!) ||
                                (_codbarrasController.text.substring(_codbarrasController.text.length - 6) ==
                                        widget.produtoHelper.codbarraund!
                                            .substring(widget.produtoHelper
                                                    .codbarraund!.length -
                                                6) &&
                                    int.parse(_qtdController.text) <
                                        widget.produtoHelper.qtdneg!)) {
                              Get.defaultDialog(
                                title: "Atenção",
                                content: Column(
                                  children: [
                                    const Text("Quantidades divergentes"),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDNEG:\t\t${widget.produtoHelper.qtdneg}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDCONF:\t\t${_qtdController.text}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const Text("Deseja continuar?"),
                                  ],
                                ),
                                textCancel: "Não",
                                onCancel: () {
                                  _myFocusNode2.requestFocus();
                                },
                                textConfirm: "Sim",
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  audioCache.play('musics/sucesso.mp3').then(
                                        (value) => widget.conferenciaController
                                            .conferirProduto(
                                                "S",
                                                int.parse(_qtdController.text),
                                                widget.produtoHelper)
                                            .then(
                                              (value) =>
                                                  {Get.back(), Get.back()},
                                            ),
                                      );
                                },
                              );
                            } else if ((_codbarrasController.text.substring(_codbarrasController.text.length - 6) ==
                                        widget.produtoHelper.codbarras!
                                            .substring(widget.produtoHelper
                                                    .codbarras!.length -
                                                6) &&
                                    int.parse(_qtdController.text) >
                                        widget.produtoHelper.qtdneg!) ||
                                (_codbarrasController.text.substring(_codbarrasController.text.length - 6) ==
                                        widget.produtoHelper.codbarraund!
                                            .substring(widget.produtoHelper
                                                    .codbarraund!.length -
                                                6) &&
                                    int.parse(_qtdController.text) >
                                        widget.produtoHelper.qtdneg!)) {
                              _myFocusNode2.requestFocus();
                              Get.defaultDialog(
                                title: "Atenção",
                                content: Column(
                                  children: [
                                    const Text("Acrescimo na conferência"),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDNEG:\t\t${widget.produtoHelper.qtdneg}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDCONF:\t\t${_qtdController.text}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 2.h,
                                    // ),
                                    // Text("Deseja continuar?"),
                                  ],
                                ),
                                textCancel: "Voltar",
                                onCancel: () {},
                              );
                            } else if (_codbarrasController.text !=
                                    widget.produtoHelper.codbarras ||
                                _codbarrasController.text !=
                                    widget.produtoHelper.codbarraund) {
                              _codbarrasController.text = "";
                              _myFocusNode.requestFocus();
                              audioCache.play('musics/error.mp3').then(
                                    (value) => Get.defaultDialog(
                                      title: "Erro",
                                      content: const Text(
                                          "Código de barras inválido"),
                                      onCancel: () {},
                                      textCancel: "Voltar",
                                    ),
                                  );
                              Get.defaultDialog(
                                title: "Atenção",
                                content: Column(
                                  children: [
                                    const Text("Acrescimo de conferência"),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDNEG:\t\t${widget.produtoHelper.qtdneg}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDCONF:\t\t${_qtdController.text}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 2.h,
                                    // ),
                                    // Text("Deseja continuar?"),
                                  ],
                                ),
                                textCancel: "Não",
                                onCancel: () {},
                              );
                            }
                          }
                        } else {
                          if (_codbarrasController.text.isEmpty) {
                            _myFocusNode.requestFocus();
                          } else {
                            _myFocusNode2.requestFocus();
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Qtd. Itens",
                        hintText: "Digite a quantidade",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: IconButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if ((_codbarrasController.text.substring(
                                            _codbarrasController.text.length -
                                                6) ==
                                        widget.produtoHelper.codbarras!
                                            .substring(widget.produtoHelper
                                                    .codbarras!.length -
                                                6) &&
                                    _qtdController.text ==
                                        widget.produtoHelper.qtdneg
                                            .toString()) ||
                                (_codbarrasController.text.substring(7) ==
                                        widget.produtoHelper.codbarraund!
                                            .substring(7) &&
                                    _qtdController.text ==
                                        widget.produtoHelper.qtdnegund
                                            .toString())) {
                              audioCache.play('musics/sucesso.mp3').then(
                                    (value) => widget.conferenciaController
                                        .conferirProduto(
                                            "S",
                                            int.parse(_qtdController.text),
                                            widget.produtoHelper)
                                        .then(
                                          (value) => {Get.back()},
                                        ),
                                  );
                            } else if ((_codbarrasController.text
                                            .substring(7) ==
                                        widget.produtoHelper.codbarras!
                                            .substring(7) &&
                                    int.parse(_qtdController.text) <
                                        widget.produtoHelper.qtdneg!) ||
                                (_codbarrasController.text.substring(7) ==
                                        widget.produtoHelper.codbarraund!
                                            .substring(7) &&
                                    int.parse(_qtdController.text) <
                                        widget.produtoHelper.qtdneg!)) {
                              Get.defaultDialog(
                                title: "Atenção",
                                content: Column(
                                  children: [
                                    const Text("Quantidades divergentes"),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDNEG:\t\t${widget.produtoHelper.qtdneg}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDCONF:\t\t${_qtdController.text}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const Text("Deseja continuar?"),
                                  ],
                                ),
                                textCancel: "Não",
                                onCancel: () {
                                  _myFocusNode2.requestFocus();
                                },
                                textConfirm: "Sim",
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  audioCache.play('musics/sucesso.mp3').then(
                                        (value) => widget.conferenciaController
                                            .conferirProduto(
                                                "S",
                                                int.parse(_qtdController.text),
                                                widget.produtoHelper)
                                            .then(
                                              (value) =>
                                                  {Get.back(), Get.back()},
                                            ),
                                      );
                                },
                              );
                            } else if ((_codbarrasController.text
                                            .substring(7) ==
                                        widget.produtoHelper.codbarras!
                                            .substring(7) &&
                                    int.parse(_qtdController.text) >
                                        widget.produtoHelper.qtdneg!) ||
                                (_codbarrasController.text.substring(7) ==
                                        widget.produtoHelper.codbarraund!
                                            .substring(7) &&
                                    int.parse(_qtdController.text) >
                                        widget.produtoHelper.qtdneg!)) {
                              _myFocusNode2.requestFocus();
                              Get.defaultDialog(
                                title: "Atenção",
                                content: Column(
                                  children: [
                                    const Text("Acrescimo na conferência"),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDNEG:\t\t${widget.produtoHelper.qtdneg}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDCONF:\t\t${_qtdController.text}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                textCancel: "Voltar",
                                onCancel: () {},
                              );
                            } else if (_codbarrasController.text !=
                                    widget.produtoHelper.codbarras ||
                                _codbarrasController.text !=
                                    widget.produtoHelper.codbarraund) {
                              _codbarrasController.text = "";
                              _myFocusNode.requestFocus();
                              audioCache.play('musics/error.mp3').then(
                                    (value) => Get.defaultDialog(
                                      title: "Erro",
                                      content: const Text(
                                          "Código de barras inválido"),
                                      onCancel: () {},
                                      textCancel: "Voltar",
                                    ),
                                  );
                              Get.defaultDialog(
                                title: "Atenção",
                                content: Column(
                                  children: [
                                    const Text("Acrescimo de conferência"),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDNEG:\t\t${widget.produtoHelper.qtdneg}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "QTDCONF:\t\t${_qtdController.text}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 2.h,
                                    // ),
                                    // Text("Deseja continuar?"),
                                  ],
                                ),
                                textCancel: "Não",
                                onCancel: () {},
                                // textConfirm: "Sim",
                                // confirmTextColor: Colors.white,
                                // onConfirm: () {
                                //   audioCache.play('musics/sucesso.mp3').then(
                                //         (value) => conferenciaStore
                                //             .conferirProduto(
                                //                 "S",
                                //                 int.parse(_qtdController.text),
                                //                 widget.produtoHelper)
                                //             .then(
                                //               (value) => {Get.back(), Get.back()},
                                //             ),
                                //       );
                                // },
                              );
                            }
                          } else {
                            if (_codbarrasController.text.isEmpty) {
                              _myFocusNode.requestFocus();
                            } else {
                              _myFocusNode2.requestFocus();
                            }
                          }
                        },
                        icon: Icon(
                          Feather.check_circle,
                          color: Colors.green,
                          size: 20.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
