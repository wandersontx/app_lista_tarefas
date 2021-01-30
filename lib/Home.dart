import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = [];

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  _salvarArquivo() async {
    Map<String, dynamic> tarefa = Map();
    var arquivo = await _getFile();
    tarefa['titulo'] = 'Ir ao mercado';
    tarefa['realizada'] = false;
    _listaTarefas.add(tarefa);

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);
  }

  _lerArquivo() async {
    try {
      var arquivo = await _getFile();
      return arquivo.readAsString();
    } catch (e) {
      print('Erro ao recuperar dados: ' + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _lerArquivo().then((dados) {
      setState(() {
        _listaTarefas = json.decode(dados);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //_salvarArquivo();
    print('itens: ' + _listaTarefas.toString());

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
                    title: Text(_listaTarefas[index]['titulo']),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
