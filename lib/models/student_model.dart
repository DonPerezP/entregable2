// To parse this JSON data, do
//
//     final estudiantes = estudiantesFromJson(jsonString);

import 'dart:convert';

List<Estudiantes> estudiantesFromJson(String str) => List<Estudiantes>.from(json.decode(str).map((x) => Estudiantes.fromJson(x)));

String estudiantesToJson(List<Estudiantes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Estudiantes {
    int? id;
    String docIdentidad;
    String nombre;
    String edad;

    Estudiantes({
        required this.id,
        required this.docIdentidad,
        required this.nombre,
        required this.edad,
    });

    factory Estudiantes.fromJson(Map<String, dynamic> json) => Estudiantes(
        id: json["id"],
        docIdentidad: json["docIdentidad"],
        nombre: json["nombre"],
        edad: json["edad"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "docIdentidad": docIdentidad,
        "nombre": nombre,
        "edad": edad,
    };

  void add(Estudiantes estudiantes) {}
}
