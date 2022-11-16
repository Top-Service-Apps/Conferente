import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/apis/separa_api.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/controllers/separacao_controller.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/screens/home/separador/home_screen.dart';
import 'package:teste_tela/screens/produtos/separador/produtos_screen.dart';

class CardMinhasSeparacoes extends StatelessWidget {
  final GrupoSepApp grupoSepApp;
  final LoginController loginController;
  CardMinhasSeparacoes({
    Key? key,
    required this.grupoSepApp,
    required this.loginController,
  }) : super(key: key);

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
    } else if (grupoSepApp.status == "C") {
      return Image.asset(
        "assets/images/c.png",
        height: 20.h,
        width: 20.w,
      );
    } else if (grupoSepApp.status == "R") {
      return Image.asset(
        "assets/images/r.png",
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

  final separacaoController = Get.put(SeparacaoController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            if (grupoSepApp.status == "A") {
              Get.defaultDialog(
                title: "Iniciar Separação?",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ORDEM - CARGA:\t\t${grupoSepApp.preoc.toString()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "SETOR:\t\t${grupoSepApp.setor.toString()}",
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
                  var lista = await SeparaApi.iniciarSeparacao(
                    nrpreoc: grupoSepApp.preoc!,
                    local: grupoSepApp.setor!,
                    separador: loginController.idsepconf.value,
                  );
                  if (lista != null) {
                    separacaoController.iniciarSeparacao(lista).then(
                          (value) => Get.offAll(
                            ProdutosSeparadorScreen(
                              idsepconf: loginController.idsepconf.value,
                              setor: grupoSepApp.setor!,
                              nrpreoc: grupoSepApp.preoc!,
                            ),
                          ),
                        );
                  } else {
                    Get.defaultDialog(
                      title: "Erro",
                      content: const Text(
                        "Pré-ordem já iniciada",
                      ),
                      onCancel: () {},
                      textCancel: "Não",
                    );
                  }
                },
                textCancel: "Não",
                onCancel: () {},
              );
            } else if (grupoSepApp.status == "E") {
              Get.offAll(
                ProdutosSeparadorScreen(
                  idsepconf: grupoSepApp.idseparador!,
                  nrpreoc: grupoSepApp.preoc!,
                  setor: grupoSepApp.setor!,
                ),
              );
            } else {
              Get.offAll(const HomeSeparadorScreen());
            }
          },
          trailing: statusSeparacao(grupoSepApp),
          title: grupoSepApp.ordemcarga == "S"
              ? Text(
                  "ORDEMCARGA:\t\t${grupoSepApp.preoc}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                )
              : Text(
                  "PRÉ-ORDEM:\t\t${grupoSepApp.preoc}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
          subtitle: Text(
            "SETOR:\t\t${grupoSepApp.setor ?? ""}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
