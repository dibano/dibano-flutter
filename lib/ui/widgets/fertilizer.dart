import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/view_model/fertilizer.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/fertilizer_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fertilizer extends StatefulWidget {
  const Fertilizer({super.key, required this.title});
  final String title;

  @override
  State<Fertilizer> createState() => _FertilizerState();
}

class _FertilizerState extends State<Fertilizer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FertilizerViewModel>(context, listen: false).getFertilizer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Consumer<FertilizerViewModel>(
        builder: (context, fertilizerViewModel, child) {
          return Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        for (var fertilizer in fertilizerViewModel.fertilizerList)
                          DetailCard(
                            detail: Detail(
                              name: fertilizer.fertilizerName,
                              toEdit: true,
                            ),
                          onTap: () async{
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => FertilizerEdit(
                                      title: "Düngmittel bearbeiten",
                                      fertilizerId: fertilizer.id,
                                      fertilizerName: fertilizer.fertilizerName,
                                      n: fertilizer.n.toString(),
                                      p: fertilizer.p.toString(),
                                      k: fertilizer.k.toString(),
                                    ),
                              ),
                            );
                            if (result == true) {
                              await Provider.of<FertilizerViewModel>(context,listen: false,).getFertilizer();
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
                      FertilizerEdit(title: "Düngmittel erstellen", isCreate: true),
            ),
          );
          if (result == true) {
            await Provider.of<FertilizerViewModel>(
              context,
              listen: false,
            ).getFertilizer();
          }
        },
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
