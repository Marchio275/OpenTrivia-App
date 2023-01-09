import 'package:flutter/material.dart';
import 'package:opentrivia/classi/categoria.dart';
import 'package:opentrivia/classi/domanda.dart';
import 'package:opentrivia/gestione_api.dart';
import 'package:opentrivia/ui/pagine/pagina_quiz.dart';

class OpzioniQuiz extends StatefulWidget {
  final Categoria? categoria;

  const OpzioniQuiz({Key? key, this.categoria}) : super(key: key);

  @override
  _OpzioniQuizState createState() => _OpzioniQuizState();
}

class _OpzioniQuizState extends State<OpzioniQuiz> {
  String? _difficolta;
  late bool processing;

  @override
  void initState() {
    super.initState();
    _difficolta = "easy";
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade600,
            child: Text(
              widget.categoria!.nome,
              style: Theme.of(context).textTheme.headline6!.copyWith(),
            ),
          ),
          Container(
              child: TextFormField(
            decoration: InputDecoration(labelText: 'Enter your username here'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          )),
          Text("Select Difficulty"),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 16.0,
              spacing: 16.0,
              children: <Widget>[
                SizedBox(width: 0.0),
                ActionChip(
                  label: Text("Easy"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _difficolta == "easy"
                      ? Colors.indigo
                      : Colors.grey.shade600,
                  onPressed: () => _sceltaDifficolta("easy"),
                ),
                ActionChip(
                  label: Text("Medium"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _difficolta == "medium"
                      ? Colors.indigo
                      : Colors.grey.shade600,
                  onPressed: () => _sceltaDifficolta("medium"),
                ),
                ActionChip(
                  label: Text("Highlander"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _difficolta == "highlander"
                      ? Colors.indigo
                      : Colors.grey.shade600,
                  onPressed: () => _sceltaDifficolta("highlander"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          processing
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: Text("Start Quiz"),
                  onPressed: _inizioQuiz,
                ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  _sceltaDifficolta(String? difficolta) {
    setState(() {
      _difficolta = difficolta;
    });
  }

  void _inizioQuiz() async {
    setState(() {
      processing = true;
    });
    try {
      List<Domanda> domande =
          await getQuestions(widget.categoria!, _difficolta);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PaginaQuiz(
                    domande: domande,
                    categoria: widget.categoria,
                  )));
    } catch (e) {}
    setState(() {
      processing = false;
    });
  }
}
