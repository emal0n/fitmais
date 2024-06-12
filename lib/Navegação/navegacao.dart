
import 'package:fitmais/Paginas/saude.dart';
import 'package:fitmais/Paginas/rotina_ali.dart';
import 'package:flutter/material.dart';
import '../Paginas/controle_p.dart';
import '../Paginas/timer.dart';


class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  createState() => TelaPrincipalState();
}

class TelaPrincipalState extends State<TelaPrincipal> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DicasSaude(),
    const CtrlImc(),
    const Cronometro(),
    const FoodRoutineHomePage(),
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
        titleTextStyle: const TextStyle(
        fontSize: 40,
        fontWeight:FontWeight.w900,
        color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 131, 180, 75),
      ),
      body: _pages[_currentIndex],
      
      bottomNavigationBar: BottomNavigationBar(
       
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information_outlined),
            label: 'Dicas de Saúde',
            backgroundColor:  Color.fromARGB(255, 131, 180, 75),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.equalizer_rounded),
            label: 'Registro do Peso',
            backgroundColor:  Color.fromARGB(255, 131, 180, 75),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_sharp),
            label: 'Timer Meditação',
            backgroundColor:  Color.fromARGB(255, 131, 180, 75),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe_outlined),
            label: 'Rotina de Alimentação',
            backgroundColor:  Color.fromARGB(255, 131, 180, 75),
          ),
        ],
        
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.lightGreen[400],
        selectedFontSize: 10,
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
