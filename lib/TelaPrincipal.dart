import 'package:flutter/material.dart';
import 'CtrlIMC.dart';
import 'timer.dart';


class TelaPrincipal extends StatefulWidget {
  @override
  TelaPrincipalState createState() => TelaPrincipalState();
}

class TelaPrincipalState extends State<TelaPrincipal> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    
    CtrlImc(),
    Cronometro()

  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fit+'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
       
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information_outlined),
            label: 'Dicas de Saúde',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe_outlined),
            label: 'Rotina de Alimentação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer_rounded),
            label: 'Controle IMC',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_sharp),
            label: 'Timer Meditação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_rounded),
            label: 'Plano de Treino',
          ),
        ],
        
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.amber,
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
