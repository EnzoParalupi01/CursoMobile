import 'package:flutter/material.dart';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Texto de exemplo",
                style: TextStyle(fontSize: 20, color: Colors.amber),
              ),
              Text(
                "Flutter é incrível",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              Image.network(
                'https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg',
                width: 200,
                height: 100,
                fit: BoxFit.cover,
              ),
              Image.asset(
                "assets/img/einstein.jpg",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 