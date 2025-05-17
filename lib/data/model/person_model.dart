import 'package:dibano/data/model/database_model.dart';

class Person extends DatabaseModel{
  @override
  final int? id;
  final String personName;
  int deleted;

  Person({
      this.id,
      required this.personName,
      required this.deleted
  });

  static Future<List<Person>> getAll() async{
    return await DatabaseModel.dbHandler.person();
  }

  // keys correspond to the names of the columns in the database
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'personName': personName,
      'deleted':deleted
    };
  }

  // for debugging and testing, i.e. with the print statement
  @override
  String toString() {
    return 'person{id: $id, personName: $personName, deleted: $deleted}';
  }

  @override
  String get tableName => 'Person';

}
