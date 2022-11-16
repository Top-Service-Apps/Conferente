
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_tela/controllers/conferente/loading_conferente_controller.dart';
import 'package:teste_tela/controllers/login_controller.dart';
import 'package:teste_tela/screens/login/login_screen.dart';
import 'package:teste_tela/screens/usuarios/conferente/usuarios_screen.dart';
import 'package:teste_tela/stores/atualizacao_store.dart';

class DrawerHomeConferente extends StatefulWidget {
  final LoginController loginController;

  const DrawerHomeConferente({Key? key, required this.loginController})
      : super(key: key);

  @override
  _DrawerHomeConferenteState createState() => _DrawerHomeConferenteState();
}

class _DrawerHomeConferenteState extends State<DrawerHomeConferente> {
  late AtualizacaoStore atualizacaoStore;
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  final loadingConferenteController = Get.put(LoadingConferenteController());

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    loadingConferenteController.buscarQtdUsuarios();
    _initPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    atualizacaoStore = Provider.of<AtualizacaoStore>(context);
    atualizacaoStore.verificar(atualizacaoStore);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/lider.png",
                  width: 50,
                  height: 50,
                ),
                Text(
                  widget.loginController.nomeusu.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Ionicons.home,
              color: Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Ionicons.person,
              color: Colors.green,
            ),
            title: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Disponíveis",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "QTD:\t${loadingConferenteController.usuariosD}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Get.offAll(const UsuariosScreen(status: "D", atribuindo: false));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Ionicons.person,
              color: Colors.orange,
            ),
            title: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Em Separação",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "QTD:\t${loadingConferenteController.usuariosO}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Get.offAll(const UsuariosScreen(status: "E", atribuindo: false));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Ionicons.person,
              color: Colors.blue,
            ),
            title: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Atribuídos",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "QTD:\t${loadingConferenteController.usuariosA}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Get.offAll(const UsuariosScreen(status: "A", atribuindo: false));
            },
          ),
          const Divider(),
          ListTile(
            leading: Badge(
              badgeContent: _packageInfo.version != atualizacaoStore.versao
                  ? const Text(
                      '!',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  : const Text(''),
              badgeColor: _packageInfo.version != atualizacaoStore.versao
                  ? Colors.green
                  : Colors.white,
              elevation: 0,
              child: const Icon(
                MaterialIcons.system_update,
                color: Colors.black,
              ),
            ),
            title: const Text(
              "Verificar atualizações existentes",
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              if (_packageInfo.version == atualizacaoStore.versao) {
                Get.defaultDialog(
                  title: "Atualização inexistente",
                  content: const Text(
                    "Não existem atualizações disponíveis",
                    maxLines: 1,
                  ),
                  onCancel: () {},
                  textCancel: "Ok",
                  confirmTextColor: Colors.white,
                );
              } else {
                Get.defaultDialog(
                    title: "Atualização existente",
                    content: const Text("Deseja atualizar o aplicativo?"),
                    onCancel: () {},
                    textCancel: "Não",
                    onConfirm: () {
                      //     Get.to(DownloadPage());
                      //  downloadFile;
                      //  print('aa'+ progress.toString(),);
                    },

                    //   () => _launchLink('https://www.dropbox.com/s/uez8jttejvmsbnc/app-release.apk?dl=1'),

                    textConfirm: "Sim",
                    confirmTextColor: Colors.white);
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Ionicons.exit_outline,
              color: Colors.black,
            ),
            title: Text(
              "Sair",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
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
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
