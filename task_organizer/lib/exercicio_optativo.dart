import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tarefas', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: const [
            RowWidget(
                color1: Colors.red, color2: Colors.green, color3: Colors.blue),
            RowWidget(
                color1: Colors.yellow,
                color2: Colors.orange,
                color3: Colors.purple),
            RowWidget(
                color1: Colors.cyan,
                color2: Colors.teal,
                color3: Colors.indigo),
            RowWidget(
                color1: Colors.pink,
                color2: Colors.amber,
                color3: Colors.brown),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {}),
      ),
    );
  }
}

class RowWidget extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Color color3;

  const RowWidget(
      {required this.color1,
      required this.color2,
      required this.color3,
      Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RowWidgetState createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SquareWidget(color: widget.color1),
        SquareWidget(color: widget.color2),
        SquareWidget(color: widget.color3),
      ],
    );
  }
}

class SquareWidget extends StatelessWidget {
  final Color color;

  const SquareWidget({required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: 100,
        height: 150,
        color: color,
      ),
    );
  }
}

class Task extends StatefulWidget {
  final String nome;
  const Task(this.nome, {super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            color: Colors.blue,
            height: 140,
          ),
          Column(
            children: [
              Container(
                color: Colors.white,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.black26,
                      width: 72,
                      height: 100,
                    ),
                    SizedBox(
                        width: 200,
                        child: Text(
                          widget.nome,
                          style: const TextStyle(fontSize: 24),
                          overflow: TextOverflow.ellipsis,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            nivel++;
                          });
                        },
                        child: const Icon(Icons.arrow_drop_up))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: nivel / 10,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Nivel: $nivel'),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
