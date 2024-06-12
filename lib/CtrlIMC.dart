import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class CtrlImc extends StatefulWidget {
  @override
  CtrlImcState createState() => CtrlImcState();
}

class CtrlImcState extends State<CtrlImc> {
  List<Map<String, dynamic>> listaRegistro = [];
  List<String> listaId = [];
  TextEditingController controller = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  Uuid uuid = const Uuid();

  //FUNÇÃO PARA INSERIR REGISTRO NO BANCO DE DADOS BASEADO EM UM PARÂMETRO
  void _setRegistro(String massa) async {
    String uuidV4 = uuid.v4();
    DateTime dateTime = DateTime.now();
    DateFormat formatoData = DateFormat('dd/MM/yyyy | HH:mm');

    db
        .collection('registro_peso')
        .doc(uuidV4)
        .set({'massa_kg': massa, 'data_hora': formatoData.format(dateTime)});

    controller.clear();
  }


  //FUNÇÃO PARA PEGAR OS REGISTROS DO BANCO DE DADOS E INSERIR NUMA LISTA
  void _getRegistro() async {
    db.collection('registro_peso').orderBy('data_hora', descending: true).
    snapshots().
    listen((query) {
      List<Map<String, dynamic>> tempList = [];
      List<String> tempListId = [];

      query.docs.forEach((doc) {
        var data = doc.data() as Map<String, dynamic>;

        tempListId.add(doc.id);
        tempList.add({
          'massa_kg': data['massa_kg'],
          'data_hora': data['data_hora'],
        });
      });


      setState(() {
        listaId = tempListId;
        listaRegistro = tempList;
      });
    });
  }


  //FUNÇÃO PARA DELETAR UM DETERMINADO REGISTRO BASEADO NO ID DO DOCUMENTO
  void _deleteRegistro(String id) async {
    await db.collection('registro_peso').doc(id).delete();
  }


  //FUNÇÃO PARA CONSTRUIR O CARD COM OS DADOS INSERIDOS NAS LISTAS E SUA RESPECTIVA POSIÇÃO
  Widget getItem(Map<String, dynamic> registro, String id) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          
            child: Container(
              decoration: const BoxDecoration(color:Color.fromARGB(255, 131, 180, 75), 
                borderRadius: BorderRadius.all(
                  Radius.circular(20)
                )
              ),

              child: IconButton(
                color: Colors.white,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Aviso!', style: TextStyle(fontWeight: FontWeight.bold),),
                        content: const Text('Deseja excluir o registro?'),
                        actions: [
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Excluir'),
                            onPressed: () {
                              _deleteRegistro(id);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  
                },
                icon: Icon(Icons.delete_outline_rounded),
                
              ),)
              
        ),
        title: Text(
          '${registro['massa_kg']} Kg',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text(registro['data_hora']),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getRegistro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 131, 180, 75)),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
             // borderRadius: BorderRadius.only(topLeft: Radius.circular(70)) 
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Registre o seu peso aqui:',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: const InputDecoration(
                            labelText: 'Insira o seu peso (kg)',
                            border: OutlineInputBorder()),
                        controller: controller,
                        keyboardType: TextInputType.phone,
                        onSubmitted: _setRegistro)),
                const SizedBox(height: 25),
                const Text(
                  'Todos os seus registros:',
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 20),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: listaRegistro.length,
                  itemBuilder: (_, indice) {
                    return getItem(listaRegistro[indice], listaId[indice]);
                  },
                ))
              ],
            )))));
  }
}
