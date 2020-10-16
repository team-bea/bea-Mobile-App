import 'package:breastCancerAwareness/database/QueryDao.dart';
import 'package:breastCancerAwareness/models/translateModel.dart';

import 'file:///C:/Users/Sujith/Desktop/MyProjects_prabi/girlsHackathonSagun/girls-in-tech2020/BreastCancerAwarenessSource/lib/database/dbRepository.dart';

class QueryDBRepository implements DBRepository {
  final dao = QueryDAO();
  @override
  var databaseProvider;

  QueryDBRepository({this.databaseProvider});

  @override
  Future<TranslateModel> insert(TranslateModel query) async {
    final db = await databaseProvider.db();
    query.id = await db.insert(dao.tableName, dao.toMap(query));
    return query;
  }

  @override
  Future<TranslateModel> delete(TranslateModel query) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [query.id]);
    return query;
  }

  @override
  Future<TranslateModel> update(TranslateModel query) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(query),
        where: dao.columnId + " = ?", whereArgs: [query.id]);
    return query;
  }

  @override
  Future<List<TranslateModel>> getQueryList() async {
    final db = await databaseProvider.db();
    List<Map> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}
