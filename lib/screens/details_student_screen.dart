import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

class DetailsStudentScreen extends StatelessWidget {
  const DetailsStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DetailsStudent();
  }
}

class _DetailsStudent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final StudentProvider studentProvider = Provider.of<StudentProvider>(context);
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: studentProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [                 
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: studentProvider.docIdentidad,
            decoration: const InputDecoration(
                hintText: 'Hola Profe x3',
                labelText: 'Documento de identidad',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),            
          ),
          const SizedBox(height: 30),
          TextFormField(
            //maxLines: 10,
            autocorrect: false,
            initialValue: studentProvider.nombre,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Hola Profe x4',
              labelText: 'Nombre Completo',
            ),            
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: studentProvider.edad,
            decoration: const InputDecoration(
                hintText: '¿Seras mas viejo que yo?',
                labelText: 'Edad',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),            
          ),
          const SizedBox(height: 30),
          
        ],
      ),
    );
  }

}

