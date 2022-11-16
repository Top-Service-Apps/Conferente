import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/Animation/FadeAnimation.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/controllers/separador/loading_separador_controller.dart';
import 'package:teste_tela/main.dart';
import 'package:teste_tela/screens/home/telas.dart';
import 'package:teste_tela/screens/login/login_screen.dart';
import 'components/card_home.dart';
import 'components/drawer_home.dart';

class HomeSeparadorScreen extends StatefulWidget {
  const HomeSeparadorScreen({Key? key}) : super(key: key);

  @override
  _HomeSeparadorScreenState createState() => _HomeSeparadorScreenState();
}

class _HomeSeparadorScreenState extends State<HomeSeparadorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final loadingSeparadorController = Get.put(LoadingSeparadorController());
  final loginController = Get.put(LoginController());

  @override
  void initState() {
    loadingSeparadorController.obterQtdMeuGrupo(loginController.setor.value);
    loadingSeparadorController.obterQtd();
    loadingSeparadorController
        .obterQtdMinhasSeparacoes(loginController.idsepconf.value);
    loadingSeparadorController
        .obterQtdReconferencias(loginController.idsepconf.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
          title: "Atenção",
          content: Text(
            "Deseja sair do App?",
            style: TextStyle(fontSize: 12.sp),
          ),
          onCancel: () {},
          textCancel: "Não",
          onConfirm: () {
            Get.offAll(const LoginScreen());
          },
          textConfirm: "Sim",
          confirmTextColor: Colors.white,
        );
        return true;
      },
      child: Scaffold(
          key: _scaffoldKey,
          drawerEnableOpenDragGesture: false,
          drawer: DrawerHomeSeparador(
            loginController: loginController,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: Column(children: [
            Container(
              color: const Color.fromRGBO(42, 44, 43, 1),
              child: ClipPath(
                clipper: RoundedClipper(),
                child: Container(
                  height: queryData.size.height / 2.3,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Positioned(
                        top: queryData.size.height * 0.1,
                        right: queryData.size.width * 0.6,
                        //Align(
                        //  alignment: const Alignment(-1.60, 0.00),
                        child: FadeAnimation(
                          1.5,
                          Image.asset(
                            'assets/images/box2.png',
                            height: 260,
                            color: const Color.fromRGBO(196, 161, 109, 1)
                                .withOpacity(0.4),
                          ),
                        ),
                      ),
                      Positioned(
                        top: queryData.size.height * 0.1,
                        left: queryData.size.width * 0.7,
                        child: FadeAnimation(
                          1.5,
                          Image.asset(
                            'assets/images/box.png',
                            height: 260,
                            color: const Color.fromRGBO(196, 161, 109, 1)
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              _scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Olá \n',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(0, 162, 180, 1))),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: loginController.nomeusu.value,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Color.fromRGBO(42, 44, 43, 1))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                childAspectRatio: 4 / 3,
                crossAxisCount: 2,
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 20, top: 10), //10),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                // shrinkWrap: true,
                children: [
                  CardHomeSeparador(
                    tela: Tela.minhaseparacoes,
                    nome: 'Minhas Separações',
                    imagem: 'assets/images/separacao.jpeg',
                    controller: loadingSeparadorController,
                  ),

                  // SizedBox(
                  //   height: 1.h,
                  // ),

                  CardHomeSeparador(
                    tela: Tela.meugrupo,
                    nome: 'Ordens de Carga',
                    imagem: 'assets/images/armazem.jpeg',
                    controller: loadingSeparadorController,
                  ),

                  //  SizedBox(
                  //    height: 1.h,
                  //  ),
/*
                  CardHomeSeparador(
                    tela: Tela.reconferencias,
                    nome: 'Reconferências',
                    imagem: 'assets/images/reconferencias.jpeg',
                    controller: loadingSeparadorController,
                  ),

                  CardHomeSeparador(
                    tela: Tela.reconferencias,
                    nome: 'Empilhadeira',
                    imagem: 'assets/images/empilhadeira.jpeg',
                    controller: loadingSeparadorController,
                  ),

                  */
                ],
              ),
            ),
          ])),
    );
  }
}
