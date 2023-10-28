import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:provider/provider.dart';

import '../providers/notes_provider.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CreateForm();
  }
}

class _CreateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return Container(
        child: Form(
      key: notesProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: notesProvider.title,
            decoration: const InputDecoration(
                hintText: 'Construir Apps',
                labelText: 'Titulo',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) => notesProvider.title = value,
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          SizedBox(height: 30),
          TextFormField(
            maxLines: 10,
            autocorrect: false,
            initialValue: notesProvider.description,
            // keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Aprender sobre Dart...',
              labelText: 'Descripción',
            ),
            onChanged: (value) => notesProvider.description = value,
            validator: (value) {
              return (value != null) ? null : 'El campo no puede estar vacío';
            },
          ),
          SizedBox(height: 30),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    notesProvider.isLoading ? 'Espere' : 'Ingresar',
                    style: TextStyle(color: Colors.white),
                  )),
              onPressed: notesProvider.isLoading
                  ? null
                  : () async {
                      //Quitar teclado al terminar
                      FocusScope.of(context).unfocus();

                      if (!notesProvider.isValidForm()) return;

                      if(notesProvider.createOrUpdate == 'create'){
                        await notesProvider.addNote();
                      }else{
                        await notesProvider.updateNote();
                      }

                      notesProvider.isLoading = false;
                      Provider.of<ActualOptionProvider>(context, listen: false).selectedOption = 0;
                    })
        ],
      ),
    ));
  }
}
