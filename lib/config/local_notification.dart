// ignore_for_file: prefer_const_declarations, duplicate_ignore
/*
import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isIOS) {
      requestPermission();
    }
    // ignore: prefer_const_constructors
    final android = AndroidInitializationSettings('ic_circle');
    // ignore: prefer_const_declarations
    final iOS = const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      /*onDidReceiveLocalNotification: (id, title, body, payload) async{
          ReceivedNotification receivedNotification = ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          );
          didReceiveLocalNotification.add(receivedNotification);
        }*/
    );

    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
  }

  requestPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _onSelectNotification(String? json) async {
    // todo: handling clicked notification
    final obj = jsonDecode(json!);
    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    }
  }

  Future<void> showNotification(Map<String, dynamic> status) async {
    final android = const AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      'CHANNEL_DESC',
    );
    final iOS = const IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(status);
    final isSuccess = status['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
      0,
      isSuccess ? 'Atualização baixada com sucesso' : 'Falha no Download',
      isSuccess
          ? 'Download concluido, clique para instalar a atualização'
          : 'Ocorreu um erro no Download da atualização',
      platform,
      payload: json,
    );
  }
}

/*
class ReceivedNotification{
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}*/

*/