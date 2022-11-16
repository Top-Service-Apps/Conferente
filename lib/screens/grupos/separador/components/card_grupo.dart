
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/apis/separa_api.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/controllers/separacao_controller.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/models/separa.dart';
import 'package:teste_tela/screens/grupos/separador/grupo_screen.dart';
import 'package:teste_tela/screens/produtos/separador/produtos_screen.dart';

class CardGrupoSeparador extends StatefulWidget {
  final GrupoSepApp grupoSepApp;
  final LoginController loginController;

  const CardGrupoSeparador({
    Key? key,
    required this.grupoSepApp,
    required this.loginController,
  }) : super(key: key);

  @override
  _CardGrupoSeparadorState createState() => _CardGrupoSeparadorState();
}

class _CardGrupoSeparadorState extends State<CardGrupoSeparador> {
  final separacaoController = Get.put(SeparacaoController());

  Widget statusSeparacao(GrupoSepApp grupoSepApp) {
    if (grupoSepApp.status == "E") {
      return Image.asset(
        "assets/images/e.png",
        height: 20.h,
        width: 20.w,
      );
    } else if (grupoSepApp.status == "A") {
      return Image.asset(
        "assets/images/a.png",
        height: 20.h,
        width: 20.w,
      );
    } else if (grupoSepApp.status == "L") {
      return Image.asset(
        "assets/images/l.png",
        height: 20.h,
        width: 20.w,
      );
    } else {
      return Image.asset(
        "assets/images/d.png",
        height: 20.h,
        width: 20.w,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Get.defaultDialog(
              title: "Iniciar Separação?",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.grupoSepApp.ordemcarga == "S"
                      ? Text(
                          "ORDEMCARGA:\t\t${widget.grupoSepApp.preoc.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        )
                      : Text(
                          "PRÉ-ORDEM:\t\t${widget.grupoSepApp.preoc.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "SETOR:\t\t${widget.grupoSepApp.setor.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              textConfirm: "Sim",
              confirmTextColor: Colors.white,
              onConfirm: () async {
                List<Separa> lista = await SeparaApi.iniciarSeparacao(
                  nrpreoc: widget.grupoSepApp.preoc!,
                  local: widget.grupoSepApp.setor!,
                  separador: widget.loginController.idsepconf.value,
                );
                if (lista.isNotEmpty) {
                  separacaoController.iniciarSeparacao(lista).then(
                        (value) => Get.offAll(
                          ProdutosSeparadorScreen(
                            idsepconf: widget.loginController.idsepconf.value,
                            setor: widget.grupoSepApp.setor!,
                            nrpreoc: widget.grupoSepApp.preoc!,
                          ),
                        ),
                      );
                } else {
                  Get.back();
                  Get.defaultDialog(
                    title: "Erro",
                    content: const Text(
                      "Ordem já iniciada",
                    ),
                    onCancel: () {
                      Get.offAll(const GrupoSeparadorScreen());
                    },
                    textCancel: "Sair",
                  );
                }
              },
              textCancel: "Não",
              onCancel: () {},
            );
          },
          trailing: statusSeparacao(widget.grupoSepApp),
          title: widget.grupoSepApp.ordemcarga == "S"
              ? Text(
                  "ORDEMCARGA:\t\t${widget.grupoSepApp.preoc}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                )
              : Text(
                  "PRÉ-ORDEM:\t\t${widget.grupoSepApp.preoc}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
          subtitle: Text(
            "SETOR:\t\t${widget.grupoSepApp.setor}",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
