import 'dart:io';

import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:dibano/data/pdf/save_pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';


class PdfApi {
  static Future<File> generateTablePdf(List<CompleteWorkstep?> completeWorksteps, List<String?>? activities, List<String?>? crops, List<String?>? fields, List<String?>? persons) async{
    final pdf = Document();
    final headers = ["Aktivität", "Kultur", "Feld", "Beschreibung", "Datum"];
    
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

    final data = completeWorksteps.map((workstep) => [workstep?.activityName ?? "", workstep?.cropName ?? "", workstep?.fieldName??"", workstep?.description??"",DateFormat('dd.MM.yyyy').format(DateTime.parse(workstep?.date??""))]).toList();
    final title = "Aktivitätenübersicht\n\n";
    final formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
    final text = "Die folgende Tabelle stellt detailliert die landwirtschaftlichen Aktivitäten dar, die von den Landwirten und Landwirtinnen auf ihren Feldern und in den jeweiligen Kulturen ausgeführt wurden. \n\n\n Datum: $formattedDate";
    //final logoImageFile = File('assets/images/dibanoLogo.png');
    final logoBytesData = await rootBundle.load('assets/images/dibanoLogo.png');
    final logoImage = pw.MemoryImage(logoBytesData.buffer.asUint8List());

    pdf.addPage(

      Page(
        build: (_)=> Center(
          child: Column(
            children: [
              Image(logoImage, width:150),
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
              TableHelper.fromTextArray(
                data: data,
                headers: headers,
                cellAlignment: pw.Alignment.center,
                tableWidth: TableWidth.max,
                headerHeight: 50,
                headerStyle: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                headerDecoration: pw.BoxDecoration(color: PdfColor.fromInt(0xDB93C893)),
              ),
            ],
          ),
        ),
      ),
    );
    return SavePdf.savePdf(name: 'test_pdf.pdf', pdf: pdf);
  }
}
