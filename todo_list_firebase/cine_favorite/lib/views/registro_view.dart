import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();

  void _registrar() async {
    if (_senhaField.text != _confirmarSenhaField.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("As senhas devem ser iguais")),
      );
      return;
    }
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
      Navigator.pop(context); // Volta para o login
    } on FirebaseAuthException catch (e) {
      String mensagemErro;
      switch (e.code) {
        case 'email-already-in-use':
          mensagemErro = 'Este email já está em uso.';
          break;
        case 'invalid-email':
          mensagemErro = 'Email inválido.';
          break;
        case 'weak-password':
          mensagemErro = 'A senha é muito fraca.';
          break;
        default:
          mensagemErro = 'Erro ao registrar: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagemErro)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro inesperado: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            TextField(
              controller: _confirmarSenhaField,
              decoration: InputDecoration(labelText: "Confirmar Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registrar,
              child: Text("Registrar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }
}