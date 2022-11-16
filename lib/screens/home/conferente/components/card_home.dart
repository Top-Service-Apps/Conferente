import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/conferente/loading_conferente_controller.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/screens/entrada/entrada.dart';
import 'package:teste_tela/screens/grupos/conferente/grupos_screen.dart';
import 'package:teste_tela/screens/minhas_separacoes_conferencias/conferente/minhas_conferencias_screen.dart';

// ignore: must_be_immutable
class CardHomeConferente extends StatefulWidget {
  final String nome;
  final String image;
  final LoginController loginController;
  final LoadingConferenteController loadingConferenteController;
  final int tela;

  const CardHomeConferente({
    Key? key,
    required this.nome,
    required this.image,
    required this.loginController,
    required this.loadingConferenteController,
    required this.tela,
  }) : super(key: key);

  @override
  State<CardHomeConferente> createState() => _CardHomeConferenteState();
}

class _CardHomeConferenteState extends State<CardHomeConferente> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.tela == 1) {
          Get.offAll(
            const GruposConferenteScreen(
              status: "D",
            ),
          );
        } else if (widget.tela == 2) {
          Get.offAll(
            const GruposConferenteScreen(
              status: "E",
            ),
          );
        } else if (widget.tela == 3) {
          // Get.offAll(
          //   PreordensLiberadasConferenteScreen(),
          // );
          Get.offAll(
            const GruposConferenteScreen(
              status: "L",
            ),
          );
        } else if (widget.tela == 4) {
          Get.offAll(
            const EntradaScreen(),
          );
        } else if (widget.tela == 5) {
          Get.offAll(const ConferenciasScreen());
        } else {
          Get.offAll(
            const GruposConferenteScreen(
              status: "D",
            ),
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
              widget.image,
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
            widget.tela == 1
                ? Obx(() {
                    return Text(
                      "QTD:${widget.loadingConferenteController.qtdDisponiveis}",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  })
                : widget.tela == 2
                    ? Obx(
                        () {
                          return Text(
                            "QTD:\t${widget.loadingConferenteController.qtdEmAndamento}",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      )
                    : widget.tela == 3
                        ? Obx(() {
                            return Text(
                              "QTD:\t${widget.loadingConferenteController.qtdLiberadas}",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          })
                        : widget.tela == 4
                            ? Obx(() {
                                return Text(
                                  "QTD:\t${widget.loadingConferenteController.qtdAtribuidas}",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              })
                            : widget.tela == 5
                                ? Obx(() {
                                    return Text(
                                      "QTD:\t${widget.loadingConferenteController.minhasConferencias}",
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
