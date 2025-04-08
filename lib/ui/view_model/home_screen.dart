import 'package:dibano/ui/view_model/button_data.dart';
import 'package:dibano/ui/widgets/workstep_summary.dart';
import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:dibano/ui/widgets/info.dart';
import 'package:dibano/ui/widgets/my_farm.dart';
import 'package:dibano/ui/widgets/track_worksteps.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final List<ButtonData> _buttonDataList = [
    ButtonData(
      icon: Icons.add_task,
      title: 'Tätigkeiten erfassen',
      routeWidget: TrackWorksteps(title: 'Tätigkeiten erfassen'),
      color: FarmColors.darkGreen,
    ),
    ButtonData(
      icon: Icons.info,
      title: 'Informationen',
      routeWidget: Info(title: "Informationen"),
      color: FarmColors.earthBrown,
    ),
    ButtonData(
      icon: Icons.list_alt_outlined,
      title: 'Meine Tätigkeiten',
      routeWidget: WorkstepSummary(title: "Meine Tätigkeiten"),
      color: FarmColors.grassGreen,
    ),
    ButtonData(
      icon: Icons.home,
      title: 'Mein Bauernhof',
      routeWidget: MyFarm(title: "Mein Bauernhof"),
      color: FarmColors.grassGreen,
    ),
  ];

  List<ButtonData> getButtonDataList() {
    return _buttonDataList;
  }
}
