import 'package:mobx/mobx.dart';
import 'package:teste_tela/apis/atualizacao_api.dart';

part 'atualizacao_store.g.dart';

class AtualizacaoStore = _AtualizacaoStore with _$AtualizacaoStore;

abstract class _AtualizacaoStore with Store {
  @observable
  String? url;

  @observable
  String? versao;

  @observable
  String? nome;

  @observable
  int? id;

  @observable
  String? data;

  @observable
  String? descricao;

  @action
  verificar(AtualizacaoStore atualizacaoStore) async {
    await AtualizacaoApi.buscarAtualizacoes(atualizacaoStore);
  }
}
