import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import '../models/student_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //Obteniendo direccion base donde se guardará la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //Armamos la url donde quedará la base de datos
    final path = join(documentsDirectory.path, 'EstudiantesDB.db');

    //Imprimos ruta
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) => {},
      onCreate: (db, version) async {
        await db.execute('''

        CREATE TABLE estudiantes(
          id INTEGER PRIMARY KEY,
          docIdentidad TEXT,
          nombre TEXT,
          edad TEXT
        )

''');
      },
    );
  }

  Future<int> newStudentRaw(Estudiantes estudiantes) async {
    final int? id = estudiantes.id;
    final String docIdentidad = estudiantes.docIdentidad;
    final String nombre = estudiantes.nombre;
    final String edad = estudiantes.edad;

    final db =
        await database; //Recibimos instancia de base de datos para trabajar con ella

    final int res = await db.rawInsert('''

      INSERT INTO Estudiantes (id, docIdentidad, nombre, edad) VALUES ($id, "$docIdentidad", "$nombre", "$edad")

''');
    print(res);
    return res;
  }

  Future<int> newStudent(Estudiantes estudiantes) async {
    final db = await database;

    final int res = await db.insert("Estudiantes", estudiantes.toJson());

    return res;
  }

  //Obtener un registro por id
  Future<Estudiantes?> getStudentById(int id) async {
    final Database db = await database;

    //usando Query para construir la consulta, con where y argumentos posicionales (whereArgs)
    final res = await db.query('Estudiantes', where: 'id = ?', whereArgs: [id]);
    print(res);
    //Preguntamos si trae algun dato. Si lo hace
    return res.isNotEmpty ? Estudiantes.fromJson(res.first) : null;
  }

  Future<List<Estudiantes>> getAllStudents() async {
    final Database? db = await database;
    final res = await db!.query('Estudiantes');
    //Transformamos con la funcion map instancias de nuestro modelo. Si no existen registros, devolvemos una lista vacia
    return res.isNotEmpty ? res.map((n) => Estudiantes.fromJson(n)).toList() : [];
  }

  Future<int> updateStudent(Estudiantes estudiantes) async {
    final Database db = await database;
    //con updates, se usa el nombre de la tabla, seguido de los valores en formato de Mapa, seguido del where con parametros posicionales y los argumentos finales
    final res = await db
        .update('Estudiantes', estudiantes.toJson(), where: 'id = ?', whereArgs: [estudiantes.id]);
    return res;
  }

  Future<int> deleteStudent(int id) async {
    final Database db = await database;
    final int res = await db.delete('Estudiantes', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllStudents() async {
    final Database db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Estudiantes    
    ''');
    return res;
  }
}
