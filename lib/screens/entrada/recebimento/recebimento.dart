import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/models/gruposepapp.dart';
import 'package:teste_tela/screens/home/conferente/home_screen.dart';

class RecebimentoScreen extends StatefulWidget {
  const RecebimentoScreen({Key? key}) : super(key: key);

  @override
  State<RecebimentoScreen> createState() => _RecebimentoScreenState();
}

class _RecebimentoScreenState extends State<RecebimentoScreen> {
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
            'Recebimento',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
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
              height: 22.h,
              width: double.infinity,
              child: Column(
                children: [
                  Center(
                    child: IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: queryData.size.width / 1.2, //200.sp,
                      child: TextField(
                        controller: pesquisaController,
                        decoration: InputDecoration(
                          hintText: 'Digite o código de barras',
                          hintStyle: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
