import 'dart:convert';

class Separa {
  int? id;
  int? nrpreoc;
  String? ordemcarga;
  String? setor;
  int? codemp;
  int? sku;
  int? codprod;
  String? descrprod;
  String? controle;
  String? embalagem;
  String? codprodforn;
  String? codbarras;
  String? codbarraund;
  int? qtdneg;
  int? qtdnegund;
  int? idseparador;
  int? idconferente;
  String? nomeseparador;
  String? nomeconferente;
  String? status;
  String? qrcode;
  String? dtini;
  String? dtfim;
  String? statuschecagem;
  String? conferido;
  int? qtdsep;
  bool? atacado;

  Separa({
    this.id,
    this.nrpreoc,
    this.ordemcarga,
    this.setor,
    this.codemp,
    this.sku,
    this.codprod,
    this.descrprod,
    this.controle,
    this.embalagem,
    this.codprodforn,
    this.codbarras,
    this.codbarraund,
    this.qtdneg,
    this.qtdnegund,
    this.idseparador,
    this.idconferente,
    this.nomeseparador,
    this.nomeconferente,
    this.status,
    this.qrcode,
    this.dtini,
    this.dtfim,
    this.statuschecagem,
    this.conferido,
    this.qtdsep,
    this.atacado,
  });

  Separa copyWith({
    int? id,
    int? nrpreoc,
    String? ordemcarga,
    String? setor,
    int? codemp,
    int? sku,
    int? codprod,
    String? descrprod,
    String? controle,
    String? embalagem,
    String? codprodforn,
    String? codbarras,
    String? codbarraund,
    int? qtdneg,
    int? qtdnegund,
    int? idseparador,
    int? idconferente,
    String? nomeseparador,
    String? nomeconferente,
    String? status,
    String? qrcode,
    String? dtini,
    String? dtfim,
    String? statuschecagem,
    String? conferido,
    int? qtdsep,
    bool? atacado,
  }) {
    return Separa(
      id: id ?? this.id,
      nrpreoc: nrpreoc ?? this.nrpreoc,
      ordemcarga: ordemcarga ?? this.ordemcarga,
      setor: setor ?? this.setor,
      codemp: codemp ?? this.codemp,
      sku: sku ?? this.sku,
      codprod: codprod ?? this.codprod,
      descrprod: descrprod ?? this.descrprod,
      controle: controle ?? this.controle,
      embalagem: embalagem ?? this.embalagem,
      codprodforn: codprodforn ?? this.codprodforn,
      codbarras: codbarras ?? this.codbarras,
      codbarraund: codbarraund ?? this.codbarraund,
      qtdneg: qtdneg ?? this.qtdneg,
      qtdnegund: qtdnegund ?? this.qtdnegund,
      idseparador: idseparador ?? this.idseparador,
      idconferente: idconferente ?? this.idconferente,
      nomeseparador: nomeseparador ?? this.nomeseparador,
      nomeconferente: nomeconferente ?? this.nomeconferente,
      status: status ?? this.status,
      qrcode: qrcode ?? this.qrcode,
      dtini: dtini ?? this.dtini,
      dtfim: dtfim ?? this.dtfim,
      statuschecagem: statuschecagem ?? this.statuschecagem,
      conferido: conferido ?? this.conferido,
      qtdsep: qtdsep ?? this.qtdsep,
      atacado: atacado ?? this.atacado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nrpreoc': nrpreoc,
      'ordemcarga': ordemcarga,
      'setor': setor,
      'codemp': codemp,
      'sku': sku,
      'codprod': codprod,
      'descrprod': descrprod,
      'controle': controle,
      'embalagem': embalagem,
      'codprodforn': codprodforn,
      'codbarras': codbarras,
      'codbarraund': codbarraund,
      'qtdneg': qtdneg,
      'qtdnegund': qtdnegund,
      'idseparador': idseparador,
      'idconferente': idconferente,
      'nomeseparador': nomeseparador,
      'nomeconferente': nomeconferente,
      'status': status,
      'qrcode': qrcode,
      'dtini': dtini,
      'dtfim': dtfim,
      'statuschecagem': statuschecagem,
      'conferido': conferido,
      'qtdsep': qtdsep,
      'atacado': atacado,
    };
  }

  factory Separa.fromMap(Map<String, dynamic> map) {
    return Separa(
      id: map['id'],
      nrpreoc: map['nrpreoc'],
      ordemcarga: map['ordemcarga'],
      setor: map['setor'],
      codemp: map['codemp'],
      sku: map['sku'],
      codprod: map['codprod'],
      descrprod: map['descrprod'],
      controle: map['controle'],
      embalagem: map['embalagem'],
      codprodforn: map['codprodforn'],
      codbarras: map['codbarras'],
      codbarraund: map['codbarraund'],
      qtdneg: map['qtdneg'],
      qtdnegund: map['qtdnegund'],
      idseparador: map['idseparador'],
      idconferente: map['idconferente'],
      nomeseparador: map['nomeseparador'],
      nomeconferente: map['nomeconferente'],
      status: map['status'],
      qrcode: map['qrcode'],
      dtini: map['dtini'],
      dtfim: map['dtfim'],
      statuschecagem: map['statuschecagem'],
      conferido: map['conferido'],
      qtdsep: map['qtdsep'],
      atacado: map['atacado'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Separa.fromJson(String source) => Separa.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Separa(id: $id, nrpreoc: $nrpreoc, ordemcarga: $ordemcarga, setor: $setor, codemp: $codemp, sku: $sku, codprod: $codprod, descrprod: $descrprod, controle: $controle, embalagem: $embalagem, codprodforn: $codprodforn, codbarras: $codbarras, codbarraund: $codbarraund, qtdneg: $qtdneg, qtdnegund: $qtdnegund, idseparador: $idseparador, idconferente: $idconferente, nomeseparador: $nomeseparador, nomeconferente: $nomeconferente, status: $status, qrcode: $qrcode, dtini: $dtini, dtfim: $dtfim, statuschecagem: $statuschecagem, conferido: $conferido, qtdsep: $qtdsep, atacado: $atacado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Separa &&
      other.id == id &&
      other.nrpreoc == nrpreoc &&
      other.ordemcarga == ordemcarga &&
      other.setor == setor &&
      other.codemp == codemp &&
      other.sku == sku &&
      other.codprod == codprod &&
      other.descrprod == descrprod &&
      other.controle == controle &&
      other.embalagem == embalagem &&
      other.codprodforn == codprodforn &&
      other.codbarras == codbarras &&
      other.codbarraund == codbarraund &&
      other.qtdneg == qtdneg &&
      other.qtdnegund == qtdnegund &&
      other.idseparador == idseparador &&
      other.idconferente == idconferente &&
      other.nomeseparador == nomeseparador &&
      other.nomeconferente == nomeconferente &&
      other.status == status &&
      other.qrcode == qrcode &&
      other.dtini == dtini &&
      other.dtfim == dtfim &&
      other.statuschecagem == statuschecagem &&
      other.conferido == conferido &&
      other.qtdsep == qtdsep &&
      other.atacado == atacado;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nrpreoc.hashCode ^
      ordemcarga.hashCode ^
      setor.hashCode ^
      codemp.hashCode ^
      sku.hashCode ^
      codprod.hashCode ^
      descrprod.hashCode ^
      controle.hashCode ^
      embalagem.hashCode ^
      codprodforn.hashCode ^
      codbarras.hashCode ^
      codbarraund.hashCode ^
      qtdneg.hashCode ^
      qtdnegund.hashCode ^
      idseparador.hashCode ^
      idconferente.hashCode ^
      nomeseparador.hashCode ^
      nomeconferente.hashCode ^
      status.hashCode ^
      qrcode.hashCode ^
      dtini.hashCode ^
      dtfim.hashCode ^
      statuschecagem.hashCode ^
      conferido.hashCode ^
      qtdsep.hashCode ^
      atacado.hashCode;
  }
}
