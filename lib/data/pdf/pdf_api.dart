import 'dart:io';

import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:dibano/data/model/workstep_model.dart';
import 'package:dibano/ui/view_model/activities.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:dibano/data/pdf/save_pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';


class PdfApi {
  static Future<File> generateTablePdf(List<CompleteWorkstep?> completeWorksteps, List<String?>? activities, List<String?>? crops, List<String?>? fields, List<String?>? persons) async{
    final pdf = Document();
    final Map<String, List<String>> headersPerActivity = {
      "Eigene Aktivitäten": ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum"],
      "Düngen (Körner)": ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum", "Ausbringmehnge/Feld", "Ausbringmenge/Ha", "Düngemittel", "N", "P", "K", "N/Feld", "N/Ha", "P/Feld", "P/Ha", "K/Feld", "K/Ha","Verwendeter Traktor", "Verwendeter Düngerstreuer"],
      "Düngen (flüssig)": ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum", "Ausbringmehnge/Feld", "Ausbringmenge/Ha", "Düngemittel", "N", "P", "K", "N/Feld", "N/Ha", "P/Feld", "P/Ha", "K/Feld", "K/Ha","Verwendeter Traktor", "Verwendeter Düngerstreuer"],
      "Saat": ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum","Saattiefe (cm)", "Saatmenge (Körner/Quadratmeter)", "Reihenabstand", "Abstand Körner in Reihe", "Keimfähigkeit", "Ziel Auflaufmenge", "Verwendeter Traktor", "Verwendete Spritze"],
      "Bodenbearbeitung": ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum","Wendend", "Bearbeittiefe", "Verwendeter Traktor", "Verwendete Maschine"],
      "Saatbeetbearbeitung": ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum","Bearbeittiefe", "Verwendeter Traktor", "Verwendete Maschine", "Zapfwellenbetrieben"],
      "Anwendung Pflanzenschutzmittel": ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum","Wirkstoff", "Aufbringmenge/Feld (l)", "Wirkstofftyp"],
      "Ernte": ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum","Ertrag (dt/Ha)", "Wassergehalt (%)", "Bodenschaden"],
      "Kontrolle": ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum","Gesichtete Schädlinge", "Gesichtete Pilzkrankheit", "Gesichtete Problemunkräuter", "Gesichtete Nährstoffmängel", "Anzahl/Pflanze", "Befallene Pflanze / Quadratmeter"],
    };
    final filterActivities = activities?.toSet().toList() ?? [];
    final filterCrops = crops?.toSet().toList() ?? [];
    final filterFields = fields?.toSet().toList() ?? [];
    final filterPerson = persons?.toSet().toList() ?? [];

    final String textActivities;
    final String textCrops;
    final String textFields;
    final String textPerson;
    
    if(filterActivities.isNotEmpty){
      textActivities = "Aktivitäten: ${filterActivities.join(", ")}";
    }else{
      textActivities = "";
    }

    if(filterCrops.isNotEmpty){
      textCrops = "Kulturen: ${filterCrops.join(", ")}";
    }else{
      textCrops = "";
    }

    if(filterFields.isNotEmpty){
      textFields = "Felder: ${filterFields.join(", ")}";
    }else{
      textFields = "";
    }

    if(filterPerson.isNotEmpty){
      textPerson = "Personen: ${filterPerson.join(", ")}";
    }else{
      textPerson = "";
    }
    String filterText = "";
    if(textActivities == "" && textFields == "" && textCrops == "" && textPerson == ""){
      filterText =  "Die angewendeten Filter sind: Keine Filter wurden angewendet \n\n";
    }else{
      filterText =  "Die angewendeten Filter sind: $textActivities $textFields $textCrops $textPerson \n\n";
    }

    final Map<String,List<CompleteWorkstep>> activityGroup = {};
    for(var workstep in completeWorksteps){
      final activityName = workstep?.activityName ?? "Eigene Aktivitäten";
      activityGroup.putIfAbsent(activityName, () => []).add(workstep!);
    }

    final data = completeWorksteps.map((workstep) => [workstep?.activityName ?? "", workstep?.cropName ?? "", workstep?.fieldName??"", workstep?.description??"",DateFormat('dd.MM.yyyy').format(DateTime.parse(workstep?.date??""))]).toList();
    final title = "Aktivitätenübersicht\n\n";
    final formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
    final text = "Die folgende Tabelle stellt detailliert die landwirtschaftlichen Aktivitäten dar, die von den Landwirten und Landwirtinnen auf ihren Feldern und in den jeweiligen Kulturen ausgeführt wurden. \n\n\n Datum: $formattedDate";
    //final logoImageFile = File('assets/images/dibanoLogo.png');
    final logoBytesData = await rootBundle.load('assets/images/dibanoLogo.png');
    final logoImage = pw.MemoryImage(logoBytesData.buffer.asUint8List());

    pdf.addPage(

      MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (context){
          return [
              pw.Center(child:Image(logoImage, width:150)),
                SizedBox(height: 10),
                Divider(thickness: 1, color: PdfColors.green900),
                SizedBox(height: 10),
                Text(
                  title,
                  style: const pw.TextStyle(fontSize: 24),
                ),
                Text(
                  text,
                  style: const pw.TextStyle(fontSize: 12),
                ),
                Text(
                  filterText,
                  style: const pw.TextStyle(fontSize: 8),
                ),
              for (final activity in activityGroup.entries)...[
                TableHelper.fromTextArray(
                  headers: headersPerActivity[activity.key] ?? ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum"],
                  data: activity.value.map((workstep){
                    switch(activity.key){
                      case "Eigene Aktivitäten":
                        return [
                          workstep.activityName,
                          workstep.cropName,
                          workstep.fieldName,
                          workstep.description,
                          workstep.date,
                        ];
                      case "Düngen (Körner)":
                        return[
                          workstep.activityName,
                          workstep.cropName,
                          workstep.fieldName,
                          workstep.description,
                          workstep.date,
                          workstep.quantityPerField,
                          workstep.quantityPerHa,
                          workstep.fertilizerName,
                          workstep.n,
                          workstep.p,
                          workstep.k,
                          workstep.nPerField,
                          workstep.nPerHa,
                          workstep.pPerField,
                          workstep.pPerHa,
                          workstep.kPerField,
                          workstep.kPerHa,
                          workstep.tractor,
                          workstep.fertilizerSpreader
                        ];
                      case "Düngen (flüssig)":
                        return[
                          workstep.activityName,
                          workstep.cropName,
                          workstep.fieldName,
                          workstep.description,
                          workstep.date,
                          workstep.quantityPerField,
                          workstep.quantityPerHa,
                          workstep.fertilizerName,
                          workstep.n,
                          workstep.p,
                          workstep.k,
                          workstep.nPerField,
                          workstep.nPerHa,
                          workstep.pPerField,
                          workstep.pPerHa,
                          workstep.kPerField,
                          workstep.kPerHa,
                          workstep.tractor,
                          workstep.fertilizerSpreader
                        ];
                      case "Saat":
                        return[
                          workstep.activityName,
                          workstep.cropName,
                          workstep.fieldName,
                          workstep.description,
                          workstep.date,
                          workstep.seedingDepth,
                          workstep.seedingQuantity,
                          workstep.plantProtectionName,
                          workstep.rowDistance,
                          workstep.seedingDistance,
                          workstep.germinationAbility,
                          workstep.goalQuantity,
                          workstep.tractor,
                          workstep.spray
                        ];

                      case "Bodenbearbeitung":
                        return[
                          workstep.activityName,
                          workstep.cropName,
                          workstep.fieldName,
                          workstep.description,
                          workstep.date,
                          workstep.turning,
                          workstep.machiningDepth,
                          workstep.tractor,
                          workstep.usedMachine
                        ];

                      case "Saatbeetbearbeitung":
                        return[
                          workstep.activityName,
                          workstep.cropName,
                          workstep.fieldName,
                          workstep.description,
                          workstep.date,
                          workstep.machiningDepth,
                          workstep.tractor,
                          workstep.usedMachine,
                          workstep.ptoDriven
                        ];

                      case "Anwendung Pflanzenschutzmittel":
                        return[
                          workstep.activityName,
                          workstep.cropName,
                          workstep.fieldName,
                          workstep.description,
                          workstep.date,
                          workstep.plantProtectionName,
                          workstep.quantityPerField,
                          workstep.quantityPerHa,
                          workstep.plantProtectionType
                        ];
                      case "Ernte":
                        return[
                          workstep.activityName,
                          workstep.cropName,
                          workstep.fieldName,
                          workstep.description,
                          workstep.date,
                          workstep.actualQuantity,
                          workstep.waterQuantityProcentage,
                          workstep.groundDamage
                        ];
                      case "Kontrolle":
                        return[
                          workstep.activityName,
                          workstep.cropName,
                          workstep.fieldName,
                          workstep.description,
                          workstep.date,
                          workstep.pest,
                          workstep.fungal,
                          workstep.problemWeeds,
                          workstep.nutrient,
                          workstep.countPerPlant,
                          workstep.plantPerQm,
                        ];
                      default:
                      return[
                        workstep.activityName,
                        workstep.cropName,
                        workstep.fieldName,
                        workstep.description,
                        workstep.date,
                      ];
                    }
                  }).toList(),
                  cellAlignment: pw.Alignment.center,
                  tableWidth: TableWidth.max,
                  headerHeight: 20,
                  headerStyle: pw.TextStyle(fontSize: 4, fontWeight: pw.FontWeight.bold),
                  cellStyle: pw.TextStyle(fontSize: 4),
                  headerDecoration: pw.BoxDecoration(color: PdfColor.fromInt(0xDB93C893)),
                ),
                SizedBox(height: 30),
              ],
            ];
        },
      ),
    );
    return SavePdf.savePdf(name: 'test_pdf.pdf', pdf: pdf);
  }
}
