import 'package:flutter/widgets.dart';
import 'package:task_organizer_estados/components/tasks.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Tasks> taskList = [
    Tasks('Aprender Flutter',
        'assets/images/st,small,507x507-pad,600x600,f8f8f8.jpg', 3),
    Tasks('Andar de Bike', 'assets/images/bike.webp', 2),
    Tasks('Meditar', 'assets/images/meditar.jpeg', 5),
    Tasks('Ler', 'assets/images/ler.jpg', 4),
    Tasks('Jogar', 'assets/images/jogar.jpg', 1),
  ];

  void newTask(String name, String image, int difficulty) {
    taskList.add(Tasks(name, image, difficulty));
  }

  //Serve para acessar o estado de qualquer lugar do app
  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  //Fica de olho no estado anterior e atualiza se necessário
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
