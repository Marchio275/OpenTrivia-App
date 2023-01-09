import 'package:flutter/material.dart';
import 'package:opentrivia/classi/categoria.dart';
import 'package:opentrivia/classi/domanda.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:opentrivia/ui/pagine/quiz_finito.dart';
import 'package:html_unescape/html_unescape.dart';

class PaginaQuiz extends StatefulWidget {
  final List<Domanda> domande;
  final Categoria? categoria;

  const PaginaQuiz({Key? key, required this.domande, this.categoria})
      : super(key: key);

  @override
  _PaginaQuizState createState() => _PaginaQuizState();
}

class _PaginaQuizState extends State<PaginaQuiz> {
  final TextStyle _stileDomanda = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);

  int _index = 0;
  final Map<int, dynamic> _risposte = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Domanda domanda = widget.domande[_index];
    final List<dynamic> opzioni = domanda.incorrette!;
    if (!opzioni.contains(domanda.corretta)) {
      opzioni.add(domanda.corretta);
      opzioni.shuffle();
    }

    return WillPopScope(
      onWillPop: _tornareIndietro,
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(widget.categoria!.nome),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Text("${_index + 1}"),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          HtmlUnescape()
                              .convert(widget.domande[_index].domanda!),
                          softWrap: true,
                          style: MediaQuery.of(context).size.width > 800
                              ? _stileDomanda.copyWith(fontSize: 30.0)
                              : _stileDomanda,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...opzioni.map((opzione) => RadioListTile(
                              title: Text(
                                HtmlUnescape().convert("$opzione"),
                                style: MediaQuery.of(context).size.width > 800
                                    ? TextStyle(fontSize: 30.0)
                                    : null,
                              ),
                              groupValue: _risposte[_index],
                              value: opzione,
                              onChanged: (dynamic value) {
                                setState(() {
                                  _risposte[_index] = opzione;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: MediaQuery.of(context).size.width > 800
                              ? const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 64.0)
                              : null,
                        ),
                        child: Text(
                          _index == (widget.domande.length - 1)
                              ? "Submit"
                              : "Next",
                          style: MediaQuery.of(context).size.width > 800
                              ? TextStyle(fontSize: 30.0)
                              : null,
                        ),
                        onPressed: _prossimoSubmit,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _prossimoSubmit() {
    if (_risposte[_index] == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    }
    if (_index < (widget.domande.length - 1)) {
      setState(() {
        _index++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) =>
              QuizFinito(domande: widget.domande, risposte: _risposte)));
    }
  }

  Future<bool> _tornareIndietro() async {
    final comando = await showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to quit the quiz? All your progress will be lost."),
            title: Text("Warning!"),
            actions: <Widget>[
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
    return comando ?? false;
  }
}
