import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_http_mapas/model/legend.dart';

class AddLegend extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nacionalityController = TextEditingController();
  final TextEditingController _championshipsWonController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("F1 Friends - Adicionar Lenda"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration:
                    InputDecoration(hintText: "Nome", labelText: "Nome"),
                controller: _nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira o nome da lenda';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nacionalityController,
                decoration: InputDecoration(
                    hintText: "Nacionalidade", labelText: "Nacionalidade"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira a nacionalidade da lenda';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _championshipsWonController,
                decoration: InputDecoration(
                    hintText: "Título de campeão",
                    labelText: "Título de campeão"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira o título relativo a quantidade de campeonatos vencidos';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Legend legend = Legend(
                          name: _nameController.text,
                          nacionality: _nacionalityController.text,
                          championshipsWon: _championshipsWonController.text);
                      Navigator.pop(context, legend);
                    }
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
