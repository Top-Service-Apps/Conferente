import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/config/service.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/models/sepconf.dart';
import 'package:teste_tela/screens/home/conferente/home_screen.dart';

import 'components/card_usuario.dart';

class UsuariosScreen extends StatefulWidget {
  final String status;
  final bool atribuindo;
  final GrupoSepApp? grupoSepApp;

  const UsuariosScreen({
    Key? key,
    required this.status,
    required this.atribuindo,
    this.grupoSepApp,
  }) : super(key: key);

  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final TextEditingController _pesquisaController = TextEditingController();

  List<SepConf> listaPesquisa = [];
  List<SepConf> lista = [];
  bool barraPesquisa = false;
  TextEditingController pesquisaController = TextEditingController();

  Future<void> findByStatusAndTipo(String status, String tipo) async {
    lista.clear();
    var response = await Dio().getUri(
      Uri(
        scheme: "http",
        host: ServiceApp.ip,
        port: int.parse(ServiceApp.port),
        path: "/sepconf",
        queryParameters: {
          "status": status.toUpperCase(),
          "tipo": tipo.toUpperCase(),
        },
      ),
    );
    Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data["content"]) {
        lista.add(SepConf.fromMap(i));
      }
    }
  }

  onSearch(String text) async {
    listaPesquisa.clear();
    if (text.isEmpty || text == "") {
      return;
    }

    setState(() {
      for (var e in lista) {
        if (e.usuario!.nomeusu!
            .trim()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          listaPesquisa.add(e);
        }
      }
    });
  }

  Future<bool> _willPopCallback() async {
    if (widget.atribuindo == true) {
      Get.back();
    } else {
      Get.offAll(const HomeConferenteScreen());
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _willPopCallback();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: PreferredSize(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 25.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        // widget.atribuindo
                        //     ? Get.offAll(
                        //         PreordensConferenteScreen(
                        //             status: widget.grupoSep!.status!,
                        //             setor: widget.grupoSep!.setor!),
                        //       )
                        Get.offAll(
                          const HomeConferenteScreen(),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 16.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Legendas",
                          content: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesome.user,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  const Text("Disponíveis"),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesome.user,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  const Text("Em Andamento"),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesome.user,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  const Text("Atribuídos"),
                                ],
                              ),
                            ],
                          ),
                          onCancel: () {},
                          textCancel: "Sair",
                        );
                      },
                      icon: Icon(
                        Ionicons.help_circle_outline,
                        size: 16.sp,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Usuários",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                barraPesquisa
                    ? SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                onChanged: (text) {
                                  onSearch(text);
                                },
                                decoration: const InputDecoration(
                                  hintText: "Pesquisa (NOME)",
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
                              icon: Icon(
                                Icons.close,
                                size: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              // listaPesquisa.clear();
                              setState(() {
                                barraPesquisa = true;
                              });
                            },
                            icon: Icon(
                              Icons.search,
                              size: 16.sp,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.refresh,
                              size: 16.sp,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          preferredSize: const Size.fromHeight(220),
        ),
        body: listaPesquisa.isNotEmpty || _pesquisaController.text.isNotEmpty
            ? ListView.builder(
                itemCount: listaPesquisa.length,
                itemBuilder: (context, i) {
                  SepConf sepconf = listaPesquisa[i];
                  return CardUsuario(
                    atribuindo: widget.atribuindo,
                    sepconf: sepconf,
                    grupoSepApp: widget.grupoSepApp,
                  );
                },
              )
            : FutureBuilder(
                future: findByStatusAndTipo(widget.status, "S"),
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
                            "Nenhum usuário",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      } else {
                        return ListView.separated(
                          itemCount: lista.length,
                          itemBuilder: (context, i) {
                            SepConf sepconf = lista[i];
                            return CardUsuario(
                              atribuindo: widget.atribuindo,
                              sepconf: sepconf,
                              grupoSepApp: widget.grupoSepApp,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            index++;
                            return const Divider(
                              color: Colors.white,
                            );
                          },
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
    );
  }
}
