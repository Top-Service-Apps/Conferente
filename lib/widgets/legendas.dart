import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LegendasWidget extends StatelessWidget {
  const LegendasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              "assets/images/d.png",
              width: 8.w,
              height: 8.h,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("Disponível"),
          ],
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/e.png",
              width: 8.w,
              height: 8.h,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("Em Andamento"),
          ],
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/l.png",
              width: 8.w,
              height: 8.h,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("Liberada"),
          ],
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/a.png",
              width: 8.w,
              height: 8.h,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("Atribuída"),
          ],
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/c.png",
              width: 8.w,
              height: 8.h,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("Conferência"),
          ],
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/r.png",
              width: 8.w,
              height: 8.h,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("Reconferência"),
          ],
        ),
      ],
    );
  }
}
