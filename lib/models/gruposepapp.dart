import 'dart:convert';

class GrupoSepApp {
  int? id;
  String? status;
  String? setor;
  int? preoc;
  String? ordemcarga;
  int? qtde;
  String? qrcode;
  int? idseparador;
  String? nomeseparador;
  int? idconferente;
  String? nomeconferente;
  GrupoSepApp({
    this.id,
    this.status,
    this.setor,
    this.preoc,
    this.ordemcarga,
    this.qtde,
    this.qrcode,
    this.idseparador,
    this.nomeseparador,
    this.idconferente,
    this.nomeconferente,
  });

  GrupoSepApp copyWith({
    int? id,
    String? status,
    String? setor,
    int? preoc,
    String? ordemcarga,
    int? qtde,
    String? qrcode,
    int? idseparador,
    String? nomeseparador,
    int? idconferente,
    String? nomeconferente,
  }) {
    return GrupoSepApp(
      id: id ?? this.id,
      status: status ?? this.status,
      setor: setor ?? this.setor,
      preoc: preoc ?? this.preoc,
      ordemcarga: ordemcarga ?? this.ordemcarga,
      qtde: qtde ?? this.qtde,
      qrcode: qrcode ?? this.qrcode,
      idseparador: idseparador ?? this.idseparador,
      nomeseparador: nomeseparador ?? this.nomeseparador,
      idconferente: idconferente ?? this.idconferente,
      nomeconferente: nomeconferente ?? this.nomeconferente,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'setor': setor,
      'preoc': preoc,
      'ordemcarga': ordemcarga,
      'qtde': qtde,
      'qrcode': qrcode,
      'idseparador': idseparador,
      'nomeseparador': nomeseparador,
      'idconferente': idconferente,
      'nomeconferente': nomeconferente,
    };
  }

  factory GrupoSepApp.fromMap(Map<String, dynamic> map) {
    return GrupoSepApp(
      id: map['id'],
      status: map['status'],
      setor: map['setor'],
      preoc: map['preoc'],
      ordemcarga: map['ordemcarga'],
      qtde: map['qtde'],
      qrcode: map['qrcode'],
      idseparador: map['idseparador'],
      nomeseparador: map['nomeseparador'],
      idconferente: map['idconferente'],
      nomeconferente: map['nomeconferente'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GrupoSepApp.fromJson(String source) =>
      GrupoSepApp.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GrupoSepApp(id: $id, status: $status, setor: $setor, preoc: $preoc, ordemcarga: $ordemcarga, qtde: $qtde, qrcode: $qrcode, idseparador: $idseparador, nomeseparador: $nomeseparador, idconferente: $idconferente, nomeconferente: $nomeconferente)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GrupoSepApp &&
        other.id == id &&
        other.status == status &&
        other.setor == setor &&
        other.preoc == preoc &&
        other.ordemcarga == ordemcarga &&
        other.qtde == qtde &&
        other.qrcode == qrcode &&
        other.idseparador == idseparador &&
        other.nomeseparador == nomeseparador &&
        other.idconferente == idconferente &&
        other.nomeconferente == nomeconferente;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        setor.hashCode ^
        preoc.hashCode ^
        ordemcarga.hashCode ^
        qtde.hashCode ^
        qrcode.hashCode ^
        idseparador.hashCode ^
        nomeseparador.hashCode ^
        idconferente.hashCode ^
        nomeconferente.hashCode;
  }
}
