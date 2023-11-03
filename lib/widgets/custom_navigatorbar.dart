import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:notes_crud_local_app/providers/student_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);
    final StudentProvider studentProvider = Provider.of(context, listen: false);
    final currentIndex = actualOptionProvider.selectedOption;

    return BottomNavigationBar(
      backgroundColor: Colors.green,
      selectedItemColor: Colors.yellow,
      //Current Index, para determinar el botón que debe marcarse
      currentIndex: currentIndex,
      onTap: (int i) {
        if(i == 1){
          studentProvider.resetStudentData();
        }        
        actualOptionProvider.selectedOption = i;        
      },
      //Items
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Listar Estudiantes"),
        BottomNavigationBarItem(icon: Icon(Icons.post_add_rounded), label: "Crear Eestudiante"),
        BottomNavigationBarItem(icon: Icon(Icons.accessibility), label: "Detalles Estudiante")
      ],
    );
  }
}
