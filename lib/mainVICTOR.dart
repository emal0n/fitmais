import 'package:flutter/material.dart';


class FoodRoutineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotina de Consumo de Alimentos',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FoodRoutineHomePage(),
    );
  }
}

// Página inicial do aplicativo
class FoodRoutineHomePage extends StatefulWidget {
  @override
  _FoodRoutineHomePageState createState() => _FoodRoutineHomePageState();
}

class _FoodRoutineHomePageState extends State<FoodRoutineHomePage> {
  // Lista de listas de alimentos
  List<String> foodLists = [];

  // Adiciona uma nova lista de alimentos
  void _addNewList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController listController = TextEditingController();
        return AlertDialog(
          title: Text('Nova Lista de Alimentos'),
          content: TextField(
            controller: listController,
            decoration: InputDecoration(hintText: "Nome da lista"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Adicionar'),
              onPressed: () {
                setState(() {
                  foodLists.add(listController.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Exibe as opções de lista
  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.open_in_new),
              title: Text('Abrir'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListDetailPage(
                      listName: foodLists[index],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text('Copiar'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lista copiada para a área de transferência')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Deletar'),
              onTap: () {
                setState(() {
                  foodLists.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Abre uma lista específica
  void _openList(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListDetailPage(
          listName: foodLists[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotina de Consumo de Alimentos'),
      ),
      body: ListView.builder(
        itemCount: foodLists.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foodLists[index]),
            onTap: () => _openList(index),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => _showOptions(context, index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewList,
        child: Icon(Icons.add),
      ),
    );
  }
}

// Página de detalhes da lista
class ListDetailPage extends StatefulWidget {
  final String listName;

  ListDetailPage({required this.listName});

  @override
  _ListDetailPageState createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<ListDetailPage> {
  List<String> daysOfWeek = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sábado',
    'Domingo',
  ];

  Map<String, List<String>> foodsByDay = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listName),
      ),
      body: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          String day = daysOfWeek[index];
          return ListTile(
            title: Text(day),
            subtitle: FoodList(foods: foodsByDay[day] ?? []),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayDetailPage(
                    day: day,
                    foods: foodsByDay[day] ?? [],
                    onFoodAdded: (food) {
                      setState(() {
                        if (foodsByDay.containsKey(day)) {
                          foodsByDay[day]!.add(food);
                        } else {
                          foodsByDay[day] = [food];
                        }
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewFood(context),
        child: Icon(Icons.add),
      ),
    );
  }

  // Adiciona um novo alimento à lista
  void _addNewFood(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFoodPage(),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        String day = result['day']!;
        String food = result['food']!;
        if (foodsByDay.containsKey(day)) {
          foodsByDay[day]!.add(food);
        } else {
          foodsByDay[day] = [food];
        }
      });
    }
  }
}

// Widget para exibir uma lista de alimentos
class FoodList extends StatelessWidget {
  final List<String> foods;

  FoodList({required this.foods});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: foods.map((food) => Text(food)).toList(),
    );
  }
}

// Página de detalhes do dia
class DayDetailPage extends StatefulWidget {
  final String day;
  final List<String> foods;
  final Function(String) onFoodAdded;

  DayDetailPage({required this.day, required this.foods, required this.onFoodAdded});

  @override
  _DayDetailPageState createState() => _DayDetailPageState();
}

class _DayDetailPageState extends State<DayDetailPage> {
  late List<bool> _consumed;

  @override
  void initState() {
    super.initState();
    _consumed = List<bool>.filled(widget.foods.length, false);
  }

  // Edita um alimento
  void _editFood(BuildContext context, int index) async {
    TextEditingController editController = TextEditingController(text: widget.foods[index]);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Alimento'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: "Nome do alimento"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Concluído'),
              onPressed: () {
                setState(() {
                  widget.foods[index] = editController.text;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Deletar'),
              onPressed: () {
                setState(() {
                  widget.foods.removeAt(index);
                  _consumed.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.day),
      ),
      body: ListView.builder(
        itemCount: widget.foods.length,
        itemBuilder: (context, index) {
          String food = widget.foods[index];
          return ListTile(
            leading: Checkbox(
              value: _consumed[index],
              onChanged: (value) {
                setState(() {
                  _consumed[index] = value!;
                });
              },
            ),
            title: Text(food),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editFood(context, index);
              },
            ),
          );
        },
      ),
    );
  }
}

// Página para adicionar um novo alimento
class AddFoodPage extends StatefulWidget {
  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  TextEditingController _foodController = TextEditingController();
  String _selectedDay = 'Segunda-feira';

  @override
  void dispose() {
    _foodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Alimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _foodController,
              decoration: InputDecoration(
                labelText: 'Alimento',
                border: OutlineInputBorder(),
                              ),
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              value: _selectedDay,
              items: [
                'Segunda-feira',
                'Terça-feira',
                'Quarta-feira',
                'Quinta-feira',
                'Sexta-feira',
                'Sábado',
                'Domingo',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedDay = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Dia da semana',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_foodController.text.isNotEmpty) {
                  Navigator.pop(context, {'day': _selectedDay, 'food': _foodController.text});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, insira o nome do alimento')),
                  );
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
