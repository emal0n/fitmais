import 'package:flutter/material.dart';
import 'dart:async';

class Cronometro extends StatefulWidget {
  const Cronometro({super.key});

  @override
  createState() => _CronometroState();
}

class _CronometroState extends State<Cronometro> {

  final TextEditingController _controller = TextEditingController();
  late Timer _timer;
  int _totalTime = 0;
  int _remainingTime = 0; 
  bool _isRunning = false;

  void _startTimer() {
    int minutes = int.tryParse(_controller.text) ?? 0;
    _totalTime = minutes * 60;
    _remainingTime = _totalTime;

    if (_remainingTime > 0) {
      setState(() {
        _isRunning = true;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingTime > 0) {
            _remainingTime--;
          } else {
            _timer.cancel();
            _isRunning = false;
          }
        });
      });
    }
  }

  void _stopTimer() {
    if (_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void _resetTimer() {
    if (_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
    setState(() {
      _remainingTime = 0;
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value:
                            _totalTime == 0 ? 1.0 : _remainingTime / _totalTime,
                        strokeWidth: 10,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 131, 180, 75)),
                      ),
                    ),
                    Text(
                      _formatTime(_remainingTime),
                      style: const TextStyle(
                          fontSize: 48.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  if (!_isRunning) ...[
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Minutos para você meditar...',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                  onTap: _startTimer,
                  child: Container(
                      decoration: BoxDecoration(
                        color:const Color.fromARGB(255, 131, 180, 75),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: const Center(
                        child: Text(
                          'INICIAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ))),
                  ] else ...[
                  GestureDetector(
                  onTap: _stopTimer,
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 131, 180, 75),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: const Center(
                        child: Text(
                          'PARAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ))),
                    const SizedBox(height: 20.0),
                     GestureDetector(
                  onTap: _resetTimer,
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 131, 180, 75),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: const Center(
                        child: Text(
                          'RESETAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ))),
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      ),
    );
  }
}
