import 'package:flutter/widgets.dart';
import 'package:dibano/ui/view_model/crop.dart';

class CropsViewModel extends ChangeNotifier {
  List<Crop> _crops = [
    Crop(field: "Feld A", crop: "Weizen"),
    Crop(field: "Feld B", crop: "Gerste"),
    Crop(field: "Feld C", crop: "Hafer"),
    Crop(field: "Feld D", crop: "Roggen"),
    Crop(field: "Feld E", crop: "Mais"),
  ];

  List<Crop> getCrops() {
    return _crops;
  }

  void addCrop(Crop crop) {
    _crops.add(crop);
    notifyListeners();
  }

  void removeCrop(Crop crop) {
    _crops.remove(crop);
    notifyListeners();
  }

  void updateCrop(int index, Crop newCrop) {
    if (index >= 0 && index < _crops.length) {
      _crops[index] = newCrop;
      notifyListeners();
    }
  }
}
