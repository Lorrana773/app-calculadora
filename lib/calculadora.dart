import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _resultado = '0';
  String _operador = ''; 
  String _entradaAnterior = '0'; 

  void _atualizarResultado(String valor) {
    setState(() {
      if (valor == 'C') {
        _resultado = ' ';
        _operador = ' ';
        _entradaAnterior = '0';
      } else if (valor == '+' || valor == '-' || valor == '*' || valor == '/') {
        _operador = valor;
        _entradaAnterior = _resultado;
        _resultado = ' ';
      } else if (valor == '=') {
        double numeroAnterior = double.tryParse(_entradaAnterior) ?? 0;
        double numeroAtual = double.tryParse(_resultado) ?? 0;
        switch (_operador) {
          case '+':
            _resultado = (numeroAnterior + numeroAtual).toString();
            break;
          case '-':
            _resultado = (numeroAnterior - numeroAtual).toString();
            break;
          case '*':
            _resultado = (numeroAnterior * numeroAtual).toString();
            break;
          case '/':
            _resultado = numeroAtual != 0
                ? (numeroAnterior / numeroAtual).toString()
                : 'ERRO';
            break;
          default:
            _resultado = ' ';
        }
        _operador = '';
        _entradaAnterior = '0';
      } else {
        if (_resultado == ' ') {
          _resultado = valor;
        } else {
          _resultado += valor;
        }
      }
    });
  }

  Widget _criarBotao(String texto) {
    return ElevatedButton(
      onPressed: () => _atualizarResultado(texto),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Simplificada'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            color: Colors.black12,
            child: Text(
              _resultado,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 2,
              children: [
                _criarBotao('7'),
                _criarBotao('8'),
                _criarBotao('9'),
                _criarBotao('/'),
                _criarBotao('4'),
                _criarBotao('5'),
                _criarBotao('6'),
                _criarBotao('*'),
                _criarBotao('1'),
                _criarBotao('2'),
                _criarBotao('3'),
                _criarBotao('-'),
                _criarBotao('C'),
                _criarBotao('0'),
                _criarBotao('='),
                _criarBotao('+'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Calculadora(),
    debugShowCheckedModeBanner: false,
  ));
}