import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'legendas.dart';

class AppBarWidget extends StatelessWidget {
  final String titulo;
  const AppBarWidget({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: const BackButton(
        color: Colors.black,
      ),
      title: Text(
        titulo,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.defaultDialog(
              title: "Legendas",
              content: const LegendasWidget(),
              onCancel: () {},
              textCancel: "Sair",
            );
          },
          icon: const Icon(
            Ionicons.help_circle_outline,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
