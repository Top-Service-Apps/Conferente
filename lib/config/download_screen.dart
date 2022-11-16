import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:teste_tela/config/file_link.dart';
import 'package:teste_tela/config/local_notification.dart';
import 'package:teste_tela/models/atualizacao.dart';
import 'package:teste_tela/stores/atualizacao_store.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({
    Key? key,
  }) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  List? usuarios;
  String? statusUsu;
  bool pesquisa = false;

  String _progress = '-';
  final Dio _dio = Dio();
  final fromKey = GlobalKey<FormState>();
  bool loading = false;

  List<Atualizacao> lista = [];
  bool barraPesquisa = false;
  TextEditingController pesquisaController = TextEditingController();
  late AtualizacaoStore atualizacaoStore;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _download(String nome, String url) async {
    setState(() {
      FileLink.fileUrl = url; //= urlController.text;
      FileLink.fileName = nome; //= nameController.text;
      loading = true;
    });

    //print('url text ${urlController.text}');
    final dir = await _getDownloadDirectory();
    final isPermissionGranted = await _requestPermission(Permission.storage);
    if (isPermissionGranted) {
      final savePath = path.join(dir!.path, FileLink.fileName);
      await _startDownload(savePath);
    }
  }

  Future<void> _startDownload(String savePath) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    try {
      final resp = await _dio.download(
        FileLink.fileUrl,
        savePath,
        onReceiveProgress: _onReceiveProgress,
      );
      result['isSuccess'] = resp.statusCode == 200;
      result['filePath'] = savePath;
      print(resp.statusCode);
    } catch (e) {
      result['error'] = e.toString();
    } finally {
      //  await NotificationPlugin().showNotification(result);
      setState(() {
        loading = false;
        _progress = '-';
      });
    }
  }

  Future<Directory?> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }
    return await getApplicationDocumentsDirectory();
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    //buscarAtualizacoes();
    //NotificationPlugin().init();
  }

  @override
  Widget build(BuildContext context) {
    atualizacaoStore = Provider.of<AtualizacaoStore>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130.0),
        child: AppBar(
          flexibleSpace: Container(
            color: const Color.fromRGBO(44, 65, 68, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 110,
                ),
                Text(
                  'Versão ' + atualizacaoStore.versao! + ' disponível',
                  style: GoogleFonts.quicksand(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            InkWell(
                child: LottieBuilder.asset(
                  "assets/images/layer.json",
                  height: 70,
                ),
                onTap: () {
                  Get.defaultDialog(
                      title: "Ajuda",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Para realizar a atualização, clique no ícone localizado na parte inferior da tela.",
                            style: GoogleFonts.quicksand(
                                fontSize: 17, color: Colors.black),
                          ),
                        ],
                      ),
                      onCancel: () {},
                      textCancel: "Ok");
                }),
          ],
          leading: IconButton(
            onPressed: () {
              //Get.offAll(HomeSeparadorScreen());
              Get.back(closeOverlays: true);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Atualização',
            style: GoogleFonts.quicksand(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 40),
                  child: Form(
                      key: fromKey,
                      child: Column(children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Versão: " + atualizacaoStore.versao!,
                            style: GoogleFonts.quicksand(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Lançamento: " + atualizacaoStore.data!,
                            style: GoogleFonts.quicksand(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                            height: 160,
                            width: 600,
                            child: Container(
                              child: Column(children: [
                                Text(
                                  'Mudanças da versão: ',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  ' ' + atualizacaoStore.descricao!,
                                  style: GoogleFonts.quicksand(
                                      fontSize: 17, color: Colors.black),
                                ),
                              ]),
                            ))
                      ]))),
              Text(
                'Progresso do Download',
                style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                _progress,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () =>
            _download(atualizacaoStore.nome!, atualizacaoStore.url!),
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.green,
                backgroundColor: Colors.white,
              )
            : const Icon(Icons.file_download),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
