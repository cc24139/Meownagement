import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  TelaLogin({super.key});
  TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                "Login",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial"
                ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 20), 
            child: Center(
                child: Column(
                children: [
                SizedBox(
                    width: 250,
                    child: TextField(
                    controller: txtEmail,
                    decoration: InputDecoration(
                        labelText: "Digite seu Email",
                        hintText: "catlover@meow.com",
                        border: OutlineInputBorder(),
                    ),
                    ),
                ),
                ],
            ),
            ) 
            
        ),
    );
  }
}
