import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/separacao_controller.dart';
import 'package:teste_tela/screens/produtos/separador/separacao_produto.dart';
import 'package:teste_tela/utils/produto_helper.dart';

class CardProdutoSeparador extends StatefulWidget {
  final ProdutoHelper produtoHelper;
  final SeparacaoController separacaoController;

  const CardProdutoSeparador({
    Key? key,
    required this.produtoHelper,
    required this.separacaoController,
  }) : super(key: key);

  @override
  _CardProdutoSeparadorState createState() => _CardProdutoSeparadorState();
}

class _CardProdutoSeparadorState extends State<CardProdutoSeparador> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // dialogNegociada();

        Get.to(
          SeparacaoProdutoScreen(
            produtoHelper: widget.produtoHelper,
            separacaoController: widget.separacaoController,
          ),
        );
      },
      onLongPress: () {
        // dialogUnidade();
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
          widget.produtoHelper.controle == null ||
                  widget.produtoHelper.controle == " "
              ? Container()
              : Row(
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
                      widget.produtoHelper.controle!,
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
                      fontSize: 10.sp,
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
                      fontSize: 10.sp,
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
              //  Container(
              //    padding: const EdgeInsets.all(5),
              //    decoration: BoxDecoration(
              //      borderRadius: BorderRadius.circular(5),
              //      color: Colors.yellow,
              //    ),
              //    child: Row(
              //      children: [
              //        Text(
              //          "QTD.NEG:\t",
              //          style: TextStyle(
              //            fontSize: 10.sp,
              //            color: Colors.black,
              //            fontWeight: FontWeight.bold,
              //          ),
              //        ),
              //        Text(
              //          "${widget.produtoHelper.qtdneg ?? "0"}",
              //          style: TextStyle(
              //            fontSize: 12.sp,
              //            color: Colors.black,
              //            fontWeight: FontWeight.bold,
              //          ),
              //        ),
              //      ],
              //    ),
              //  ),
            ],
          ),
        ],
      ),
    );
  }
}
