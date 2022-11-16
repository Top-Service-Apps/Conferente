import 'dart:convert';

import 'Usuario.dart';

class SepConf {
  final int? idsepconf;
  final String? dtlogin;
  final String? dtlogoff;
  final String? setor;
  final String? tipo;
  final String? status;
  final String? ativo;
  final Usuario? usuario;

  SepConf({
    this.idsepconf,
    this.dtlogin,
    this.dtlogoff,
    this.setor,
    this.tipo,
    this.status,
    this.ativo,
    this.usuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'idsepconf': idsepconf,
      'dtlogin': dtlogin,
      'dtlogoff': dtlogoff,
      'setor': setor,
      'tipo': tipo,
      'status': status,
      'ativo': ativo,
      'usuario': usuario?.toMap(),
    };
  }

  factory SepConf.fromMap(Map<String, dynamic> map) {
    return SepConf(
      idsepconf: map['idsepconf'],
      dtlogin: map['dtlogin'],
      dtlogoff: map['dtlogoff'],
      setor: map['setor'],
      tipo: map['tipo'],
      status: map['status'],
      ativo: map['ativo'],
      usuario: Usuario.fromMap(map['usuario']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SepConf.fromJson(String source) =>
      SepConf.fromMap(json.decode(source));
}
