import 'package:breastCancerAwareness/database/dbProvider.dart';
import 'package:breastCancerAwareness/models/translateModel.dart';

abstract class DBRepository {
  DatabaseProvider databaseProvider;

  Future<TranslateModel> insert(TranslateModel query);

  Future<TranslateModel> update(TranslateModel query);

  Future<TranslateModel> delete(TranslateModel query);

  Future<List<TranslateModel>> getQueryList();
}
