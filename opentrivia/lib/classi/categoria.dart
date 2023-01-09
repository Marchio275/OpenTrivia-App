import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Categoria {
  final int id;
  final String nome;
  final dynamic icona;
  Categoria(this.id, this.nome, {this.icona});
}

final List<Categoria> categorie = [
  Categoria(12, "Music", icona: FontAwesomeIcons.music),
  Categoria(19, "Maths", icona: FontAwesomeIcons.arrowDown19),
  Categoria(22, "Geography", icona: FontAwesomeIcons.mountain),
  Categoria(27, "Animals", icona: FontAwesomeIcons.dog)
];
