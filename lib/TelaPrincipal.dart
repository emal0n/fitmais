import 'dart:ui';

import 'package:fitmais/Dicas_saude.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'CtrlIMC.dart';
import 'timer.dart';


class TelaPrincipal extends StatefulWidget {
  @override
  TelaPrincipalState createState() => TelaPrincipalState();
}

class TelaPrincipalState extends State<TelaPrincipal> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    
    DicasSaude(),
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
        titleTextStyle: TextStyle(
        fontSize: 40,
        fontWeight:FontWeight.w900,
        color: Colors.black,
        ),
        backgroundColor: Colors.lightGreen[100],
      ),
      body: _pages[_currentIndex],
      
      bottomNavigationBar: BottomNavigationBar(
       
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information_outlined),
            label: 'Dicas de Saúde',
            backgroundColor:  Colors.black,
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.equalizer_rounded),
            label: 'Controle IMC',
            backgroundColor:  Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_sharp),
            label: 'Timer Meditação',
            backgroundColor:  Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe_outlined),
            label: 'Rotina de Alimentação',
            backgroundColor:  Colors.black,
          ),
        ],
        
        selectedItemColor: Colors.lightGreen[100],
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
