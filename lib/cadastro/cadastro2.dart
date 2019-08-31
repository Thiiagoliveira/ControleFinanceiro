import 'package:flutter/material.dart';

//Alteração - Stateful
class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  final cdescricao = TextEditingController();
  final ctipo = TextEditingController();
  final cvalor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: cdescricao,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Descrição",
              labelStyle: TextStyle(
                color: Colors.blueGrey,
              )
            ),
          ),
          TextField(
            controller: ctipo,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tipo',
              labelStyle: TextStyle(
                color: Colors.blueGrey,
              )
            ),
          ),
          TextField(
            controller: cvalor,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Valor',
              labelStyle: TextStyle(color: Colors.blueGrey),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          _registrarDespesas;
          // debugPrint(cdescricao.text);
          // debugPrint(ctipo.text);
          // debugPrint(cvalor.text);
          // debugPrint(cvalor.toString());
        },
        child: Icon(Icons.add),
      ),
    );
  }
  void _registrarDespesas(){
    
  }
}