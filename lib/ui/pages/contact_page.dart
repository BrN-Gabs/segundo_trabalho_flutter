import 'package:flutter/material.dart';
import 'package:segundo_trabalho/ui/components/components.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactPage extends StatefulWidget {
  final String value;
  const ContactPage({this.value = '', Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(Icons.people),
          SizedBox(
            width: 8,
          ),
          Text('Contato'),
        ]),
      ),
      body: ListView(
        children: [
          FieldText(controller: _nameController, label: 'Digite seu nome'),
          FieldText(
            controller: _emailController,
            label: 'Digite seu e-mail',
            keyboard: TextInputType.emailAddress,
            prefixText: "@ ",
          ),
          Button(
              text: "Enviar Resultado",
              pressed: () {
                enviarEmail(widget.value);
              }),
        ],
      ),
    );
  }

  void enviarEmail(String value) async {
    String name = _nameController.text;
    String email = _emailController.text;

    if (name.isEmpty) {
      _showMessage('Nome Inválido!');
      return;
    }

    if (email.isEmpty) {
      _showMessage('E-mail Inválido!');
      return;
    }

    const usuario = "gdshjgdjhg@gmail.com";
    const senha = "naovouporsenha";

    final smtpServer = gmail(usuario, senha);

    if (value.isEmpty) {
      _showMessage('Salve o cálculo do IMC para poder enviar');
    } else {
      final mensagem = Message()
        ..from = const Address(usuario, "Contato")
        ..recipients.add(usuario)
        ..subject = "Resultado do IMC"
        ..text = """Nome: $name,
        E-mail: $email,
        Mensagem: $value""";

      await send(mensagem, smtpServer);

      setState(() {
        _nameController.clear();
        _emailController.clear();
      });
    }
  }

  void _showMessage(String texto) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Alerta!!!'),
            content: Text(texto),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}
