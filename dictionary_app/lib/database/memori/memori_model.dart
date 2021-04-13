class MemoriModel{

  int id;
  String word;
  String spell;
  String mean;

  MemoriModel({this.id, this.word, this.spell, this.mean});

  Map<String, dynamic> toJson()
  {
    return {
      "id":this.id,
      "word":this.word,
      "spell":this.spell,
      "mean":this.mean,
    };
  }

  factory MemoriModel.fromJson(json)
  {
    return MemoriModel(
      id: json['id'],
      word: json['word'],
      spell: json['spell'],
      mean: json['mean'],
    );

  }
}