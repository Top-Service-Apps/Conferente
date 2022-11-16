import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/separacao_controller.dart';
import 'package:teste_tela/utils/produto_helper.dart';

class SeparacaoProdutoScreen extends StatefulWidget {
  final ProdutoHelper produtoHelper;
  final SeparacaoController separacaoController;
  const SeparacaoProdutoScreen({
    Key? key,
    required this.produtoHelper,
    required this.separacaoController,
  }) : super(key: key);

  bool get disableKeyboard => true;

  @override
  _SeparacaoProdutoScreenState createState() => _SeparacaoProdutoScreenState();
}

class _SeparacaoProdutoScreenState extends State<SeparacaoProdutoScreen> {
  final FocusNode _myFocusNode = FocusNode();

  final TextEditingController _codbarrasController = TextEditingController();

  final _qtdController = TextEditingController();
  final AudioCache audioCache = AudioCache();

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

  @override
  void initState() {
    widget.separacaoController.iniciar(widget.produtoHelper);

    _qtdController.text = widget.separacaoController.qtdNegociada.toString();
    _codbarrasController.text = "";
    super.initState();
  }

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
          title: Text(
            "Separando",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Atenção",
                  content: const Text(
                    "Trocar unidade de venda?",
                  ),
                  onCancel: () {},
                  textCancel: "Não",
                  confirmTextColor: Colors.white,
                  textConfirm: "Sim",
                  onConfirm: () async {
                    _qtdController.text = widget.separacaoController
                        .trocarUnidadeVenda(widget.produtoHelper);

                    Get.back();
                    Get.defaultDialog(
                      title: "Sucesso",
                      content: const Text("Unidade de venda alterada!"),
                      onCancel: () {},
                      textCancel: "OK",
                    );
                  },
                );
              },
              icon: Icon(
                Feather.repeat,
                color: Colors.black,
                size: 16.sp,
              ),
            ),
          ],
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
                        widget.produtoHelper.descrprod ?? "",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  widget.produtoHelper.controle != null ||
                          widget.produtoHelper.controle != " "
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
                    height: 2.h,
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
                    height: 2.h,
                  ),
                  Obx(() {
                    return Text(
                      "EAN:\t\t${widget.separacaoController.codigoBarras.value}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    );
                  }),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Obx(() {
                          return Text(
                            "EMB:\t\t${widget.separacaoController.embalagem.value}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          );
                        }),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          onFieldSubmitted: (value) {
                            _myFocusNode.requestFocus();
                          },
                          keyboardType: TextInputType.number,
                          controller: _qtdController,
                          decoration: const InputDecoration(
                            prefixStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixText: "QTD. ITENS:\t\t",
                            hintText: "Digite a quantidade",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextField(
                    autofocus: true,
                    controller: _codbarrasController,
                    keyboardType: TextInputType.number,
                    focusNode: _myFocusNode,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        if (widget.separacaoController.unidadeVenda.isTrue) {}
                        if (value.substring(value.length - 6) ==
                                widget.separacaoController.codigoBarras
                                    .substring(widget.separacaoController
                                            .codigoBarras.value.length -
                                        6) &&
                            int.parse(_qtdController.text) ==
                                widget.separacaoController.qtdNegociada.value) {
                          audioCache.play('musics/sucesso.mp3').then(
                                (value) => widget.separacaoController
                                    .separarProduto(
                                      "S",
                                      int.parse(_qtdController.text),
                                      widget.produtoHelper,
                                    )
                                    .then(
                                      (value) => Get.back(),
                                    ),
                              );
                        } else if (value.substring(value.length - 6) ==
                                widget.separacaoController.codigoBarras
                                    .substring(widget.separacaoController
                                            .codigoBarras.value.length -
                                        6) &&
                            int.parse(_qtdController.text) !=
                                widget.separacaoController.qtdNegociada.value) {
                          Get.defaultDialog(
                            title: "Atenção",
                            content: Column(
                              children: [
                                const Text("Quantidades divergentes"),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                    "QTDNEG:\t\t${widget.separacaoController.qtdNegociada}"),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text("QTDSEP:\t\t${_qtdController.text}"),
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
                                    (value) => widget.separacaoController
                                        .separarProduto(
                                          "C",
                                          int.parse(_qtdController.text),
                                          widget.produtoHelper,
                                        )
                                        .then(
                                          (value) => {Get.back(), Get.back()},
                                        ),
                                  );
                            },
                          );
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
                    decoration: const InputDecoration(
                      labelText: "Cód. barras",
                      hintText: "Código de barras",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_codbarrasController.text.isNotEmpty) {
                              if (_codbarrasController.text.substring(
                                          _codbarrasController.text.length -
                                              6) ==
                                      widget.separacaoController.codigoBarras
                                          .substring(widget.separacaoController
                                                  .codigoBarras.value.length -
                                              6) &&
                                  int.parse(_qtdController.text) ==
                                      widget.separacaoController.qtdNegociada
                                          .value) {
                                audioCache.play('musics/sucesso.mp3').then(
                                      (value) => widget.separacaoController
                                          .separarProduto(
                                            "S",
                                            int.parse(_qtdController.text),
                                            widget.produtoHelper,
                                          )
                                          .then(
                                            (value) => Get.back(),
                                          ),
                                    );
                              } else if (_codbarrasController.text.substring(
                                          _codbarrasController.text.length -
                                              6) ==
                                      widget.separacaoController.codigoBarras
                                          .substring(widget.separacaoController
                                                  .codigoBarras.value.length -
                                              6) &&
                                  int.parse(_qtdController.text) !=
                                      widget.separacaoController.qtdNegociada
                                          .value) {
                                Get.defaultDialog(
                                  title: "Atenção",
                                  content: Column(
                                    children: [
                                      const Text("Quantidades divergentes"),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                          "QTDNEG:\t\t${widget.separacaoController.qtdNegociada}"),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text("QTDSEP:\t\t${_qtdController.text}"),
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
                                          (value) => widget.separacaoController
                                              .separarProduto(
                                                "C",
                                                int.parse(_qtdController.text),
                                                widget.produtoHelper,
                                              )
                                              .then(
                                                (value) =>
                                                    {Get.back(), Get.back()},
                                              ),
                                        );
                                  },
                                );
                              } else {
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
                              }
                            } else {
                              return;
                            }
                          },
                          icon: Icon(
                            Feather.check_circle,
                            color: Colors.green,
                            size: 20.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await widget.separacaoController.validarProduto(
                              widget.produtoHelper,
                              int.parse(_qtdController.text),
                              _myFocusNode,
                            );
                          },
                          icon: Icon(
                            Feather.camera,
                            size: 20.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
