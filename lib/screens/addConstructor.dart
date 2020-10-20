
import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_http_mapas/model/constructor.dart';

class AddConstructor extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Construtor"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Nome",
                    labelText: "Nome"
                ),
                controller: _nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira o nome do construtor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(
                    hintText: "Motor",
                    labelText: "Motor"
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira o motor do carro';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Constructor constructor = Constructor(
                          _nameController.text,
                          _brandController.text
                      );
                      Navigator.pop(context, constructor);
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