import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/config/service.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/screens/home/conferente/home_screen.dart';
import 'package:teste_tela/widgets/legendas.dart';
import 'components/card_minhas_conferencias.dart';

class ConferenciasScreen extends StatefulWidget {
  const ConferenciasScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ConferenciasScreenState createState() => _ConferenciasScreenState();
}

class _ConferenciasScreenState extends State<ConferenciasScreen> {
  List<GrupoSepApp> lista = [];
  List<GrupoSepApp> listaPesquisa = [];
  bool barraPesquisa = false;
  TextEditingController pesquisaController = TextEditingController();

  final loginController = Get.put(LoginController());

  onSearch(String text) async {
    listaPesquisa.clear();
    if (text.isEmpty || text == "") {
      return;
    }

    setState(() {
      for (var e in lista) {
        if (e.preoc.toString().contains(text)) {
          listaPesquisa.add(e);
        }
      }
    });
  }

  Future<void> findByConferente(int idconferente) async {
    lista.clear();
    var response = await Dio().getUri(Uri(
      scheme: "http",
      host: ServiceApp.ip,
      port: int.parse(ServiceApp.port),
      path: "/gruposepapp",
      queryParameters: {
        "idconferente": idconferente.toString(),
      },
    ));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      for (Map<String, dynamic> i in data["data"]) {
        lista.add(GrupoSepApp.fromMap(i));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.offAll(const HomeConferenteScreen());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.offAll(const HomeConferenteScreen());
              },
            ),
            title: Text(
              "Minhas Conferências",
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
                  // size: 16.sp,
                  color: Colors.black,
                ),
              )
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                height: 10.h,
                width: double.infinity,
                child: barraPesquisa
                    ? Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                onChanged: (text) {
                                  onSearch(text);
                                },
                                decoration: const InputDecoration(
                                  hintText: "Pesquisa (NRPREOC)",
                                ),
                                controller: pesquisaController,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  setState(() {
                                    barraPesquisa = false;
                                    listaPesquisa.clear();
                                    pesquisaController.text = "";
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                barraPesquisa = !barraPesquisa;
                              });
                            },
                            icon: const Icon(Icons.search),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
              ),
              listaPesquisa.isNotEmpty || pesquisaController.text != ""
                  ? Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: listaPesquisa.length,
                          padding: const EdgeInsets.all(20),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            GrupoSepApp grupoSepApp = listaPesquisa[index];
                            return CardMinhasConferencias(
                              grupoSepApp: grupoSepApp,
                              loginController: loginController,
                            );
                          },
                        ),
                      ),
                    )
                  : Expanded(
                      child: FutureBuilder(
                        future:
                            findByConferente(loginController.idsepconf.value),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Carregando...',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );

                            case ConnectionState.done:
                              if (lista.isEmpty) {
                                return Center(
                                  child: Text(
                                    "Nenhuma conferência",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                );
                              } else {
                                return Scrollbar(
                                  child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Divider(
                                        color: Colors.white,
                                      );
                                    },
                                    itemCount: lista.length,
                                    padding: const EdgeInsets.all(20),
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, index) {
                                      GrupoSepApp grupoSepApp = lista[index];
                                      return CardMinhasConferencias(
                                        grupoSepApp: grupoSepApp,
                                        loginController: loginController,
                                      );
                                    },
                                  ),
                                );
                              }

                            case ConnectionState.none:
                              break;
                            case ConnectionState.active:
                              break;
                          }
                          return const Center(
                            child: Text("Unknown Error"),
                          );
                        },
                      ),
                    ),
            ],
          )),
    );
  }
}
