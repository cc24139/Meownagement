import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                "Login",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
        ),
        body: Column(
            children: [
                Text("email", style: TextStyle(fontFamily: "Arial"),)                                                                                                                                                                                                       
            ],
        )
    );
  }
}
