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

  //Checkout
  var _tipoOperacao = "D";
  
  void _setTipoOperacao(v) {
    setState(() {
      _tipoOperacao = v;    
    });
  }

  //DropDown
  List _centroCusto = ["Alimentação", "Educação", "Lazer"];
  List <DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCentroCusto;
  
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCentroCusto = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> itens = new List();
    for(String cc in _centroCusto) {
      itens.add(new DropdownMenuItem(
        value: cc,
        child: new Text(cc),
      ));
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        // padding: EdgeInsets.fromLTRB(10,5,10,20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                children: <Widget>[
                  Radio(
                      //#valor. #grupo, #ação
                      value: "C",
                      groupValue: _tipoOperacao,
                      onChanged: _setTipoOperacao),
                  Text("Débito"),
                  Radio(
                      //#valor. #grupo, #ação
                      value: "D",
                      groupValue: _tipoOperacao,
                      onChanged: _setTipoOperacao),
                  Text("Crédito"),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: new DropdownButton(
                value: _currentCentroCusto,
                items: _dropDownMenuItems,
                onChanged: (v){
                  setState(() {
                    _currentCentroCusto = v;
                  });
                },
              )),


            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: TextField(
                controller: cdescricao,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Descrição",
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: TextField(
                controller: cvalor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: _registrarDespesas,
        child: Icon(Icons.add),
      ),
    );
  }

  void _registrarDespesas() {
    Map<String, dynamic> item = Map();
    item['id'] = TimeOfDay.now().toString();
    item['descricao'] = cdescricao.text;
    item['tipo'] = _tipoOperacao;
    item['valor'] = cvalor.text;
    Navigator.pop(context, item);
  }
}
