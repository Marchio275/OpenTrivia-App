enum Tipo { multiple, boolean }

enum Difficolta { easy, medium, highlander }

class Domanda {
  final String? categoria;
  final Tipo? tipo;
  final Difficolta? difficolta;
  final String? domanda;
  final String? corretta;
  final List<dynamic>? incorrette;

  Domanda(
      {this.categoria,
      this.tipo,
      this.difficolta,
      this.domanda,
      this.corretta,
      this.incorrette});

  Domanda.fromMap(Map<String, dynamic> data)
      : categoria = data["category"],
        tipo = data["type"] == "multiple" ? Tipo.multiple : Tipo.boolean,
        difficolta = data["difficulty"] == "easy"
            ? Difficolta.easy
            : data["difficulty"] == "medium"
                ? Difficolta.medium
                : Difficolta.highlander,
        domanda = data["question"],
        corretta = data["correct_answer"],
        incorrette = data["incorrect_answers"];

  static List<Domanda> fromData(List<Map<String, dynamic>> data) {
    return data.map((question) => Domanda.fromMap(question)).toList();
  }
}
