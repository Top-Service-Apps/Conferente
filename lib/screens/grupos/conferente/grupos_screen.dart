import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/config/service.dart';
import 'package:teste_tela/models/grupos.dart';
import 'package:teste_tela/screens/home/conferente/home_screen.dart';
import 'package:teste_tela/widgets/legendas.dart';

import 'components/card_grupo.dart';

class GruposConferenteScreen extends StatefulWidget {
  final String status;
  const GruposConferenteScreen({Key? key, required this.status})
      : super(key: key);

  @override
  _GruposConferenteScreenState createState() => _GruposConferenteScreenState();
}

class _GruposConferenteScreenState extends State<GruposConferenteScreen> {
  List<Grupo> lista = [];
  List<Grupo> listaPesquisa = [];
  bool barraPesquisa = false;
  TextEditingController pesquisaController = TextEditingController();

  Future<void> obter(String status) async {
    lista.clear();
    var response = await Dio().getUri(Uri(
      scheme: "http",
      host: ServiceApp.ip,
      port: int.parse(ServiceApp.port),
      path: "/gruposepapp/status/$status",
    ));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      for (Map<String, dynamic> i in data["data"]) {
        lista.add(Grupo.fromMap(i));
        lista.sort((a, b) => b.qtd!.compareTo(a.qtd!));
      }
    }
  }

  // onSearch(String text) async {
  //   listaPesquisa.clear();
  //   if (text.isEmpty || text == "") {
  //     return;
  //   }

  //   setState(() {
  //     listaPesquisa.forEach((e) {
  //       if (e.setor.toUpperCase().trim().contains(text.toUpperCase())) {
  //         listaPesquisa.add(e);
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.offAll(const HomeConferenteScreen());
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
            "Grupos - ${widget.status.toUpperCase() == "D" ? "Disponíveis" : widget.status.toUpperCase() == "E" ? "Em Andamento" : widget.status.toUpperCase() == "L" ? "Liberadas" : widget.status.toUpperCase() == "A" ? "Atribuídas" : ""}",
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
        ),
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
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: obter(widget.status),
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
                            "Nenhum grupo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      } else {
                        return Scrollbar(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(5),
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: lista.length,
                            itemBuilder: (context, index) {
                              Grupo grupo = lista[index];
                              return CardGrupoConferente(
                                grupo: grupo,
                                status: widget.status,
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
