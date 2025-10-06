import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Custom TextField Widget')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFieldWidgets(
          textValue: 'Enter your text',
          controller: TextEditingController(),
          isPassword: true,

        ),
      ),
    ),
  ));
}

class TextFieldWidgets extends StatefulWidget {
  final String textValue;
  final TextEditingController controller;
  final bool isPassword;

  TextFieldWidgets({
    required this.textValue,
    required this.controller,
    this.isPassword = false,
  });

  @override
  _TextFieldWidgetsState createState() => _TextFieldWidgetsState();
}

class _TextFieldWidgetsState extends State<TextFieldWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword,
          decoration: InputDecoration(
            hintText: widget.textValue,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
