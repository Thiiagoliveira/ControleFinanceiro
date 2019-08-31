import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Controle",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: _listaGastos.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
              secondary: CircleAvatar(
                  child: Icon(
                      _listaGastos[index]['tipo'] == 'D' ? Icons.remove : Icons.add,
                      color: Colors.white,
                      ),
                  backgroundColor: _listaGastos[index]['tipo'] == 'D'
                      ? Color(0xffDB4437)
                      : Colors.green),
              title: Text("${_listaGastos[index]['descricao']} \$${_listaGastos[index]['valor']}"),
              value: false,
              onChanged: (c) {});
        },
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
