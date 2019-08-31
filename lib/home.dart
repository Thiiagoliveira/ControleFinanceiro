import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'cadastro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaGastos = [];

  @override
  void initState() {
    super.initState();
    loadGastos();
    //(Tipo) Descrição Valor
    //(R) Picole 2.50
  }

  //Map -> String
  void loadGastos() {
    Map<String, dynamic> item = Map();
    item['id'] = 1;
    item['descricao'] = 'Picole';
    item['tipo'] = 'D';
    item['valor'] = 1.5;
    _listaGastos.add(item);

    item = Map();
    item['id'] = 2;
    item['descricao'] = 'Sorvete';
    item['tipo'] = 'D';
    item['valor'] = 3.5;
    _listaGastos.add(item);

    item = Map();
    item['id'] = 3;
    item['descricao'] = 'Salario';
    item['tipo'] = 'C';
    item['valor'] = 1000;
    _listaGastos.add(item);
  }

  void _cadastro() async {
    final _goCadastro = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Cadastro()));

    if (_goCadastro != null) {
      // debugPrint(_goCadastro['id']);
      // debugPrint(_goCadastro['descricao']);
      _listaGastos.add(_goCadastro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App: Controler",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: _listaGastos.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
              secondary: CircleAvatar(
                  child: Icon(
                    _listaGastos[index]['tipo'] == 'D'
                        ? Icons.remove
                        : Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: _listaGastos[index]['tipo'] == 'D'
                      ? Color(0xffDB4437)
                      : Colors.green),
              title: Text(
                  "${_listaGastos[index]['descricao']} \$${_listaGastos[index]['valor']}"),
              value: false,
              onChanged: (c) {});
        },
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          _cadastro();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  Future<File> _salvarItens() async {
    String dados = json.encode(_listaGastos);
    final arquivo = await _getFile();
    return arquivo.writeAsString(dados);
  }

  Future<String> _lerItens() async {
    try {
      final arquivo = await _getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }
}
