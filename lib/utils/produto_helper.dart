import 'dart:convert';

class ProdutoHelper {
  int? id;
  int? nrpreoc;
  int? sku;
  int? codemp;
  int? codprod;
  String? controle;
  String? descrprod;
  int? qtdneg;
  String? codbarras;
  String? embalagem;
  int? idseparador;
  int? idconferente;
  String? status;
  String? qrcode;
  String? dtini;
  String? dtfim;
  String? statuschecagem;
  int? qtdsep;
  String? conferido;
  String? codprodforn;
  String? setor;
  int? qtdconf;
  int? qtdnegund;
  String? codbarraund;

  ProdutoHelper({
    this.id,
    this.nrpreoc,
    this.sku,
    this.codemp,
    this.codprod,
    this.controle,
    this.descrprod,
    this.qtdneg,
    this.codbarras,
    this.embalagem,
    this.idseparador,
    this.idconferente,
    this.status,
    this.qrcode,
    this.dtini,
    this.dtfim,
    this.statuschecagem,
    this.qtdsep,
    this.conferido,
    this.codprodforn,
    this.setor,
    this.qtdconf,
    this.qtdnegund,
    this.codbarraund,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nrpreoc': nrpreoc,
      'sku': sku,
      'codemp': codemp,
      'codprod': codprod,
      'controle': controle,
      'descrprod': descrprod,
      'qtdneg': qtdneg,
      'codbarras': codbarras,
      'embalagem': embalagem,
      'idseparador': idseparador,
      'idconferente': idconferente,
      'status': status,
      'qrcode': qrcode,
      'dtini': dtini,
      'dtfim': dtfim,
      'statuschecagem': statuschecagem,
      'qtdsep': qtdsep,
      'conferido': conferido,
      'codprodforn': codprodforn,
      'setor': setor,
      'qtdconf': qtdconf,
      'qtdnegund': qtdnegund,
      'codbarraund': codbarraund,
    };
  }

  factory ProdutoHelper.fromMap(Map<String, dynamic> map) {
    return ProdutoHelper(
      id: map['id'],
      nrpreoc: map['nrpreoc'],
      sku: map['sku'],
      codemp: map['codemp'],
      codprod: map['codprod'],
      controle: map['controle'],
      descrprod: map['descrprod'],
      qtdneg: map['qtdneg'],
      codbarras: map['codbarras'],
      embalagem: map['embalagem'],
      idseparador: map['idseparador'],
      idconferente: map['idconferente'],
      status: map['status'],
      qrcode: map['qrcode'],
      dtini: map['dtini'],
      dtfim: map['dtfim'],
      statuschecagem: map['statuschecagem'],
      qtdsep: map['qtdsep'],
      conferido: map['conferido'],
      codprodforn: map['codprodforn'],
      setor: map['setor'],
      qtdconf: map['qtdconf'],
      qtdnegund: map['qtdnegund'],
      codbarraund: map['codbarraund'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoHelper.fromJson(String source) =>
      ProdutoHelper.fromMap(json.decode(source));
}
