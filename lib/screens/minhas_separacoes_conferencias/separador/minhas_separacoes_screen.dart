import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/config/service.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/screens/home/separador/home_screen.dart';
import 'package:teste_tela/widgets/legendas.dart';

import 'components/card_minhas_separacoes.dart';

class MinhasSeparacoesScreen extends StatefulWidget {
  const MinhasSeparacoesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MinhasSeparacoesScreenState createState() => _MinhasSeparacoesScreenState();
}

class _MinhasSeparacoesScreenState extends State<MinhasSeparacoesScreen> {
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

  Future<void> findBySeparador(int idseparador) async {
    lista.clear();
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/gruposepapp",
        queryParameters: {
          "idseparador": idseparador.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      for (Map<String, dynamic> i in data["data"]) {
        lista.add(GrupoSepApp.fromMap(i));
        lista.sort((a, b) => a.preoc!.compareTo(b.preoc!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.offAll(const HomeSeparadorScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: const BackButton(
            color: Colors.black,
          ),
          title: Text(
            "Minhas Separações",
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
                                hintText: "Pesquisa )",
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
                          return CardMinhasSeparacoes(
                            grupoSepApp: grupoSepApp,
                            loginController: loginController,
                          );
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: findBySeparador(loginController.idsepconf.value),
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
                                  "Nenhuma separação",
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
                                    return CardMinhasSeparacoes(
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
        ),
      ),
    );
  }
}
