import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/screens/entrada/armazenamento/armazenamento.dart';
import 'package:teste_tela/screens/entrada/recebimento/recebimento.dart';
import 'package:teste_tela/screens/home/conferente/home_screen.dart';

class EntradaScreen extends StatefulWidget {
  const EntradaScreen({Key? key}) : super(key: key);

  @override
  State<EntradaScreen> createState() => _EntradaScreenState();
}

class _EntradaScreenState extends State<EntradaScreen> {
  List<GrupoSepApp> lista = [];
  List<GrupoSepApp> listaPesquisa = [];
  bool barraPesquisa = false;
  TextEditingController pesquisaController = TextEditingController();
  onSearch(String text) async {
    listaPesquisa.clear();
    if (text.isEmpty || text == "") {
      return;
    }

    setState(() {
      for (var e in lista) {
        if (e.preoc!.toString().contains(text)) {
          listaPesquisa.add(e);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
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
            'Entrada',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.offAll(const ArmazenamentoScreen());
              },
              child: const Text('Armazenamento'),
            ),
            InkWell(
              onTap: () {
                Get.offAll(const RecebimentoScreen());
              },
              child: const Text('Recebimento'),
            ),
          ],
        ),
      ),
    );
  }
}
