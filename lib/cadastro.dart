import 'package:financeiro/helpers/transacao_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

//Alteração - Stateful
class Cadastro extends StatefulWidget {
  final Transacao transacaoUpdate;

  //Construtor:
  Cadastro({this.transacaoUpdate});
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TransacaoHelper tHelper = TransacaoHelper();

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
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCentroCusto;

  Transacao _transacaoEdit;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCentroCusto = _dropDownMenuItems[0].value;

    if (widget.transacaoUpdate != null) {
      _transacaoEdit = Transacao.fromMap(widget.transacaoUpdate.toMap());
      cdescricao.text = _transacaoEdit.descricao;
      cvalor.text = _transacaoEdit.valor.toString();
      _tipoOperacao =  _transacaoEdit.tipo;
      _currentCentroCusto = _transacaoEdit.centroCusto;
    }

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> itens = new List();
    for (String cc in _centroCusto) {
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
                  Text("Crédito"),
                  Radio(
                      //#valor. #grupo, #ação
                      value: "D",
                      groupValue: _tipoOperacao,
                      onChanged: _setTipoOperacao),
                  Text("Débito"),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: new DropdownButton(
                  value: _currentCentroCusto,
                  items: _dropDownMenuItems,
                  onChanged: (v) {
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

  void _registrarDespesas() async {
    Map<String, dynamic> item = Map();

    // item[idColumn] = TimeOfDay.now().toString();
    item[descricaoColumn] = cdescricao.text;
    item[tipoColumn] = _tipoOperacao;
    item[valorColumn] = double.parse(cvalor.text);
    item[dataColumn] = DateFormat("dd-mm-yyyy").format(DateTime.now());
    item[centroCustoColumn] = _currentCentroCusto;

    Transacao t;
    if(_transacaoEdit == null){
      t = Transacao.fromMap(item);
      t = await tHelper.savetransacao(t);
      Fluttertoast.showToast(
        msg: "Atualizado com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
      Navigator.pop(context, t.id != null ? true : false);  
    } else {
      item[idColumn] = _transacaoEdit.id;
      t = Transacao.fromMap(item);
      int i = await tHelper.updatetransacao(t);
      Fluttertoast.showToast(
        msg: "Atualizado com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
      debugPrint(i.toString());
      Navigator.pop(context, i != 0 ? true : false);
    }
  }
}