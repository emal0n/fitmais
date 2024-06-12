import 'package:flutter/material.dart';


class DicasSaude extends StatelessWidget {
  const DicasSaude({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: const BoxDecoration(color: Color.fromARGB(255, 131, 180, 75)),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(70)) 
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'lib/Dumps/saude.png',
                  height: 240,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Beba água!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
               const Text(
                'O consumo adequado da água é fundamental em nosso dia dia',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black38,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Mantenha-se em movimento!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const Text(
                'Exercícios físicos trazem uma série de benefícios para nossa vida',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black38,
                  fontSize: 10,
                ),
              ),
            const SizedBox(height: 24),
              const Text(
                'Alimente-se bem',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const Text(
                '  É importante para ter uma alimentação saudável manter o equilíbrio entre os grupos alimentares',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black38,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 24),
             const Text(
                'Regule seu sono!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),

              const Text(
                ' Ter uma regulagem de sono é fundamental para o bem estar e saúde',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black38,
                  fontSize: 10,
                ),
              ),
               const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      ),
    );
  }
}