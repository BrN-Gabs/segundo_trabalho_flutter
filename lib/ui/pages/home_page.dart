import 'package:flutter/material.dart';
import 'package:segundo_trabalho/ui/components/components.dart';
import 'package:segundo_trabalho/ui/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(Icons.calculate),
          SizedBox(
            width: 8,
          ),
          Text('Cálculo do IMC'),
        ]),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Icon(Icons.people),
          ),
          ListTile(
            title: const Text('Contato'),
            onTap: () {
              _openContact('');
            },
          ),
        ],
      )),
      body: ListView(children: [
        FieldText(
          controller: _weightController,
          keyboard: TextInputType.number,
          label: 'Peso (kg)',
          prefixText: 'Digite seu peso em kilos',
        ),
        FieldText(
          controller: _heightController,
          keyboard: TextInputType.number,
          label: 'Altura (m)',
          prefixText: 'Digite sua altura em metros',
        ),
        Button(
          text: 'Calcular',
          pressed: _calculatePressed,
        )
      ]),
    );
  }

  void _calculatePressed() {
    double weight =
        double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 0;
    double height =
        double.tryParse(_heightController.text.replaceAll(',', '.')) ?? 0;

    if (weight == 0) {
      _showMessage('Valor do Peso Inválido');
      return;
    }

    if (height == 0) {
      _showMessage('Valor da Altura Inválido');
      return;
    }

    double result = weight / (height * height);

    String message = 'Seu IMC é de $result, classificado como';

    if (result > 18.4 && result < 25) {
      _showMessage('$message Normal');
    }
    if (result > 24.9 && result < 30) {
      _showMessage('$message Sobrepeso');
    }
    if (result > 29.9 && result < 41) {
      _showMessage('$message Obesidade');
    }
    if (result > 40) {
      _showMessage('$message Obesidade Grave');
    }
  }

  void _showMessage(String texto) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Resultado do IMC'),
            content: Text(texto),
            actions: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: () {
                      _openContact(texto);
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              )
            ],
          );
        });
  }

  void _openContact(String value) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(value: value)));
  }
}
