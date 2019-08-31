import 'dart:convert';
import 'dart:io';
import 'package:financeiro/helpers/transacao_helper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cadastro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TransacaoHelper tHelper = TransacaoHelper();
  List<Transacao> _listaGastos = [];
  int _corD;
  int _corC;

  @override
  void initState() {
    setCoresB();
    loadGastos();
    super.initState();
  }

  void setCoresB() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    // spref.clear();
    if (spref.getInt("corDebito") == null) {
      spref.setInt("corDebito", 0xffDB4437);
    }
    if (spref.getInt("corCredito") == null) {
      spref.setInt("corCredito", 0xFF008000);
    }

    _corC = spref.getInt("corCredito");
    _corD = spref.getInt("corDebito");
  }

  //Map -> String
  void loadGastos() {
    tHelper.getAlltransacaos().then((list) {
      setState(() {
        _listaGastos = list;
      });
    });
  }

  void _cadastro({Transacao item}) async {
    final _goCadastro = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Cadastro(
                  transacaoUpdate: item,
                )));

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
                    ? Color(_corD)
                    : Color(_corC)),
            title: Text(
                "${_listaGastos[index].descricao} \$${_listaGastos[index].valor}"),
            onTap: () {
              _cadastro(item: _listaGastos[index]);
            },
          );
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
