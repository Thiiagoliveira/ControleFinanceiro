import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  List _listGastos = [];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App:: 1",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: _listGastos.length,
          itemBuilder: (context, index) {
            return Container();
          }),
      // Container(
      //   child: Text(
      //     "Gabriel",
      //     style: TextStyle(fontSize: 50)
      //   ),
      // ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
