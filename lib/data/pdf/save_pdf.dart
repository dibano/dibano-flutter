import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';


class SavePdf {
  static Future<File> savePdf({
    required String name,
    required Document pdf,
  }) async{
    final root = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
    final file = File('${root!.path}/$name');
    await file.writeAsBytes(await pdf.save()); 
    return file;
  }

  static Future<void> openPdf(File file) async{
    final path = file.path;
    await OpenFile.open(path);
  }
}

  