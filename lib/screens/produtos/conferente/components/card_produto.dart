
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/conferencia_controller.dart';
import 'package:teste_tela/screens/produtos/conferente/conferencia_produto.dart';
import 'package:teste_tela/utils/produto_helper.dart';

class CardProdutoConferente extends StatefulWidget {
  final ProdutoHelper produtoHelper;
  final ConferenciaController conferenciaController;

  const CardProdutoConferente({
    Key? key,
    required this.produtoHelper,
    required this.conferenciaController,
  }) : super(key: key);

  @override
  _CardProdutoConferenteState createState() => _CardProdutoConferenteState();
}

class _CardProdutoConferenteState extends State<CardProdutoConferente> {
  final conferenciaController = Get.put(ConferenciaController());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(ConferenciaProdutoScreen(
          produtoHelper: widget.produtoHelper,
          conferenciaController: widget.conferenciaController,
        ));
      },
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
                "CONTROLE:\t",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.produtoHelper.controle ?? "SEM CONTROLE",
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
                "CODFORN:\t",
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
                    "EAN:\t",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.produtoHelper.codbarras ?? "",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "EMB:\t",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.produtoHelper.embalagem ?? "",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
