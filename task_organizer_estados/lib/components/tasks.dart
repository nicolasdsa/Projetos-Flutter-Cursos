import 'package:task_organizer_estados/components/difficulty.dart';
import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Tasks(this.nome, this.foto, this.dificuldade, {Key? key}) : super(key: key);

  int level = 1;
  int nivelDificuldade = 0;
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final List<Color> masteryColors = [
    Colors.blue, // Level 0
    Colors.green, // Level 1
    Colors.yellow, // Level 2
    Colors.orange, // Level 3
    Colors.red, // Level 4
  ];

  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }

    return true;
  }

  void levelUp() {
    setState(() {
      widget.level++;
      if ((widget.level / widget.dificuldade) / 10 == 1) {
        widget.level = 0;
        widget.nivelDificuldade++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color taskColor = masteryColors[widget.nivelDificuldade];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: taskColor,
            ),
            height: 140,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black12,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork()
                            ? Image.asset(
                                widget.foto,
                                height: 100,
                                width: 72,
                                fit: BoxFit.cover,
                              )
                            : Image.network(widget.foto, fit: BoxFit.cover),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.nome,
                            style: const TextStyle(
                                fontSize: 24, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Difficulty(widget.dificuldade),
                        // vai ser um novo componente.
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                          onPressed: levelUp,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: widget.dificuldade > 0
                            ? ((widget.level / widget.dificuldade) / 10)
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nivel: ${widget.level}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
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
