import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String transacaoTable = "transacaoTable";
final String idColumn = "idColumn";
final String valorColumn = "valorColumn";
final String dataColumn = "dataColumn";
final String descricaoColumn = "descricaoColumn";
final String tipoColumn = "tipoColumn";
final String centroCustoColumn = "centroCusto";

class TransacaoHelper {
  static final TransacaoHelper _instance = TransacaoHelper.internal();

  factory TransacaoHelper() => _instance;

  TransacaoHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "transacaos.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $transacaoTable($idColumn INTEGER PRIMARY KEY, $valorColumn REAL, $descricaoColumn TEXT,"
          "$tipoColumn TEXT, $dataColumn TEXT)");
    });
  }

  Future<Transacao> savetransacao(Transacao transacao) async {
    Database dbTransacao = await db;
    transacao.id = await dbTransacao.insert(transacaoTable, transacao.toMap());
    return transacao;
  }

  Future<Transacao> gettransacao(int id) async {
    Database dbTransacao = await db;
    List<Map> maps = await dbTransacao.query(transacaoTable,
        columns: [
          idColumn,
          valorColumn,
          descricaoColumn,
          tipoColumn,
          dataColumn
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Transacao.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deletetransacao(int id) async {
    Database dbTransacao = await db;
    return await dbTransacao
        .delete(transacaoTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updatetransacao(Transacao transacao) async {
    Database dbTransacao = await db;
    return await dbTransacao.update(transacaoTable, transacao.toMap(),
        where: "$idColumn = ?", whereArgs: [transacao.id]);
  }

  Future<List> getAlltransacaos() async {
    Database dbTransacao = await db;
    List listMap = await dbTransacao.rawQuery("SELECT * FROM $transacaoTable");
    List<Transacao> listtransacao = List();
    for (Map m in listMap) {
      listtransacao.add(Transacao.fromMap(m));
    }
    return listtransacao;
  }

  Future<int> getNumber() async {
    Database dbTransacao = await db;
    return Sqflite.firstIntValue(
        await dbTransacao.rawQuery("SELECT COUNT(*) FROM $transacaoTable"));
  }

  Future close() async {
    Database dbTransacao = await db;
    dbTransacao.close();
  }
}

class Transacao {
  int id;
  double valor;
  String data;
  String tipo;
  String descricao;

  Transacao();

  Transacao.fromMap(Map map) {
    id = map[idColumn];
    valor = map[valorColumn];
    data = map[dataColumn];
    descricao = map[descricaoColumn];
    tipo = map[tipoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      valorColumn: valor,
      dataColumn: data,
      descricaoColumn: descricao,
      tipoColumn: tipo
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "transacao(id: $id, valor: $valor, data: $data, descricao: $descricao, tipo: $tipo)";
  }
}
