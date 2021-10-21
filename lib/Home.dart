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
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "Resultado";

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    var url = Uri.parse("https://viacep.com.br/ws/${cepDigitado}/json/");
    http.Response response;

    response = await http.get(url);

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

    setState(() {
      _resultado =
          "${logradouro}, ${complemento}, ${bairro}, ${localidade}, ${uf}, ${ibge}, ${gia}, ${ddd}, ${siafi}";
    });

    print("Resposta Logradouro: ${logradouro} complemento: ${complemento}"
        "Bairro: ${bairro} Localidade: ${localidade} UF: ${uf}"
        "IBGE: ${ibge} GIA: ${gia} DDD: ${ddd} SIAFI: ${siafi}");
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
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep: ex: 30580460",
              ),
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _controllerCep,
            ),
            ElevatedButton(
              onPressed: _recuperarCep,
              child: Text("Clique Aqui"),
            ),
            Text(_resultado)
          ],
        ),
      ),
    );
  }
}
