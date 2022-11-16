// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atualizacao_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AtualizacaoStore on _AtualizacaoStore, Store {
  final _$urlAtom = Atom(name: '_AtualizacaoStore.url');

  @override
  String? get url {
    _$urlAtom.reportRead();
    return super.url;
  }

  @override
  set url(String? value) {
    _$urlAtom.reportWrite(value, super.url, () {
      super.url = value;
    });
  }

  final _$versaoAtom = Atom(name: '_AtualizacaoStore.versao');

  @override
  String? get versao {
    _$versaoAtom.reportRead();
    return super.versao;
  }

  @override
  set versao(String? value) {
    _$versaoAtom.reportWrite(value, super.versao, () {
      super.versao = value;
    });
  }

  final _$nomeAtom = Atom(name: '_AtualizacaoStore.nome');

  @override
  String? get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String? value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$idAtom = Atom(name: '_AtualizacaoStore.id');

  @override
  int? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$dataAtom = Atom(name: '_AtualizacaoStore.data');

  @override
  String? get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(String? value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$descricaoAtom = Atom(name: '_AtualizacaoStore.descricao');

  @override
  String? get descricao {
    _$descricaoAtom.reportRead();
    return super.descricao;
  }

  @override
  set descricao(String? value) {
    _$descricaoAtom.reportWrite(value, super.descricao, () {
      super.descricao = value;
    });
  }

  final _$verificarAsyncAction = AsyncAction('_AtualizacaoStore.verificar');

  @override
  Future verificar(AtualizacaoStore atualizacaoStore) {
    return _$verificarAsyncAction.run(() => super.verificar(atualizacaoStore));
  }

  @override
  String toString() {
    return '''
url: ${url},
versao: ${versao},
nome: ${nome},
id: ${id},
data: ${data},
descricao: ${descricao}
    ''';
  }
}
