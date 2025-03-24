import 'package:dibano/ui/view_model/button_data.dart';
import 'package:dibano/ui/widgets/activity_summary.dart';
import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:dibano/ui/widgets/info.dart';
import 'package:dibano/ui/widgets/my_farm.dart';
import 'package:dibano/ui/widgets/track_activities.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final List<ButtonData> _buttonDataList = [
    ButtonData(
      icon: Icons.add_task,
      title: 'Tätigkeiten erfassen',
      routeWidget: TrackActivities(title: 'Tätigkeiten erfassen'),
      color: FarmColors.lightGreen,
    ),
    ButtonData(
      icon: Icons.list_alt_outlined,
      title: 'Übersicht',
      routeWidget: ActivitySummary(title: "Übersicht"),
      color: FarmColors.skyBlue,
    ),
    ButtonData(
      icon: Icons.home,
      title: 'Mein Bauernhof',
      routeWidget: MyFarm(title: "Mein Bauernhof"),
      color: FarmColors.skyBlue,
    ),
    ButtonData(
      icon: Icons.info,
      title: 'Informationen',
      routeWidget: Info(title: "Informationen"),
      color: FarmColors.lightGreen,
    ),
  ];

  List<ButtonData> getButtonDataList() {
    return _buttonDataList;
  }

  void addButton(ButtonData button) {
    _buttonDataList.add(button);
    notifyListeners();
  }

  void removeButton(ButtonData button) {
    _buttonDataList.remove(button);
    notifyListeners();
  }

  void updateButton(int index, ButtonData button) {
    if (index >= 0 && index < _buttonDataList.length) {
      _buttonDataList[index] = button;
      notifyListeners();
    }
  }
}
