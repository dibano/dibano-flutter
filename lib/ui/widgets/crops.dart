import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/crops_edit.dart';
import 'package:flutter/material.dart';
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
          cropsViewModel.getCompleteCrops();
          return Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
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
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      CropsEdit(title: "Kultur erstellen", isCreate: true),
            ),
          );
          if (result == true) {
            await Provider.of<CropsViewModel>(
              context,
              listen: false,
            ).getCompleteCrops();
          }
        },
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
