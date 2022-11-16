import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/reconferencia_controller.dart';
import 'package:teste_tela/models/cortesepara.dart';

import '../reconferencia_produto.dart';

class CardReconferenciaSeparador extends StatefulWidget {
  final CorteSepara corteSepara;
  const CardReconferenciaSeparador({Key? key, required this.corteSepara})
      : super(key: key);

  @override
  _CardReconferenciaSeparadorState createState() =>
      _CardReconferenciaSeparadorState();
}

class _CardReconferenciaSeparadorState
    extends State<CardReconferenciaSeparador> {
  final reconferenciaController = Get.put(ReconferenciaController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Get.to(
              ReconfereciaProdutoScreen(
                corteSepara: widget.corteSepara,
                reconferenciaController: reconferenciaController,
              ),
            );
          },
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "${widget.corteSepara.codprod ?? "000"} - " +
                  widget.corteSepara.descrprod!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.corteSepara.controle == null ||
                      widget.corteSepara.controle! == " " ||
                      widget.corteSepara.controle!.isEmpty
                  ? Container()
                  : Row(
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
                          widget.corteSepara.controle ?? "SEM CONTROLE",
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
                    widget.corteSepara.codprodforn ?? "000",
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
                          fontSize: 11.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.corteSepara.codbarras ?? "",
                        style: TextStyle(
                          fontSize: 11.sp,
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
                          fontSize: 11.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.corteSepara.embalagem ?? "",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "QTD: ",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${widget.corteSepara.qtdcorte ?? "0"}",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              const Divider(
                thickness: 2,
                // indent: 10,
                color: Colors.white,
                height: 1,
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
