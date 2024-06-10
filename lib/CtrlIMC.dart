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

  void _getRegistro() async {
    db.collection('registro_peso').snapshots().listen((query) {
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

  void _deleteRegistro(String id) async {
    await db.collection('registro_peso').doc(id).delete();
  }

  Widget getItem(Map<String, dynamic> registro, String id) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          child: IconButton(
              onPressed: () async {
                _deleteRegistro(id);
              },
              icon: Icon(Icons.delete_outline_rounded)),
          borderRadius: BorderRadius.circular(50),
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
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.lightGreen[100]),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Registre o seu peso aqui:', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),),
                SizedBox(height: 10,),
                Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                              labelText: 'Insira o seu peso (kg)',
                              border: OutlineInputBorder()),
                        controller: controller, onSubmitted: _setRegistro)),
                 SizedBox(height: 25),
                const Text('Todos os seus registros:', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),),
                Expanded(
                    child: ListView.builder(
                  itemCount: listaRegistro.length,
                  itemBuilder: (_, indice) {
                    return getItem(listaRegistro[indice], listaId[indice]);
                  },
                ))
              ],
            ))));
  }
}
