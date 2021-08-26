import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _preco = "0";

  void _recuperarPreco()  async {
    var uri = Uri.parse("https://blockchain.info/ticker");
    var response = await http.get(uri);

    Map<String, dynamic> dados = jsonDecode(response.body);

    setState(() {
      this._preco = dados["BRL"]["buy"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/bitcoin.png"),
              Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                    "R\$ ${this._preco}",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                ),
                  onPressed: _recuperarPreco,
                  child: Text(
                      "Atualizar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
