import 'package:crud_notas/db/operaciones.dart';
import 'package:crud_notas/paginas/actualizar_pagina.dart';
import 'package:crud_notas/paginas/guardar_pagina.dart';
import 'package:flutter/material.dart';
import 'package:crud_notas/modelos/notas.dart';

class ListPages extends StatelessWidget {
  const ListPages({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton( //Boton flotante
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => GuardarPagina())
          ); //Navegar a la pagina de guardar
      }),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 57, 134),
        title: const Text('Notas Perronas', style: TextStyle(color: Color.fromARGB(255, 198, 36, 36))),
      ),
      body: Container(
        child: _MiLista() 
      ),
    );
  }
}



class _MiLista extends StatefulWidget { 
  // const _MiLista({
  //   super.key,
  // });

  @override
  State<_MiLista> createState() => _MiListaState();

}

class _MiListaState extends State<_MiLista> { 
  List<Nota> notas = []; //Lista de notas
   @override
   void initState() {  //Se ejecuta antes de que se construya el widget
     _cargarDatos(); 
     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(  //Constructor de lista
      itemCount: notas.length,
      itemBuilder: (_,i) => _crearTEm(i), //Funcion que crea los elementos de la lista
    );
  }

  _cargarDatos() async { //Funcion para cargar las notas
    List<Nota> auxNotas = await Operaciones.obtenerNotas();
    setState(() {
      notas = auxNotas;
    });
  }

  _crearTEm(int i) { //Funcion para crear los elementos de la lista
    return Dismissible( //Widget para eliminar elementos de la lista
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 10),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white, size: 30,)),
      ),
      onDismissed: (direction) {
        Operaciones.eliminarOperacion(notas[i]); //Eliminar la nota
      },
      child: ListTile( 
        title: Text(notas[i].titulo),
        subtitle: Text(notas[i].descripcion), //Descripcion de la nota
        trailing: MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => actualizarPagina(nota: notas[i])));
          },
          child: Icon(Icons.edit)), //Titulo de la nota
      ),
    );
  }
}