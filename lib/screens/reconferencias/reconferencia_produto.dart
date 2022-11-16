
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/reconferencia_controller.dart';
import 'package:teste_tela/models/cortesepara.dart';

class ReconfereciaProdutoScreen extends StatefulWidget {
  final CorteSepara corteSepara;
  final ReconferenciaController reconferenciaController;

  const ReconfereciaProdutoScreen(
      {Key? key,
      required this.corteSepara,
      required this.reconferenciaController})
      : super(key: key);

  bool get disableKeyboard => true;

  @override
  _ReconfereciaProdutoScreenState createState() =>
      _ReconfereciaProdutoScreenState();
}

class _ReconfereciaProdutoScreenState extends State<ReconfereciaProdutoScreen> {
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
    widget.reconferenciaController.iniciar(widget.corteSepara);

    _qtdController.text = widget.reconferenciaController.qtdCorte.toString();
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
            "QTD:\t\t${widget.corteSepara.qtdcorte}",
            style: const TextStyle(
              color: Colors.black,
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
                    // _qtdController.text = widget.separacaoController
                    //     .trocarUnidadeVenda(widget.produtoHelper);

                    // Get.back();
                    // Get.defaultDialog(
                    //   title: "Sucesso",
                    //   content: Text("Unidade de venda alterada!"),
                    //   onCancel: () {},
                    //   textCancel: "OK",
                    // );
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
                        widget.corteSepara.descrprod ?? "",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  widget.corteSepara.controle != null
                      ? Column(
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              "CONTROLE:\t\t${widget.corteSepara.controle}",
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
                    "CODFORN:\t\t${widget.corteSepara.codprodforn}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Obx(() {
                    return Text(
                      "EAN:\t\t${widget.reconferenciaController.codigoBarras}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    );
                  }),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    "EMB:\t\t${widget.reconferenciaController.embalagem}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  TextField(
                    autofocus: true,
                    controller: _codbarrasController,
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
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    onFieldSubmitted: (value) {
                      _myFocusNode.requestFocus();
                    },
                    keyboardType: TextInputType.number,
                    controller: _qtdController,
                    decoration: const InputDecoration(
                      // prefixText: "Qtd. Itens:\t\t",
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Feather.check_circle,
                            color: Colors.green,
                            size: 20.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {},
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
