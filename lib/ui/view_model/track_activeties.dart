import 'package:flutter/widgets.dart';

class TrackActivetiesViewModel extends ChangeNotifier {
  // Private Listen
  final List<String> _areaList = ['Ort wählen', 'Feld A', 'Feld B', 'Feld C'];
  final List<String> _activityList = [
    'Aktivität wählen',
    'Aktivität 1',
    'Aktivität 2',
    'Aktivität 3',
  ];
  final List<String> _cultureList = [
    'Kultur wählen',
    'Kultur 1',
    'Kultur 2',
    'Kultur 3',
  ];
  final List<String> _personList = [
    'Person wählen',
    'Person 1',
    'Person 2',
    'Person 3',
  ];
  final List<String> _fertilizersList = [
    'Düngemittel wählen',
    'Düngemittel 1',
    'Düngemittel 2',
    'Düngemittel 3',
  ];

  List<String> getAreaList() {
    return _areaList;
  }

  List<String> getActivityList() {
    return _activityList;
  }

  List<String> getCultureList() {
    return _cultureList;
  }

  List<String> getPersonList() {
    return _personList;
  }

  List<String> getFertilizersList() {
    return _fertilizersList;
  }

  void setAreaList(List<String> newList) {
    _areaList.clear();
    _areaList.addAll(newList);
    notifyListeners();
  }

  void setActivityList(List<String> newList) {
    _activityList.clear();
    _activityList.addAll(newList);
    notifyListeners();
  }

  void setCultureList(List<String> newList) {
    _cultureList.clear();
    _cultureList.addAll(newList);
    notifyListeners();
  }

  void setPersonList(List<String> newList) {
    _personList.clear();
    _personList.addAll(newList);
    notifyListeners();
  }

  void setFertilizersList(List<String> newList) {
    _fertilizersList.clear();
    _fertilizersList.addAll(newList);
    notifyListeners();
  }
}
