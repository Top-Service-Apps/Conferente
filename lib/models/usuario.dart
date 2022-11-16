import 'dart:convert';

class Usuario {
  final int? codusu;
  final String? nomeusu;
  final String? email;

  Usuario(
    this.codusu,
    this.nomeusu,
    this.email,
  );

  Map<String, dynamic> toMap() {
    return {
      'codusu': codusu,
      'nomeusu': nomeusu,
      'email': email,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      map['codusu'],
      map['nomeusu'],
      map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));
}
