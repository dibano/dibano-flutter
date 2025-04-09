import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/view_model/fields.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CropsViewModel>(context, listen: false).getCompleteCrops();
      Provider.of<CropsViewModel>(context, listen: false).getCrops();
      Provider.of<FieldsViewModel>(context, listen: false).getFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Consumer<CropsViewModel>(
        builder: (context, cropsViewModel, child) {
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
                              description: crop.fieldName,
                              toEdit: true,
                            ),
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => CropsEdit(
                                        title: "Kultur bearbeiten",
                                        cropId: crop.id,
                                        cropDateId: crop.cropDateId,
                                        cropName: crop.cropName,
                                        startDate: DateTime.tryParse(
                                          crop.startDate,
                                        ),
                                        endDate: DateTime.tryParse(
                                          crop.endDate,
                                        ),
                                        fieldId: crop.fieldId,
                                      ),
                                ),
                              );
                              if (result == true) {
                                await Provider.of<CropsViewModel>(
                                  context,
                                  listen: false,
                                ).getCompleteCrops();
                                await Provider.of<CropsViewModel>(
                                  context,
                                  listen: false,
                                ).getCrops();
                              }
                            },
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
            await Provider.of<CropsViewModel>(
              context,
              listen: false,
            ).getCrops();
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
