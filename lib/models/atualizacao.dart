import 'dart:convert';

class Atualizacao {
  String? url;
  String? versao;
  String? nome;
  int? id;
  String? data;
  String? descricao;

  Atualizacao({
    this.url,
    this.versao,
    this.nome,
    this.id,
    this.data,
    this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'versao': versao,
      'nome': nome,
      'id': id,
      'data': data,
      'descricao': descricao,
    };
  }

  factory Atualizacao.fromMap(Map<String, dynamic> map) {
    return Atualizacao(
      url: map['url'],
      versao: map['versao'],
      nome: map['nome'],
      id: map['id'],
      data: map['data'],
      descricao: map['descricao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Atualizacao.fromJson(String source) =>
      Atualizacao.fromMap(json.decode(source));
}
