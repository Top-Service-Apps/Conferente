import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/separador/loading_separador_controller.dart';
import 'package:teste_tela/screens/grupos/separador/grupo_screen.dart';
import 'package:teste_tela/screens/home/telas.dart';
import 'package:teste_tela/screens/minhas_separacoes_conferencias/separador/minhas_separacoes_screen.dart';
import 'package:teste_tela/screens/reconferencias/reconferencias_screen.dart';
import '../home_screen.dart';

// ignore: must_be_immutable
class CardHomeSeparador extends StatefulWidget {
  final String nome;
  final String imagem;
  final Tela tela;
  final LoadingSeparadorController? controller;

  const CardHomeSeparador({
    Key? key,
    required this.nome,
    required this.imagem,
    required this.tela,
    this.controller,
  }) : super(key: key);

  @override
  State<CardHomeSeparador> createState() => _CardHomeSeparadorState();
}

class _CardHomeSeparadorState extends State<CardHomeSeparador> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.tela == Tela.minhaseparacoes) {
          Get.offAll(
            const MinhasSeparacoesScreen(),
          );
        } else if (widget.tela == Tela.meugrupo) {
          Get.offAll(
            const GrupoSeparadorScreen(),
          );
        } else if (widget.tela == Tela.reconferencias) {
          Get.offAll(
            const ReconferenciasSeparadorScreen(),
          );
        } else {
          Get.offAll(
            const HomeSeparadorScreen(),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          border: Border.all(width: 3, color: Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage(
              widget.imagem,
            ),
            opacity: 90,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.nome,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            widget.tela == Tela.minhaseparacoes
                ? Obx(() {
                    return Text(
                      "QTD:\t${widget.controller!.qtdMinhasSeparacoes}",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  })
                : widget.tela == Tela.meugrupo
                    ? Obx(() {
                        return Text(
                          "QTD:\t${widget.controller!.qtdMeuGrupo}",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      })
                    : widget.tela == Tela.reconferencias
                        ? Obx(() {
                            return Text(
                              "QTD:\t${widget.controller!.qtdReconferencias}",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          })
                        : Container(),
          ],
        ),
      ),
    );
  }
}
