import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> report(BuildContext context, List<String> text) async {
  final pdf = pw.Document(deflate: zlib.encode);

  String fontAssetLocation = (context.locale.languageCode == "hi")
      ? "fonts/Mangal-Regular.ttf"
      : "fonts/Alata-Regular.ttf";
  final font = await rootBundle.load(fontAssetLocation);
  final ttf = pw.Font.ttf(font);
  List<pw.Widget> list = [];
  for (String value in text) {
    list.add(pw.Text(value, style: pw.TextStyle(font: ttf, fontSize: 20)));
  }
  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(10),
      build: (pw.Context context) {
        return list;
      }));
  //saving pdf
  Directory directory = await getApplicationDocumentsDirectory();
  String documentPath = directory.path;

  File file = File("$documentPath/Translated_Report-${DateTime.now()}.pdf");
  file.writeAsBytesSync(pdf.save());
}
