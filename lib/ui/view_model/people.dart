import 'package:flutter/widgets.dart';

class PeopleViewModel extends ChangeNotifier {
  List<String> _People = [];
  List<String> get People => _People;
}
