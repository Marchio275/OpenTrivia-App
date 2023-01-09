import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:opentrivia/classi/categoria.dart';
import 'package:opentrivia/classi/domanda.dart';

const String urlBase = "https://opentdb.com/api.php";

Future<List<Domanda>> getQuestions(
    Categoria categoria, String? difficulty) async {
  String url = "$urlBase?&category=${categoria.id}";
  if (difficulty == 'easy') {
    url = "$url&type=boolean&amount=10&difficulty=easy";
  }
  if (difficulty == 'medium') {
    url = "$url&amount=10&difficulty=medium";
  }
  if (difficulty == 'highlander') {
    url = "$url&amount=50";
  }
  http.Response res = await http.get(Uri.parse(url));
  List<Map<String, dynamic>> domande =
      List<Map<String, dynamic>>.from(json.decode(res.body)["results"]);
  return Domanda.fromData(domande);
}
