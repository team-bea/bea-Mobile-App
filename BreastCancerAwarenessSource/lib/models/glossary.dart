import 'dart:convert';

import 'package:flutter/services.dart';

class Glossary {
  String term;
  String meaning;

  Glossary({this.meaning, this.term});

  factory Glossary.fromJson(Map<String, dynamic> json) {
    return Glossary(
      term: json["term"] as String,
      meaning: json["meaning"] as String,
    );
  }
}

Future<String> loadFromAsset(String code) async {
  return await rootBundle.loadString("assets/data/glossary_$code.json");
}

Future<List<Glossary>> parseJson(String code) async {
  String jsonString = await loadFromAsset(code);
  final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Glossary>((json) => Glossary.fromJson(json)).toList();
}
