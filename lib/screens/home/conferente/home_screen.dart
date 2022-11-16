import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/Animation/FadeAnimation.dart';
import 'package:teste_tela/controllers/conferente/loading_conferente_controller.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/main.dart';
import 'package:teste_tela/screens/login/login_screen.dart';
import 'components/card_home.dart';
import 'components/drawer_home.dart';

class HomeConferenteScreen extends StatefulWidget {
  const HomeConferenteScreen({Key? key}) : super(key: key);

  @override
  _HomeConferenteScreenState createState() => _HomeConferenteScreenState();
}

class _HomeConferenteScreenState extends State<HomeConferenteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final loginController = Get.put(LoginController());
  final loadingConferenteController = Get.put(LoadingConferenteController());

  @override
  void initState() {
    loadingConferenteController.carregar(loginController.idsepconf.value);
    super.initState();
  }

  // late ProdutosConferenteStore produtosConferenteStore;
  // late PreLoadConferenteStore preLoadConferenteStore;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // Future<void> showNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //           'your channel id', 'your channel name', 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'PRÉ-ORDEM: 555',
  //     'ATRIBUíDA',
  //     platformChannelSpecifics,
  //     payload: 'item x',
  //   );
  // }

  // Future<void> scanQR(
  //     LoginStore loginStore,
  //     ProdutosConferenteStore produtosConferenteStore,
  //     SeparacaoHelpers db) async {
  //   String barcodeScanRes;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.QR);
  //     print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   // bool resposta = await SeparaApi.iniciarConferenciaQrdcode(
  //   //   qrcode: barcodeScanRes,
  //   //   idsepconf: loginStore.idsepconf!,
  //   //   produtosConferenteStore: produtosConferenteStore,
  //   //   db: db,
  //   // );
  //   // if (resposta) {
  //   //   Get.offAll(ConferenciasScreen());
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    // Timer mytimer = Timer.periodic(Duration(seconds: 5), (timer) {
    //   showNotification();
    // });

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
            drawer: DrawerHomeConferente(
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
                          bottom: queryData.size.height * 0.01,
                          left: queryData.size.width * 0.6,
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
                            FadeAnimation(
                              1.4,
                              IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Center(
                              child: FadeAnimation(
                                1.5,
                                RichText(
                                  text: TextSpan(
                                    text: 'Olá \n',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                0, 162, 180, 1))),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: loginController.nomeusu.value,
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    42, 44, 43, 1))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
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
                        bottom: 20, left: 20, right: 20, top: 10),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    // shrinkWrap: true,
                    children: [
                      CardHomeConferente(
                        tela: 5,
                        nome: 'Minhas Conferências',
                        image: 'assets/images/separacao.jpeg',
                        loginController: loginController,
                        loadingConferenteController:
                            loadingConferenteController,
                      ),

                      // FadeAnimation(
                      //   1.5,
                      //   CardHomeConferente(
                      //     tela: 1,
                      //     nome: 'Disponíveis',
                      //     image: 'assets/images/separacao.jpeg',
                      //     loginController: loginController,
                      //     loadingConferenteController:
                      //         loadingConferenteController,
                      //   ),
                      // ),

                      CardHomeConferente(
                        tela: 3,
                        nome: 'Liberadas',
                        image: 'assets/images/separacao.jpeg',
                        loginController: loginController,
                        loadingConferenteController:
                            loadingConferenteController,
                      ),

                      CardHomeConferente(
                        tela: 2,
                        nome: 'Em Andamento',
                        image: 'assets/images/separacao.jpeg',
                        loginController: loginController,
                        loadingConferenteController:
                            loadingConferenteController,
                      ),

                      CardHomeConferente(
                        tela: 4,
                        nome: 'Entrada',
                        image: 'assets/images/separacao.jpeg',
                        loginController: loginController,
                        loadingConferenteController:
                            loadingConferenteController,
                      ),

                      // FadeAnimation(
                      //   1.5,
                      //   CardHomeConferente(
                      //     tela: 4,
                      //     nome: 'Complementos',
                      //     image: 'assets/images/reconferencias.jpeg',
                      //     loginController: loginController,
                      //     loadingConferenteController:
                      //         loadingConferenteController,
                      //   ),
                      // ),
                    ]),
              ),
            ])));
  }
}
