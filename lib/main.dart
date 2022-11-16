import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/screens/login/login_screen.dart';
import 'package:teste_tela/stores/atualizacao_store.dart';
import 'package:teste_tela/style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //NotificationPlugin().init();

  runApp(
    MultiProvider(
      providers: [
        Provider<AtualizacaoStore>.value(
          value: AtualizacaoStore(),
        ),
      ],
      child: const AppSeparacaoConferencia(),
    ),
  );
}

class AppSeparacaoConferencia extends StatelessWidget {
  const AppSeparacaoConferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // OneSignal.shared.setAppId("d86d30c0-dcea-42c7-ba2e-73942de15265");
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: androidTheme(),
        home: const LoginScreen(),
      );
    });
  }
}

class RoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
