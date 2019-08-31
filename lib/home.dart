import 'dart:convert';
import 'dart:io';
import 'package:financeiro/helpers/transacao_helper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'cadastro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TransacaoHelper tHelper = TransacaoHelper();
  List<Transacao> _listaGastos = [];

  @override
  void initState() {
    super.initState();
    loadGastos();
    //(Tipo) Descrição Valor
    //(R) Picole 2.50
  }

  //Map -> String
  void loadGastos() {
    tHelper.getAlltransacaos().then((list) {
      setState(() {
        _listaGastos = list;
      });
    });
  }

  void _cadastro() async {
    final _goCadastro = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Cadastro()));

    if (_goCadastro) {
      loadGastos();
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
          return ListTile(
              leading: CircleAvatar(
                  child: Icon(
                    _listaGastos[index].tipo == 'D' ? Icons.remove : Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: _listaGastos[index].tipo == 'D'
                      ? Color(0xffDB4437)
                      : Colors.green),
              title: Text(
                  "${_listaGastos[index].descricao} \$${_listaGastos[index].valor}"));
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
}
