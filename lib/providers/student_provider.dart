import 'package:flutter/material.dart';

import '../models/student_model.dart';
import 'db_provider.dart';

class StudentProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String createOrUpdate = 'create';
  int? id;
  String docIdentidad = '';
  String nombre = '';
  String edad = '';

  bool _isLoading = false;
  List<Estudiantes> estudiantes = [];

  bool get isLoading => _isLoading;

  set isLoading(bool opc) {
    _isLoading = opc;
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    return formKey.currentState?.validate() ?? false;
  }

  addStudent() async {
    final Estudiantes estudiantes = Estudiantes(
        docIdentidad: docIdentidad, nombre: nombre, edad: edad, id: null);

    final id = await DBProvider.db.newStudent(estudiantes);

    estudiantes.id = id;

    estudiantes.add(estudiantes);

    notifyListeners();
  }

  loadStudents() async {
    final List<Estudiantes> estudiantes = await DBProvider.db.getAllStudents();
    //operador Spreed
    this.estudiantes = [...estudiantes];
    notifyListeners();
  }

  updateStudent() async {
    final estudiantes = Estudiantes(
        id: id, docIdentidad: docIdentidad, nombre: nombre, edad: edad);
    final res = await DBProvider.db.updateStudent(estudiantes);
    print("Id actualizado: $res");
    loadStudents();
  }

  deleteStudentById(int id) async {
    final res = await DBProvider.db.deleteStudent(id);
    loadStudents();
  }

  assignDataWithStudent(Estudiantes estudiantes) {
    id = estudiantes.id;
    docIdentidad = estudiantes.docIdentidad;
    nombre = estudiantes.nombre;
    edad = estudiantes.edad;
  }

  resetStudentData() {
    id = null;
    docIdentidad = '';
    nombre = '';
    edad = '';
    createOrUpdate = 'create';
  }
}
