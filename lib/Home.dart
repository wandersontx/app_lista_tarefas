import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = ['Ir ao mercado', 'Estudar', 'Exercício do dia'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Lista de tarefas'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Adicionar Tarefa'),
                  content: TextField(
                    decoration: InputDecoration(labelText: 'Digite sua tarefa'),
                    onChanged: (text) {},
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancelar'),
                    ),
                    FlatButton(
                      onPressed: () {
                        //logica para salvar os dados
                        Navigator.pop(context);
                      },
                      child: Text('Salvar'),
                    ),
                  ],
                );
              });
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _listaTarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_listaTarefas[index]),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
