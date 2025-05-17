import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/person_model.dart';
import 'package:collection/collection.dart';

class PersonViewModel extends ChangeNotifier {
  List<Person> _personList = [];
  List<Person> get personList => _personList;
  List<Person> get activePersonList => _personList.where((person) => person.deleted == 0).toList();
  Person? getPersonById(int id) => _personList.firstWhereOrNull((person)=>person.id == id);

  String tableName = "Person";

  Future<void> add(String personName) async{
    Person person = Person(personName: personName, deleted: 0);
    await person.insert();
    notifyListeners();
  }

  Future<void> getPerson() async{
    _personList = await Person.getAll();
    notifyListeners();
  }

  Future<void> remove(int id) async{
    Person removePerson = _personList.firstWhere((person) => person.id == id);
    removePerson.deleted = 1;
    await removePerson.update();
    notifyListeners();
  }

  Future<void> update(int id, String personName, int deleted) async{
    Person person = Person(id:id, personName: personName, deleted: deleted);
    await person.update();
    notifyListeners();
  }

  bool checkIfExisting(String personName){
    for(Person person in _personList){
      if(person.personName == personName){
        return true;
      }
    }
    return false;
  }
}
