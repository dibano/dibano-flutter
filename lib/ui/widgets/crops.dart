import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/crops_edit.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/view_model/crops.dart';
import 'package:provider/provider.dart';

class Crops extends StatefulWidget {
  const Crops({super.key, required this.title});
  final String title;

  @override
  State<Crops> createState() => _CropsState();
}

class _CropsState extends State<Crops> {
  bool _initialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      Provider.of<CropsViewModel>(context, listen: false).getCompleteCrops();
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    CropsViewModel cropsViewModel = Provider.of<CropsViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Consumer<CropsViewModel>(
        builder: (context, cropsViewModel, child) {
          Provider.of<CropsViewModel>(
            context,
            listen: false,
          ).getCompleteCrops();
          return Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 24),
                        CustomTitle(text: 'Kulturen konfigurieren'),
                        for (var crop in cropsViewModel.completeCrop)
                          DetailCard(
                            detail: Detail(
                              name: crop.cropName,
                              routeWidget: CropsEdit(
                                cropId: crop.id,
                                cropDateId: crop.cropDateId,
                                title: "Kultur bearbeiten",
                                cropName: crop.cropName,
                                startDate: DateTime.tryParse(crop.startDate),
                                endDate: DateTime.tryParse(crop.endDate),
                                fieldId: crop.fieldId,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                CustomButtonLarge(
                  text: 'Kulturen hinzufügen',
                  onPressed: () async {
                    final result = Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CropsEdit(
                              title: "Kultur erstellen",
                              isCreate: true,
                            ),
                      ),
                    );
                    if (result == true) {
                      Provider.of<CropsViewModel>(
                        context,
                        listen: false,
                      ).getCompleteCrops();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
