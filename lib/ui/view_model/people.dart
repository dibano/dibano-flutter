import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/person_model.dart';

class PersonViewModel extends ChangeNotifier {
  List<Person> _personList = [];
  List<Person> get personList => _personList;
  String tableName = "Person";

  Future<void> add(String personName) async{
    Person person = Person(personName: personName);
    await person.insert();
    notifyListeners();
  }

  Future<void> getPerson() async{
    _personList = await Person.getAll();
    notifyListeners();
  }

  Future<void> remove(int id) async{
    Person removePerson = _personList.firstWhere((person) => person.id == id);
    _personList.removeWhere((person)=>person.id==id);
    await removePerson.delete();
    notifyListeners();
  }

  Future<void> update(int id, String personName) async{
    Person person = Person(id:id, personName: personName);
    await person.update();
    await getPerson();
    notifyListeners();
  }
}
