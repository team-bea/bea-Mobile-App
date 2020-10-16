import 'dart:convert';

import 'package:flutter/services.dart';

class FAQ {
  String question;
  String answer;

  FAQ({this.question, this.answer});

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      question: json["question"] as String,
      answer: json["answer"] as String,
    );
  }
}

Future<String> loadFromAsset(String code) async {
  return await rootBundle.loadString("assets/data/faq_$code.json");
}

Future<Map<String, List<FAQ>>> parseJson(String code) async {
  try {
    String jsonString = await loadFromAsset(code);

    List<FAQ> _generalFAQ;
    List<FAQ> _diagnosisFAQ;
    List<FAQ> _treatmentFAQ;
    List<FAQ> _followUpFAQ;
    _generalFAQ = (jsonDecode(jsonString)['general'] as List)
        .map((i) => FAQ.fromJson(i))
        .toList();
    _diagnosisFAQ = (jsonDecode(jsonString)['diagnosis'] as List)
        .map((i) => FAQ.fromJson(i))
        .toList();
    _treatmentFAQ = (jsonDecode(jsonString)['treatment'] as List)
        .map((i) => FAQ.fromJson(i))
        .toList();
    _followUpFAQ = (jsonDecode(jsonString)['followUp'] as List)
        .map((i) => FAQ.fromJson(i))
        .toList();

    Map<String, List<FAQ>> list = {
      "general": _generalFAQ,
      "followUp": _followUpFAQ,
      "diagnosis": _diagnosisFAQ,
      "treatment": _treatmentFAQ
    };
    return list;
  } catch (e) {
    print(e.toString());
  }
  return {};
}
