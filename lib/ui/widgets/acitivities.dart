import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/activities_edit.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/view_model/activities.dart';
import 'package:provider/provider.dart';

class Activities extends StatefulWidget {
  const Activities({super.key, required this.title});
  final String title;

  @override
  State<Activities> createState()=>_ActivitiesState();
}

class _ActivitiesState extends State<Activities>{
  bool _initialized = false;
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(!_initialized){
      Provider.of<ActivitiesViewModel>(context, listen: false).getActivities();
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    ActivitiesViewModel activitiesViewModel = Provider.of<ActivitiesViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Consumer<ActivitiesViewModel>(
        builder: (context, activitiesViewModel, child) {
          activitiesViewModel.getActivities();
        return Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 24),
                    CustomTitle(text: 'Aktivitäten konfigurieren'),
                    for (var activity in activitiesViewModel.activities)
                      DetailCard(
                        detail: Detail(
                          name: activity.activityName,
                          routeWidget: ActivitiesEdit(
                            title: "Aktivitäten bearbeiten",
                            activityName: activity.activityName,
                            activityId:activity.id
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            CustomButtonLarge(
              text: 'Aktivitäten hinzufügen',
              onPressed: () async{
                final result = Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivitiesEdit(title: "Aktivitäten erstellen"),
                  ),
                );
                if(result == true){
                  await Provider.of<ActivitiesViewModel>(context, listen: false).getActivities();
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
