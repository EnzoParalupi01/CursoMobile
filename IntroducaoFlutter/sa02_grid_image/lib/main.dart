import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(myApp());
}

class MyApp extends StatelessWidget {
  final List<String> imagens = [
    'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0'
        'https://images.unsplash.com/photo-1521747116042-5a810fda9664'
        'https://images.unsplash.com/photo-1504384308090-c894fdcc538d'
        'https://images.unsplash.com/photo-1518837695005-2083093ee35b'
        'https://images.unsplash.com/photo-1512486130939-2c4f79935e43'
        'https://images.unsplash.com/photo-1535279020651-a57c6d4e2021'
        'https://images.unsplash.com/photo-1533090368676-1fd25485dbba'
        'https://images.unsplash.com/photo-1506619216599-9d16d0903dfd'
        'https://images.unsplash.com/photo-1494172961521-33799ddd43a5'
        'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Galeria de imagens")),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8, 
            ),
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () => mostrarImagem(context, imagens[index]),
                child: Image.network(imagens[index],fit:BoxFit.cover),
              );
            }
          ),
        ),
      ),
    );
  }// fim do widget build
 //métodos _mostrarimagens
void _mostrarimagen(BuildContext context, String imagem)
showDialog(
  context: context,
  builder: (contexto)=>Dialog(
    child: Image.network(image),
  ));

}






