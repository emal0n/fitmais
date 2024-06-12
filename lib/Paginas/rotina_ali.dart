import 'package:flutter/material.dart';

// Página inicial do aplicativo
class FoodRoutineHomePage extends StatefulWidget {
  const FoodRoutineHomePage({super.key});

  @override
  createState() => _FoodRoutineHomePageState();
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
          title: const Text('Nova Lista de Alimentos'),
          content: TextField(
            controller: listController,
            decoration: const InputDecoration(hintText: "Nome da lista"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
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
              leading: const Icon(Icons.open_in_new),
              title: const Text('Abrir'),
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
              leading: const Icon(Icons.copy),
              title: const Text('Copiar'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Lista copiada para a área de transferência')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Deletar'),
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
      body: Container(
        color: const Color.fromARGB(255, 131, 180, 75),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
          child: ListView.builder(
            itemCount: foodLists.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(foodLists[index]),
                onTap: () => _openList(index),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showOptions(context, index),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewList,
        backgroundColor: const Color.fromARGB(255, 131, 180, 75),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Página de detalhes da lista
class ListDetailPage extends StatefulWidget {
  final String listName;

  const ListDetailPage({super.key, required this.listName});

  @override
  createState() => _ListDetailPageState();
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
        backgroundColor: const Color.fromARGB(255, 131, 180, 75),
      ),
      body: Container(
          color: const Color.fromARGB(255, 131, 180, 75),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: ListView.builder(
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
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewFood(context),
        backgroundColor: const Color.fromARGB(255, 131, 180, 75),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  // Adiciona um novo alimento à lista
  void _addNewFood(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddFoodPage(),
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

  const FoodList({super.key, required this.foods});

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

  const DayDetailPage(
      {super.key, required this.day, required this.foods, required this.onFoodAdded});

  @override
  createState() => _DayDetailPageState();
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
    TextEditingController editController =
        TextEditingController(text: widget.foods[index]);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Alimento'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: "Nome do alimento"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Concluído'),
              onPressed: () {
                setState(() {
                  widget.foods[index] = editController.text;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Deletar'),
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
          backgroundColor: const Color.fromARGB(255, 131, 180, 75),
        ),
        body: Container(
            color: const Color.fromARGB(255, 131, 180, 75),
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(70))),
              child: ListView.builder(
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
                      activeColor: const Color.fromARGB(255, 131, 180, 75),
                    ),
                    title: Text(food),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _editFood(context, index);
                      },
                    ),
                  );
                },
              ),
            )));
  }
}

// Página para adicionar um novo alimento
class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});

  @override
  createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final TextEditingController _foodController = TextEditingController();
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
          title: const Text('Adicionar Alimento'),
          backgroundColor: const Color.fromARGB(255, 131, 180, 75),
        ),
        body: Container(
            color: const Color.fromARGB(255, 131, 180, 75),
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(70))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                      controller: _foodController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Alimento',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
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
                      decoration: const InputDecoration(
                        labelText: 'Dia da semana',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_foodController.text.isNotEmpty) {
                          Navigator.pop(context, {
                            'day': _selectedDay,
                            'food': _foodController.text
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Por favor, insira o nome do alimento')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 131, 180, 75),
                      ),
                      child: const Text(
                        'Adicionar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
