import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_http_mapas/model/driver.dart';

class AddDriver extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nacionalityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("F1 Friends - Adicionar Piloto"),
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
                  //se retornar texto, o validador do formulário entende como erro
                  //e vai mostrar embaixo do campo na cor vermelha
                  if (value.isEmpty) {
                    return 'Insira o nome do piloto';
                  }

                  //aqui é o único momento na vida do dev flutter que o null
                  //é algo bom. Ou seja, null, está tudo certo e o validador
                  //segue a sua vida
                  return null;
                },
              ),
              TextFormField(
                controller: _nacionalityController,
                decoration: InputDecoration(
                    hintText: "Nacionalidade", labelText: "Nacionalidade"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira a nacionalidade do piloto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration:
                    InputDecoration(hintText: "Idade", labelText: "Idade"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira a idade do piloto';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Driver driver = Driver(
                          name: _nameController.text,
                          nacionality: _nacionalityController.text,
                          age: _ageController.text);
                      Navigator.pop(context, driver);
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
