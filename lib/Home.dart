import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuperarCep() async {
    var url = Uri.parse("https://viacep.com.br/ws/30580460/json/");
    http.Response response;

    response = await http.get(url);

    //print("Resposta: " + response.statusCode.toString());

    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    String ibge = retorno["ibge"];
    String gia = retorno["gia"];
    String ddd = retorno["ddd"];
    String siafi = retorno["siafi"];

    print("Resposta Logradouro: ${logradouro} complemento: ${complemento}"
        "Bairro: ${bairro} Localidade: ${localidade} UF: ${uf}"
        "IBGE: ${ibge} GIA: ${gia} DDD: ${ddd} SIAFI: ${siafi}");

    //print("Resposta: " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo Serviços Web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _recuperarCep,
              child: Text("Clique Aqui"),
            )
          ],
        ),
      ),
    );
  }
}
