import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Perfil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // Definindo as informações diretamente no código
  final String info1 = 'João Silva';
  final String info2 = '30 anos';
  final String info3 = 'Desenvolvedor';
  final String info4 = 'São Paulo, São Paulo, Brasil';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Ação quando o ícone de pessoa for clicado
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os itens
          children: [
            // Foto de perfil com bordas arredondadas
            CircleAvatar(
              radius: 50, // Tamanho do ícone arredondado
              backgroundColor: Colors.blue, // Cor de fundo do ícone
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),
            SizedBox(height: 20),

            // Estrelas abaixo da foto de perfil
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: index < 4 ? Colors.yellow : Colors.grey, // Exemplo de 4 estrelas preenchidas
                  size: 30,
                );
              }),
            ),
            SizedBox(height: 20),

            // Texto sobreposto
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Positioned(
                  top: 20,
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 50,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Text(
                    'Texto Sobreposto',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Linhas de Informações com as informações definidas no código
            Column(
              children: [
                _buildInfoRow(info1),
                _buildInfoRow(info2),
                _buildInfoRow(info3),
                _buildInfoRow(info4),
              ],
            ),
            SizedBox(height: 20),

            // Ícones de Redes Sociais
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
              children: [
                IconButton(
                  icon: Icon(Icons.facebook),
                  color: Colors.blue[800],
                  iconSize: 40,
                  onPressed: () {
                    // Ação ao clicar no ícone do Facebook
                    print("Facebook Pressionado");
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.alternate_email),
                  color: Colors.blue[400],
                  iconSize: 40,
                  onPressed: () {
                    // Ação ao clicar no ícone do Twitter
                    print("Twitter Pressionado");
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  color: Colors.pink,
                  iconSize: 40,
                  onPressed: () {
                    // Ação ao clicar no ícone do Instagram
                    print("Instagram Pressionado");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método para criar uma linha com o texto da informação
  Widget _buildInfoRow(String infoText) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              infoText, // Exibe a informação diretamente
              style: TextStyle(fontSize: 16), // Estilo do texto
            ),
          ),
        ],
      ),
    );
  }
}
