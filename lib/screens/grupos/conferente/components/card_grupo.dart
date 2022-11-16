import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/models/grupos.dart';
import 'package:teste_tela/screens/preordens/preordens_screen.dart';

class CardGrupoConferente extends StatelessWidget {
  final String status;
  final Grupo grupo;
  const CardGrupoConferente(
      {Key? key, required this.status, required this.grupo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.offAll(
          PreordensConferenteScreen(
            setor: grupo.setor!,
            status: status,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              grupo.setor!.replaceAll(" - ", "\n"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "QTD:\t${grupo.qtd.toString()}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
