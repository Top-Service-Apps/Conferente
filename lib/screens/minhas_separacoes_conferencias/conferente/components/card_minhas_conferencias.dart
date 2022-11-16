import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/screens/produtos/conferente/produtos_screen.dart';

class CardMinhasConferencias extends StatefulWidget {
  final GrupoSepApp grupoSepApp;
  final LoginController loginController;
  const CardMinhasConferencias({
    Key? key,
    required this.grupoSepApp,
    required this.loginController,
  }) : super(key: key);

  @override
  _CardMinhasConferenciasState createState() => _CardMinhasConferenciasState();
}

class _CardMinhasConferenciasState extends State<CardMinhasConferencias> {
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
            Get.offAll(
              ProdutosConferenteScreen(
                idsepconf: widget.loginController.idsepconf.value,
                nrpreoc: widget.grupoSepApp.preoc!,
                setor: widget.grupoSepApp.setor!,
              ),
            );
          },
          trailing: statusSeparacao(widget.grupoSepApp),
          title: Text(
            "PRÉ-ORDEM:\t\t${widget.grupoSepApp.preoc}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          subtitle: Text(
            "SETOR:\t\t${widget.grupoSepApp.setor ?? ""}",
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
