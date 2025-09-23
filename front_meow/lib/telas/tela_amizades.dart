import 'package:flutter/material.dart';

class TelaAmizades extends StatefulWidget {
  const TelaAmizades({super.key});

  @override
  State<TelaAmizades> createState() => _TelaAmizadesState();
}

class _TelaAmizadesState extends State<TelaAmizades> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuários"),
      ),
    );
  }
}
