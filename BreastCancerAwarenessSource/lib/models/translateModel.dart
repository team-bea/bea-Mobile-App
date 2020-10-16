class TranslateModel {
  int id;
  String translateQuery;
  String translatedQuery;
  TranslateModel({this.id, this.translatedQuery, this.translateQuery});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'query': translateQuery,
      'age': translateQuery,
    };
  }
}
