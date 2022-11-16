import 'dart:convert';

class CorteSepara {
  int? id;
  int? nrpreoc;
  int? sku;
  int? codprod;
  String? controle;
  String? descrprod;
  String? codbarras;
  String? embalagem;
  String? codprodforn;
  String? setor;
  int? separador;
  int? conferente;
  int? qtdcorte;
  int? qtdreconferida;

  CorteSepara({
    this.id,
    this.nrpreoc,
    this.sku,
    this.codprod,
    this.controle,
    this.descrprod,
    this.codbarras,
    this.embalagem,
    this.codprodforn,
    this.setor,
    this.separador,
    this.conferente,
    this.qtdcorte,
    this.qtdreconferida,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nrpreoc': nrpreoc,
      'sku': sku,
      'codprod': codprod,
      'controle': controle,
      'descrprod': descrprod,
      'codbarras': codbarras,
      'embalagem': embalagem,
      'codprodforn': codprodforn,
      'setor': setor,
      'separador': separador,
      'conferente': conferente,
      'qtdcorte': qtdcorte,
      'qtdreconferida': qtdreconferida,
    };
  }

  factory CorteSepara.fromMap(Map<String, dynamic> map) {
    return CorteSepara(
      id: map['id'],
      nrpreoc: map['nrpreoc'],
      sku: map['sku'],
      codprod: map['codprod'],
      controle: map['controle'],
      descrprod: map['descrprod'],
      codbarras: map['codbarras'],
      embalagem: map['embalagem'],
      codprodforn: map['codprodforn'],
      setor: map['setor'],
      separador: map['separador'],
      conferente: map['conferente'],
      qtdcorte: map['qtdcorte'],
      qtdreconferida: map['qtdreconferida'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CorteSepara.fromJson(String source) =>
      CorteSepara.fromMap(json.decode(source));
}
