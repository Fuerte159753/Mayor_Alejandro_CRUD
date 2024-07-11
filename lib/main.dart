import 'package:flutter/material.dart';
import 'package:crud_notas/paginas/pagina_lista.dart';

void main() {runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notas',
      home: ListPages(),
    ); 
  }
}