
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/apis/separa_api.dart';
import 'package:teste_tela/controllers/conferencia_controller.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/screens/preordens/preordens_screen.dart';
import 'package:teste_tela/screens/produtos/conferente/produtos_screen.dart';
import 'package:teste_tela/screens/usuarios/conferente/usuarios_screen.dart';

class CardPreordemConferente extends StatefulWidget {
  final GrupoSepApp grupoSepApp;
  final ConferenciaController conferenciaController;
  final LoginController loginController;
  const CardPreordemConferente({
    Key? key,
    required this.grupoSepApp,
    required this.conferenciaController,
    required this.loginController,
  }) : super(key: key);

  @override
  _CardPreordemConferenteState createState() => _CardPreordemConferenteState();
}

class _CardPreordemConferenteState extends State<CardPreordemConferente> {
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
            if (widget.grupoSepApp.status == "L") {
              Get.defaultDialog(
                title: "Iniciar conferência?",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.grupoSepApp.ordemcarga == "S"
                        ? Text(
                            "ORDEMCARGA:\t\t${widget.grupoSepApp.preoc.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                            ),
                          )
                        : Text(
                            "PRÉ-ORDEM:\t\t${widget.grupoSepApp.preoc.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                            ),
                          ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "SETOR:\t\t${widget.grupoSepApp.setor.toString()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0.sp,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "QTD. ITENS:\t\t${widget.grupoSepApp.qtde.toString()}",
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
                  var lista = await SeparaApi.iniciarConferencia(
                    nrpreoc: widget.grupoSepApp.preoc!,
                    local: widget.grupoSepApp.setor!,
                    conferente: widget.loginController.idsepconf.value,
                  );
                  if (lista != null) {
                    widget.conferenciaController.iniciarConferencia(lista).then(
                          (value) => Get.offAll(
                            ProdutosConferenteScreen(
                              idsepconf: widget.loginController.idsepconf.value,
                              nrpreoc: widget.grupoSepApp.preoc!,
                              setor: widget.grupoSepApp.setor!,
                            ),
                          ),
                        );
                  }
                },
                textCancel: "Não",
                onCancel: () {},
              );
            } else if (widget.grupoSepApp.status == "A" ||
                widget.grupoSepApp.status == "E") {
              Get.defaultDialog(
                title: "Remover Separador?",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.grupoSepApp.ordemcarga == "S"
                        ? Text(
                            "ORDEMCARGA:\t\t${widget.grupoSepApp.preoc.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                            ),
                          )
                        : Text(
                            "PRÉ-ORDEM:\t\t${widget.grupoSepApp.preoc.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                            ),
                          ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "SETOR:\t\t${widget.grupoSepApp.setor}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0.sp,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    widget.grupoSepApp.status == "D"
                        ? Container()
                        : Text(
                            "SEPARADOR:\t\t${widget.grupoSepApp.nomeseparador}",
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
                  bool resposta = await SeparaApi.retirarSeparacao(
                      separador: widget.grupoSepApp.idseparador!,
                      local: widget.grupoSepApp.setor!,
                      nrpreoc: widget.grupoSepApp.preoc!);

                  if (resposta) {
                    Get.back();
                    Get.defaultDialog(
                      barrierDismissible: false,
                      title: "Separador removido com sucesso!",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Lottie.asset(
                            'assets/images/sucesso.json',
                            width: 140,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          widget.grupoSepApp.ordemcarga == "S"
                              ? Text(
                                  "ORDEMCARGA:\t\t${widget.grupoSepApp.preoc.toString()}",
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(
                                  "PRÉ-ORDEM:\t\t${widget.grupoSepApp.preoc.toString()}",
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "SETOR:\t\t${widget.grupoSepApp.setor}",
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "SEPARADOR:\t\t${widget.grupoSepApp.nomeseparador}",
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      textConfirm: "Ok",
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.offAll(
                          PreordensConferenteScreen(
                            status: widget.grupoSepApp.status!,
                            setor: widget.grupoSepApp.setor!,
                          ),
                        );
                      },
                    );
                  } else {
                    Get.back();
                    Get.defaultDialog(
                      title: "Atenção!",
                      content: Column(
                        children: [
                          Text(
                            "Separador já removido.",
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
                            status: widget.grupoSepApp.status!,
                            setor: widget.grupoSepApp.setor!,
                          ),
                        );
                      },
                    );
                  }
                },
                textCancel: "Não",
                onCancel: () {},
              );
            } else if (widget.grupoSepApp.status == "D") {
              Get.defaultDialog(
                title: "Atribuir Separador?",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.grupoSepApp.ordemcarga == "S"
                        ? Text(
                            "ORDEMCARGA:\t\t${widget.grupoSepApp.preoc.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                            ),
                          )
                        : Text(
                            "PRÉ-ORDEM:\t\t${widget.grupoSepApp.preoc.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                            ),
                          ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "SETOR:\t\t${widget.grupoSepApp.setor}",
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
                  Get.back();
                  Get.to(
                    UsuariosScreen(
                      status: "D",
                      atribuindo: true,
                      grupoSepApp: widget.grupoSepApp,
                    ),
                  );
                },
                textCancel: "Não",
                onCancel: () {},
              );
            }
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
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "SETOR:\t\t${widget.grupoSepApp.setor ?? ""}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "QTD. ITENS:\t\t${widget.grupoSepApp.qtde.toString()}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  widget.grupoSepApp.status == "D"
                      ? Container()
                      : Text(
                          "SEPARADOR:\t\t${widget.grupoSepApp.nomeseparador}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
