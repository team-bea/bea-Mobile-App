import 'package:breastCancerAwareness/database/dao.dart';
import 'package:breastCancerAwareness/models/translateModel.dart';

class QueryDAO implements Dao<TranslateModel> {
  final tableName = 'queries';
  final columnId = 'id';
  final _columnQuery = 'query';
  final _columnTranslatedQuery = 'translatedQuery';
  @override
  // TODO: implement createTableQuery
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
      " $_columnQuery TEXT,"
      " $_columnTranslatedQuery TEXT)";

  @override
  List<TranslateModel> fromList(List<Map<String, dynamic>> query) {
    List<TranslateModel> queries = List<TranslateModel>();
    for (Map map in query) {
      queries.add(fromMap(map));
    }
    return queries;
  }

  @override
  TranslateModel fromMap(Map<String, dynamic> object) {
    TranslateModel query = TranslateModel();
    query.id = object[columnId];
    query.translateQuery = object[_columnQuery];
    query.translatedQuery = object[_columnTranslatedQuery];
    return query;
  }

  @override
  Map<String, dynamic> toMap(TranslateModel object) {
    return <String, dynamic>{
      _columnQuery: object.translateQuery,
      _columnTranslatedQuery: object.translatedQuery
    };
  }
}
