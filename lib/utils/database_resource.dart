import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'produto_helper.dart';

class DatabaseResource {
  static Database? _database;
  static DatabaseResource? _databaseHelper;

  DatabaseResource._createInstance();

  factory DatabaseResource() {
    _databaseHelper ??= DatabaseResource._createInstance();

    return _databaseHelper!;
  }

  String nomeTabela = 'tb_produtos';
  String columnId = 'id';
  String columnNrpreoc = 'nrpreoc';
  String columnSku = 'sku';
  String columnCodemp = 'codemp';
  String columnCodprod = 'codprod';
  String columnControle = 'controle';
  String columnDescrprod = 'descrprod';
  String columnQtdneg = 'qtdneg';
  String columnCodbarras = 'codbarras';
  String columnEmbalagem = 'embalagem';
  String columnSeparador = 'idseparador';
  String columnConferente = 'idconferente';
  String columnStatus = 'status';
  String columnQrcode = 'qrcode';
  String columnDtini = 'dtini';
  String columnDtfim = 'dtfim';
  String columnStatuschecagem = 'statuschecagem';
  String columnQtdsep = 'qtdsep';
  String columnQtdconf = 'qtdconf';
  String columnConferido = 'conferido';
  String columnCodprodforn = 'codprodforn';
  String columnSetor = 'setor';
  String columnQtdnegund = 'qtdnegund';
  String columnCodbarraund = 'codbarraund';

  void _criarBanco(Database db, int version) async {
    String sql = """CREATE TABLE $nomeTabela (
                      $columnId INTEGER PRIMARY KEY,
                      $columnNrpreoc INTEGER,
                      $columnSku INTEGER,
                      $columnCodemp INTEGER,
                      $columnCodprod INTEGER,
                      $columnControle TEXT,
                      $columnDescrprod TEXT,
                      $columnQtdneg INTEGER,
                      $columnCodbarras TEXT,
                      $columnEmbalagem TEXT,
                      $columnSeparador INTEGER,
                      $columnConferente INTEGER,
                      $columnStatus TEXT,
                      $columnQrcode TEXT,
                      $columnDtini TEXT,
                      $columnDtfim TEXT,
                      $columnStatuschecagem TEXT,
                      $columnQtdsep INTEGER,
                      $columnConferido TEXT,
                      $columnCodprodforn TEXT,
                      $columnSetor TEXT,
                      $columnQtdconf INTEGER,
                      $columnQtdnegund INTEGER,
                      $columnCodbarraund TEXT
                    )
                """;

    await db.execute(sql);
  }

  Future<Database> inicializaBanco() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String caminho = directory.path + "topservicedb6";

    var bancodedados =
        await openDatabase(caminho, version: 1, onCreate: _criarBanco);

    return bancodedados;
  }

  Future<Database> get database async {
    _database ??= await inicializaBanco();
    return _database!;
  }

  Future<int> inserirSeparacao(ProdutoHelper obj) async {
    Database db = await database;
    var resposta = await db.insert(
      nomeTabela,
      obj.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return resposta;
  }

  Future<List<ProdutoHelper>> obterProdutos(
    int idsepconf,
    int nrpreoc,
    String setor,
  ) async {
    // get a reference to the database
    Database db = await database;

    // get all rows
    List<Map<String, dynamic>> maps = await db.query(
      nomeTabela,
      where:
          '$columnSeparador = ? AND $columnNrpreoc = ? AND $columnSetor = ? AND $columnStatuschecagem IS NULL',
      whereArgs: [idsepconf, nrpreoc, setor],
    );

    return List.generate(maps.length, (i) {
      return ProdutoHelper(
        id: maps[i]["id"],
        nrpreoc: maps[i]["nrpreoc"],
        sku: maps[i]["sku"],
        codemp: maps[i]["codemp"],
        codprod: maps[i]["codprod"],
        descrprod: maps[i]["descrprod"],
        controle: maps[i]["controle"],
        qtdneg: maps[i]["qtdneg"],
        codbarras: maps[i]["codbarras"],
        embalagem: maps[i]["embalagem"],
        idseparador: maps[i]["idseparador"],
        status: maps[i]["status"],
        qrcode: maps[i]["qrcode"],
        dtini: maps[i]["dtini"],
        dtfim: maps[i]["dtfim"],
        statuschecagem: maps[i]["statuschecagem"],
        qtdsep: maps[i]["qtdsep"],
        conferido: maps[i]["conferido"],
        codprodforn: maps[i]["codprodforn"],
        setor: maps[i]["setor"],
        qtdconf: maps[i]["qtdconf"],
        qtdnegund: maps[i]["qtdnegund"],
        codbarraund: maps[i]["codbarraund"],
      );
    });
  }

  Future<List<ProdutoHelper>> obterProdutosConferente(
    int nrpreoc,
    String setor,
  ) async {
    // get a reference to the database
    Database db = await database;

    // get all rows
    List<Map<String, dynamic>> maps = await db.query(
      nomeTabela,
      where:
          '$columnNrpreoc = ? AND $columnSetor = ? AND $columnConferido IS NULL',
      whereArgs: [nrpreoc, setor],
    );

    return List.generate(maps.length, (i) {
      return ProdutoHelper(
        id: maps[i]["id"],
        nrpreoc: maps[i]["nrpreoc"],
        sku: maps[i]["sku"],
        codemp: maps[i]["codemp"],
        codprod: maps[i]["codprod"],
        descrprod: maps[i]["descrprod"],
        controle: maps[i]["controle"],
        qtdneg: maps[i]["qtdneg"],
        codbarras: maps[i]["codbarras"],
        embalagem: maps[i]["embalagem"],
        idseparador: maps[i]["idseparador"],
        status: maps[i]["status"],
        qrcode: maps[i]["qrcode"],
        dtini: maps[i]["dtini"],
        dtfim: maps[i]["dtfim"],
        statuschecagem: maps[i]["statuschecagem"],
        qtdsep: maps[i]["qtdsep"],
        conferido: maps[i]["conferido"],
        codprodforn: maps[i]["codprodforn"],
        setor: maps[i]["setor"],
        qtdconf: maps[i]["qtdconf"],
        qtdnegund: maps[i]["qtdnegund"],
        codbarraund: maps[i]["codbarraund"],
      );
    });
  }

  Future<List<ProdutoHelper>> obterProdutosSeparados(
      int idsepconf, int nrpreoc, String setor) async {
    // get a reference to the database
    Database db = await database;

    // get all rows
    List<Map<String, dynamic>> maps = await db.query(
      nomeTabela,
      where:
          '$columnSeparador = ? AND $columnNrpreoc = ? AND $columnSetor = ? AND $columnStatuschecagem IS NOT NULL',
      whereArgs: [idsepconf, nrpreoc, setor],
    );

    return List.generate(maps.length, (i) {
      return ProdutoHelper(
        id: maps[i]["id"],
        nrpreoc: maps[i]["nrpreoc"],
        sku: maps[i]["sku"],
        codemp: maps[i]["codemp"],
        codprod: maps[i]["codprod"],
        descrprod: maps[i]["descrprod"],
        controle: maps[i]["controle"],
        qtdneg: maps[i]["qtdneg"],
        codbarras: maps[i]["codbarras"],
        embalagem: maps[i]["embalagem"],
        idseparador: maps[i]["idseparador"],
        status: maps[i]["status"],
        qrcode: maps[i]["qrcode"],
        dtini: maps[i]["dtini"],
        dtfim: maps[i]["dtfim"],
        statuschecagem: maps[i]["statuschecagem"],
        qtdsep: maps[i]["qtdsep"],
        conferido: maps[i]["conferido"],
        codprodforn: maps[i]["codprodforn"],
        setor: maps[i]["setor"],
        qtdconf: maps[i]["qtdconf"],
        qtdnegund: maps[i]["qtdnegund"],
        codbarraund: maps[i]["codbarraund"],
      );
    });
  }

  Future<List<ProdutoHelper>> obterProdutosConferidos(
      int idsepconf, int nrpreoc, String setor) async {
    // get a reference to the database
    Database db = await database;

    // get all rows
    List<Map<String, dynamic>> maps = await db.query(
      nomeTabela,
      where: '$columnNrpreoc = ? AND $columnSetor = ? AND $columnConferido = ?',
      whereArgs: [nrpreoc, setor, "S"],
    );

    return List.generate(maps.length, (i) {
      return ProdutoHelper(
        id: maps[i]["id"],
        nrpreoc: maps[i]["nrpreoc"],
        sku: maps[i]["sku"],
        codemp: maps[i]["codemp"],
        codprod: maps[i]["codprod"],
        descrprod: maps[i]["descrprod"],
        controle: maps[i]["controle"],
        qtdneg: maps[i]["qtdneg"],
        codbarras: maps[i]["codbarras"],
        embalagem: maps[i]["embalagem"],
        idseparador: maps[i]["idseparador"],
        status: maps[i]["status"],
        qrcode: maps[i]["qrcode"],
        dtini: maps[i]["dtini"],
        dtfim: maps[i]["dtfim"],
        statuschecagem: maps[i]["statuschecagem"],
        qtdsep: maps[i]["qtdsep"],
        conferido: maps[i]["conferido"],
        codprodforn: maps[i]["codprodforn"],
        setor: maps[i]["setor"],
        qtdconf: maps[i]["qtdconf"],
        qtdnegund: maps[i]["qtdnegund"],
        codbarraund: maps[i]["codbarraund"],
      );
    });
  }

  Future<List<ProdutoHelper>> separarProduto(
      String statuschecagem, int qtdsep, int id) async {
    Database db = await database;

    Map<String, dynamic> linha = {
      columnStatuschecagem: statuschecagem,
      columnQtdsep: qtdsep,
    };

    // get all rows
    await db.update(nomeTabela, linha, where: '$columnId = ?', whereArgs: [id]);

    List<Map<String, dynamic>> maps =
        await db.query(nomeTabela, where: '$columnId = ?', whereArgs: [id]);

    return List.generate(maps.length, (i) {
      return ProdutoHelper(
        id: maps[i]["id"],
        nrpreoc: maps[i]["nrpreoc"],
        sku: maps[i]["sku"],
        codemp: maps[i]["codemp"],
        codprod: maps[i]["codprod"],
        descrprod: maps[i]["descrprod"],
        controle: maps[i]["controle"],
        qtdneg: maps[i]["qtdneg"],
        codbarras: maps[i]["codbarras"],
        embalagem: maps[i]["embalagem"],
        idseparador: maps[i]["idseparador"],
        status: maps[i]["status"],
        qrcode: maps[i]["qrcode"],
        dtini: maps[i]["dtini"],
        dtfim: maps[i]["dtfim"],
        statuschecagem: maps[i]["statuschecagem"],
        qtdsep: maps[i]["qtdsep"],
        conferido: maps[i]["conferido"],
        codprodforn: maps[i]["codprodforn"],
        setor: maps[i]["setor"],
        qtdconf: maps[i]["qtdconf"],
        qtdnegund: maps[i]["qtdnegund"],
        codbarraund: maps[i]["codbarraund"],
      );
    });
  }

  Future<List<ProdutoHelper>> conferirProduto(
      int id, String conferido, int qtdconf) async {
    Database db = await database;

    Map<String, dynamic> linha = {
      columnConferido: conferido,
      columnQtdconf: qtdconf,
    };

    // get all rows
    await db.update(nomeTabela, linha, where: '$columnId = ?', whereArgs: [id]);

    List<Map<String, dynamic>> maps =
        await db.query(nomeTabela, where: '$columnId = ?', whereArgs: [id]);

    return List.generate(maps.length, (i) {
      return ProdutoHelper(
        id: maps[i]["id"],
        nrpreoc: maps[i]["nrpreoc"],
        sku: maps[i]["sku"],
        codemp: maps[i]["codemp"],
        codprod: maps[i]["codprod"],
        descrprod: maps[i]["descrprod"],
        controle: maps[i]["controle"],
        qtdneg: maps[i]["qtdneg"],
        codbarras: maps[i]["codbarras"],
        embalagem: maps[i]["embalagem"],
        idseparador: maps[i]["idseparador"],
        status: maps[i]["status"],
        qrcode: maps[i]["qrcode"],
        dtini: maps[i]["dtini"],
        dtfim: maps[i]["dtfim"],
        statuschecagem: maps[i]["statuschecagem"],
        qtdsep: maps[i]["qtdsep"],
        conferido: maps[i]["conferido"],
        codprodforn: maps[i]["codprodforn"],
        setor: maps[i]["setor"],
        qtdconf: maps[i]["qtdconf"],
        qtdnegund: maps[i]["qtdnegund"],
        codbarraund: maps[i]["codbarraund"],
      );
    });
  }

  Future<List<ProdutoHelper>> removerSeparacao(int id) async {
    Database db = await database;

    Map<String, dynamic> linha = {
      columnStatuschecagem: null,
      columnQtdsep: null,
      columnConferido: null,
      columnQtdconf: null
    };
    await db.update(nomeTabela, linha, where: '$columnId = ?', whereArgs: [id]);

    List<Map<String, dynamic>> maps =
        await db.query(nomeTabela, where: '$columnId = ?', whereArgs: [id]);

    return List.generate(maps.length, (i) {
      return ProdutoHelper(
        id: maps[i]["id"],
        nrpreoc: maps[i]["nrpreoc"],
        sku: maps[i]["sku"],
        codemp: maps[i]["codemp"],
        codprod: maps[i]["codprod"],
        descrprod: maps[i]["descrprod"],
        controle: maps[i]["controle"],
        qtdneg: maps[i]["qtdneg"],
        codbarras: maps[i]["codbarras"],
        embalagem: maps[i]["embalagem"],
        idseparador: maps[i]["idseparador"],
        status: maps[i]["status"],
        qrcode: maps[i]["qrcode"],
        dtini: maps[i]["dtini"],
        dtfim: maps[i]["dtfim"],
        statuschecagem: maps[i]["statuschecagem"],
        qtdsep: maps[i]["qtdsep"],
        conferido: maps[i]["conferido"],
        codprodforn: maps[i]["codprodforn"],
        setor: maps[i]["setor"],
        qtdconf: maps[i]["qtdconf"],
        qtdnegund: maps[i]["qtdnegund"],
        codbarraund: maps[i]["codbarraund"],
      );
    });
  }

  Future<List<ProdutoHelper>> removerConferencia(int id) async {
    Database db = await database;

    Map<String, dynamic> linha = {
      columnConferido: null,
      columnQtdconf: null,
    };
    await db.update(nomeTabela, linha, where: '$columnId = ?', whereArgs: [id]);

    List<Map<String, dynamic>> maps =
        await db.query(nomeTabela, where: '$columnId = ?', whereArgs: [id]);

    return List.generate(maps.length, (i) {
      return ProdutoHelper(
        id: maps[i]["id"],
        nrpreoc: maps[i]["nrpreoc"],
        sku: maps[i]["sku"],
        codemp: maps[i]["codemp"],
        codprod: maps[i]["codprod"],
        descrprod: maps[i]["descrprod"],
        controle: maps[i]["controle"],
        qtdneg: maps[i]["qtdneg"],
        codbarras: maps[i]["codbarras"],
        embalagem: maps[i]["embalagem"],
        idseparador: maps[i]["idseparador"],
        status: maps[i]["status"],
        qrcode: maps[i]["qrcode"],
        dtini: maps[i]["dtini"],
        dtfim: maps[i]["dtfim"],
        statuschecagem: maps[i]["statuschecagem"],
        qtdsep: maps[i]["qtdsep"],
        conferido: maps[i]["conferido"],
        codprodforn: maps[i]["codprodforn"],
        setor: maps[i]["setor"],
        qtdconf: maps[i]["qtdconf"],
        qtdnegund: maps[i]["qtdnegund"],
        codbarraund: maps[i]["codbarraund"],
      );
    });
  }

  // Future<void> deleteDados() async {
  //   // Get a reference to the database.
  //   final db = await database;

  //   String data = DateFormat("yyyy-MM-dd")
  //       .format(DateTime.now().subtract(Duration(days: 7)));

  //   print(data);

  //   // Remove the Dog from the database.
  //   await db.delete(
  //     nomeTabela,
  //     // Use a `where` clause to delete a specific dog.
  //     where: 'date($columnDtini) < ?',
  //     // Pass the Dog's id as a whereArg to prevent SQL injection.
  //     whereArgs: [data],
  //   );
  // }
}
