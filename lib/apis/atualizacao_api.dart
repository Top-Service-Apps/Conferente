import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:teste_tela/models/atualizacao.dart';
import 'package:teste_tela/stores/atualizacao_store.dart';

abstract class AtualizacaoApi {
  static Future<void> buscarAtualizacoes(
      AtualizacaoStore atualizacaoStore) async {
    List<Atualizacao> lista = [];
    var response = await Dio().getUri(Uri(
      scheme: "http",
      host: "192.168.1.11",
      port: 480,
      path: "/atualizacoes",
    ));
    final data = jsonDecode(response.data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data["data"]) {
        //print(response.data);
        lista.add(Atualizacao.fromMap(i));
        lista.length - 1;
        Atualizacao ultimo = lista[lista.length - 1];
        atualizacaoStore.versao = ultimo.versao;
        atualizacaoStore.url = ultimo.url;
        atualizacaoStore.nome = ultimo.nome;
        atualizacaoStore.data = ultimo.data;
        atualizacaoStore.descricao = ultimo.descricao;
      }
      Atualizacao ultimo = lista[lista.length - 1];
      atualizacaoStore.versao = ultimo.versao;
      atualizacaoStore.url = ultimo.url;
      atualizacaoStore.nome = ultimo.nome;
      atualizacaoStore.data = ultimo.data;
      atualizacaoStore.descricao = ultimo.descricao;
    }
  }
}
