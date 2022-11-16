import 'dart:convert';

class PreocLiberadas {
  int qtd;
  int preoc;
  String status;

  PreocLiberadas({
    required this.qtd,
    required this.preoc,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'qtd': qtd,
      'preoc': preoc,
      'status': status,
    };
  }

  factory PreocLiberadas.fromMap(Map<String, dynamic> map) {
    return PreocLiberadas(
      qtd: map['qtd'],
      preoc: map['preoc'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PreocLiberadas.fromJson(String source) =>
      PreocLiberadas.fromMap(json.decode(source));
}
