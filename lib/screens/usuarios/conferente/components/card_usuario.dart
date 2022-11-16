import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/apis/separa_api.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/models/sepconf.dart';
import 'package:teste_tela/screens/preordens/preordens_screen.dart';

class CardUsuario extends StatelessWidget {
  final SepConf sepconf;
  final bool atribuindo;
  final GrupoSepApp? grupoSepApp;

  const CardUsuario({
    Key? key,
    required this.sepconf,
    required this.atribuindo,
    required this.grupoSepApp,
  }) : super(key: key);

  Color getColor(SepConf sepconf) {
    if (sepconf.status == "D") {
      return Colors.green;
    } else if (sepconf.status == "O") {
      return Colors.orange;
    } else if (sepconf.status == "A") {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: ListTile(
        // leading: getIcon(sepconf),
        trailing: Icon(
          FontAwesome.user,
          color: getColor(sepconf),
        ),
        title: Text(
          sepconf.usuario!.nomeusu!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          "SETOR:\t\t${sepconf.setor ?? " "}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 12.sp,
          ),
        ),
        onTap: () {
          if (atribuindo) {
            Get.defaultDialog(
              title: "Confirmar Atribuição?",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PRÉ-ORDEM:\t\t${grupoSepApp!.preoc.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "SETOR:\t\t${grupoSepApp!.setor ?? ""}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "SEPARADOR:\t\t${sepconf.usuario!.nomeusu ?? ""}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                  ),
                ],
              ),
              textConfirm: "Sim",
              confirmTextColor: Colors.white,
              onConfirm: () async {
                bool resposta = await SeparaApi.atribuirSeparacao(
                  separador: sepconf.idsepconf!,
                  nrpreoc: grupoSepApp!.preoc!,
                  local: grupoSepApp!.setor!,
                );

                if (resposta) {
                  Get.defaultDialog(
                    barrierDismissible: false,
                    title: "Atribuição realizada com sucesso!",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/images/sucesso.json',
                          fit: BoxFit.contain,
                          height: 20.h,
                          width: 50.w,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            grupoSepApp!.ordemcarga == "S"
                                ? Text(
                                    "ORDEMCARGA:\t\t${grupoSepApp!.preoc.toString()}",
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "PRÉ-ORDEM:\t\t${grupoSepApp!.preoc.toString()}",
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "SETOR:\t\t${grupoSepApp!.setor}",
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "SEPARADOR:\t\t${sepconf.usuario!.nomeusu}",
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    textConfirm: "Ok",
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.offAll(PreordensConferenteScreen(
                        setor: grupoSepApp!.setor!,
                        status: grupoSepApp!.status!,
                      ));
                    },
                  );
                } else {
                  Get.back();
                  Get.defaultDialog(
                    title: "Atenção!",
                    content: Column(
                      children: [
                        Text(
                          "Ordem já atribuída.",
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    textConfirm: "Sair",
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.offAll(
                        PreordensConferenteScreen(
                          status: grupoSepApp!.status!,
                          setor: grupoSepApp!.setor!,
                        ),
                      );
                    },
                  );
                }
              },
              textCancel: "Não",
              onCancel: () {},
            );
          } else {
            return;
          }
        },
      ),
    );
  }
}
