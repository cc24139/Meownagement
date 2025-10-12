import 'package:flutter/material.dart';

class TesteImagemPage extends StatelessWidget {
  const TesteImagemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste de Imagem'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verificação de asset:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Image.asset(
              '/images/ZazuCat/ZazuCatGrande.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Column(
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 50),
                    SizedBox(height: 10),
                    Text('Erro ao carregar imagem!'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
