import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _dropdownValue = "";
  String _dropdownCofValue = "";

  double filhos = 0;

  TextEditingController mlContr = TextEditingController();

  String _infoText2 = "22";

  String _textoINFO = "informe seus dados";

  double consumo = 0;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
        _pessoa();
      });
    }
  }

  void _pessoa() {
    setState(() {
      consumo = double.parse(mlContr.text);
      if (_dropdownCofValue != "") {
        if (_dropdownCofValue == "solteira") {
          _infoText2 = "+ 600 REAIS (mãe solteira)";
        } else {
          _infoText2 = "";
        }

      if (_dropdownValue != "") {
        if (_dropdownValue == "nivel2") {
          if (filhos <= 2) {
            _textoINFO = "SEU AUXÍLIO SERÁ DE 1,5 SALÁRIO MÍNIMO";
          } else {
            _textoINFO = " não possui auxilio";
          }
        } else if (_dropdownValue == "nivel1") {
          if (filhos <=3) {
            _textoINFO = "SEU AUXÍLIO SERÁ DE 2,5 SALÁRIOS MÍNIMOS";
          } else {
            _textoINFO = "não possui auxilio";
          }

        } else if (_dropdownValue == "nivel1" || _dropdownValue == "nivel2") {
          if (filhos > 3) {
            _textoINFO = "SEU AUXÍLIO SERÁ DE 3 SALÁRIOS MÍNIMOS";
          } else {
            _textoINFO = "não possui auxilio";
          }
        }
      } else {
        _textoINFO = "INSIRA ALGO";
      }
    }});
  }

  void _resetFields() {
    setState(() {
      _formKey = GlobalKey<FormState>();

      _textoINFO = "informe seus Dados";
    });
  }

  void _Blabla() {
    setState(() {
      _textoINFO = _dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AUXILIO BOLSA",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.shade900),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade400,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: (){
            _resetFields();
          }),
        ],
      ),
      backgroundColor: Colors.cyan.shade400,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Icon(Icons.handshake_outlined,
                  size: 120.0, color: Colors.indigo.shade900),
              DropdownButton(
                items: const [
                  DropdownMenuItem(child: Text("RENDA"),  value: ""),
                  DropdownMenuItem(child: Text("MENOS DE 1 SALÁRIO MÍNIMO"), value: "nivel1"),
                  DropdownMenuItem(child: Text("MENOS DE 2 SALÁRIOS MÍNIMOS"), value: "nivel2"),
                ],
                value: _dropdownValue,
                onChanged: (String? value) {
                  if (value is String) {
                    setState(() {
                      _dropdownValue = value;
                    });
                  }
                },
                style: TextStyle(color: Colors.indigo.shade900),
                dropdownColor: Colors.white,
                isExpanded: true,
                icon: Icon(Icons.table_rows, color: Colors.indigo.shade900),
                iconSize: 43.0,
              ),
              DropdownButton(
                items: const [
                  DropdownMenuItem(child: Text("ESTADO CIVIL"), value: ""),
                  DropdownMenuItem(child: Text("SOLTEIRA"), value: "solteira"),
                  DropdownMenuItem(child: Text("CASADA"), value: "casada"),
                ],
                value: _dropdownCofValue,
                onChanged: (String? value) {
                  if (value is String) {
                    setState(() {
                      _dropdownCofValue = value;
                    });
                  }
                },
                style: TextStyle(color: Colors.indigo.shade900),
                dropdownColor: Colors.white,
                isExpanded: true,
                icon: Icon(Icons.table_rows, color: Colors.indigo.shade900),
                iconSize: 43.0,
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: "QUANTIDADE DE FILHOS NA ESCOLA E VACINADOS:",
                    labelStyle: TextStyle(color: Colors.indigo.shade900),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo.shade900, fontSize: 15.0),
                  controller: mlContr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Preencha o espaço em branco";
                    } else if (double.parse(value) < 1) {
                      return "consumo muito baixo";
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _pessoa();
                      }
                    },
                    child: Text("Calcular"),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.indigo.shade900),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      // textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "$_textoINFO",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ),
              Container(
                child: Text(
                  "$filhos, $consumo",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.cyan.shade400, fontSize: 24.0),
                ),
              ),
              Container(
                child: Text(
                  "$_infoText2",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//_________@@@@@@@@__________@@@@
// ________@@@________@@_____@@@@@@@
// ________@@___________@@__@@@______@@
// ________@@____________@@@__________@@
// __________@@________________________@@
// ____@@@@@@______@@@@@___________@@
// __@@@@@@@@@__@@@@@@@_________@@
// __@@____________@@@@@@@@_______@@
// _@@____________@@@@@@@@@_____@@
// _@@____________@@@@@@@@___@@@
// _@@@___________@@@@@@@______@@
// __@@@@__________@@@@@________@@
// ____@@@@@@_______________________@@
// _________@@________________________@@
// _____ __@@___________@@__________@@
// ________@@@________@@@@@@@@@
// __________@@@_____@@@_@@@@@
// ___________@@@@@@@
// ___________@@@@@_@
// ____________________@
// ____________________@
// _____________________@
// _____________________@
// ______________________@____@@@
// _______________@@@@__@__@____@@
// _______________@_______@@@____@@
// _______________@@@@____@__@@
// ________________________@
// _______________________@
//PITCHULINHA <3