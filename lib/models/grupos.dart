import 'dart:convert';

class Grupo {
  String? setor;
  int? qtd;

  Grupo({
    this.setor,
    this.qtd,
  });

  Map<String, dynamic> toMap() {
    return {
      'setor': setor,
      'qtd': qtd,
    };
  }

  factory Grupo.fromMap(Map<String, dynamic> map) {
    return Grupo(
      setor: map['setor'],
      qtd: map['qtd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Grupo.fromJson(String source) => Grupo.fromMap(json.decode(source));
}
