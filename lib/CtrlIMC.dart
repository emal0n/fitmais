import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CtrlImc extends StatefulWidget {
  @override
  CtrlImcState createState() => CtrlImcState();
}

class CtrlImcState extends State<CtrlImc> {
  List<Map<String, dynamic>> listaRegistro = [];
  TextEditingController controller = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  Uuid uuid = const Uuid();

  void _setRegistro(String massa) async {
    String uuidV4 = uuid.v4();
    DateTime dateTime = DateTime.now();

    db
        .collection('registro_peso')
        .doc(uuidV4)
        .set({'massa_kg': massa, 'data_hora': dateTime.toIso8601String()});

    controller.clear();
  }


  void _getRegistro() async {
    db.collection('registro_peso').snapshots().listen((query) {
      List<Map<String, dynamic>> tempList = [];

  
      query.docs.forEach((doc) {
        var data = doc.data() as Map<String, dynamic>;

    
        tempList.add({
          'massa_kg': data['massa_kg'],
          'data_hora': data['data_hora'],
        });
      });

    
      setState(() {
        listaRegistro = tempList;
      });
    });
  }

  Widget getItem(Map<String, dynamic> registro) {
    //DateTime datahora = registro['data_hora'];

    return Card(
      child: ListTile(
        leading: ClipRRect(
          //child: Image.asset('lib/assets/images/menina.jpg'),
          borderRadius: BorderRadius.circular(50),
        ),
        title: Text('KG: ${registro['massa_kg']}'),
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
      appBar: AppBar(
        title: const Text('Registros de Peso'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(8.0),
              child:
                  TextField(controller: controller, onSubmitted: _setRegistro)),
          Expanded(
              child: ListView.builder(
            itemCount: listaRegistro.length,
            itemBuilder: (_, indice) {
              return getItem(listaRegistro[indice]);
            },
          ))
        ],
      ),
    );
  }
}

class RegistroMassa {
  late String massa;
  late DateTime data;

  RegistroMassa(String massa) {
    this.massa = massa;
    this.data = DateTime.now();
  }
}

class RegistroPraLista {
  late String massa;
  late DateTime data;

  RegistroPraLista(this.massa, this.data);
}
