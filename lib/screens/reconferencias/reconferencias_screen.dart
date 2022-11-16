
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/controllers/reconferencia_controller.dart';
import 'package:teste_tela/models/cortesepara.dart';
import 'package:teste_tela/screens/home/separador/home_screen.dart';
import 'package:teste_tela/widgets/legendas.dart';
import 'components/card_reconferencias.dart';

class ReconferenciasSeparadorScreen extends StatefulWidget {
  const ReconferenciasSeparadorScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ReconferenciasSeparadorScreenState createState() =>
      _ReconferenciasSeparadorScreenState();
}

class _ReconferenciasSeparadorScreenState
    extends State<ReconferenciasSeparadorScreen> {
  List<CorteSepara> lista = [];
  List<CorteSepara> listaPesquisa = [];
  bool barraPesquisa = false;
  TextEditingController pesquisaController = TextEditingController();
  final loginController = Get.put(LoginController());
  final reconferenciaController = Get.put(ReconferenciaController());

  onSearch(String text) async {
    listaPesquisa.clear();
    if (text.isEmpty || text == "") {
      return;
    }

    setState(() {
      for (var e in lista) {
        if (e.nrpreoc.toString().contains(text)) {
          listaPesquisa.add(e);
        }
      }
    });
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
            "Minhas Reconferências",
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
                    child: GroupedListView<dynamic, int>(
                      elements: listaPesquisa,
                      groupBy: (element) => element.nrpreoc,
                      groupComparator: (value1, value2) =>
                          value2.compareTo(value1),
                      itemComparator: (item1, item2) =>
                          item1.setor.compareTo(item2.setor),
                      order: GroupedListOrder.DESC,
                      // useStickyGroupSeparators: true,
                      groupSeparatorBuilder: (int value) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: Text(
                            "NRPREOC:\t$value ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (c, element) {
                        return CardReconferenciaSeparador(
                          corteSepara: element,
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: reconferenciaController
                          .buscarProdutos(loginController.idsepconf.value),
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
                            if (reconferenciaController.produtos.isEmpty) {
                              return Center(
                                child: Text(
                                  "Nenhuma reconferência",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              );
                            } else {
                              return GroupedListView<dynamic, int>(
                                elements: reconferenciaController.produtos,
                                groupBy: (element) => element.nrpreoc,
                                groupComparator: (value1, value2) =>
                                    value2.compareTo(value1),
                                itemComparator: (item1, item2) =>
                                    item1.setor.compareTo(item2.setor),
                                order: GroupedListOrder.DESC,
                                // useStickyGroupSeparators: true,
                                groupSeparatorBuilder: (int value) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      "NRPREOC:\t$value",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                itemBuilder: (c, element) {
                                  return CardReconferenciaSeparador(
                                    corteSepara: element,
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
          ],
        ),
      ),
    );
  }
}
