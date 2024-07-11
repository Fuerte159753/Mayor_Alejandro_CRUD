import 'package:crud_notas/db/operaciones.dart';
import 'package:crud_notas/modelos/notas.dart';
import 'package:flutter/material.dart';

class GuardarPagina extends StatelessWidget {
  const GuardarPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guardar Nota'),
        backgroundColor: Colors.blueGrey,
      ),
      body: const GuardarFormulario(),
    );
  }
}

class GuardarFormulario extends StatefulWidget {
  const GuardarFormulario({super.key});

  @override
  State<GuardarFormulario> createState() => _GuardarFormularioState();
}

class _GuardarFormularioState extends State<GuardarFormulario> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _tituloController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese un título';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Título de la Nota',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descripcionController,
              maxLength: 1000,
              maxLines: 4,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese una descripción';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Descripción de la Nota',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Guardar Nota'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Guardando Nota')),
                  );

                  Operaciones.insertarOperacion(
                    Nota(
                      titulo: _tituloController.text,
                      descripcion: _descripcionController.text,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
