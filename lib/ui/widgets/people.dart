import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/person_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class People extends StatefulWidget {
  const People({super.key, required this.title});
  final String title;

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PersonViewModel>(context, listen: false).getPerson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Consumer<PersonViewModel>(
        builder: (context, peopleViewModel, child) {
          return Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        for (var person in peopleViewModel.personList.where((person) => person.deleted == 0))
                          DetailCard(
                            detail: Detail(
                              name: person.personName,
                              toEdit: true,
                            ),
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => PersonEdit(
                                        title: "Person bearbeiten",
                                        personName: person.personName,
                                        personId: person.id,
                                      ),
                                ),
                              );
                              if (result == true) {
                                await Provider.of<PersonViewModel>(
                                  context,
                                  listen: false,
                                ).getPerson();
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
                      PersonEdit(title: "Person erstellen", isCreate: true),
            ),
          );
          if (result == true) {
            await Provider.of<PersonViewModel>(
              context,
              listen: false,
            ).getPerson();
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
