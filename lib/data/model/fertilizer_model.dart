import 'package:dibano/data/model/database_model.dart';

class Fertilizer extends DatabaseModel{
  @override
  final int? id;
  final String fertilizerName;
  final double n;
  final double p;
  final double k;
  static String table = "Fertilizer";

  Fertilizer({
      this.id,
      required this.fertilizerName,
      required this.n,
      required this.p,
      required this.k,
  });

  static Future<List<Fertilizer>> getAll() async{
    return await DatabaseModel.dbHandler.fertilizer();
  }

  // keys correspond to the names of the columns in the database
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'fertilizerName': fertilizerName,
      'n': n,
      'p': p,
      'k': k
    };
  }

  // for debugging and testing, i.e. with the print statement
  @override
  String toString() {
    return 'Fertilizer{id: $id, fertilizerName: $fertilizerName, n: $n, p: $p, k: $k}';
  }

  @override
  String get tableName => table;

}
