import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http_parser/http_parser.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['https://www.googleapis.com/auth/drive.file'],
);

Future<GoogleSignInAccount?> singIn() async {
  try {
    final account = await _googleSignIn.signIn();
    if (account != null) {
      return account;
    } else {
      return null;
    }
  } catch (e) {
    print("Error signing in: $e");
  }
}

Future<void> singOut() async {
  await _googleSignIn.signOut();
}

///////////// Backup on Google Drive /////////////

Future<bool> uploadToGoogleDrive() async {
  final GoogleSignInAccount? account = await singIn();
  if (account == null) {
    return false;
  }

  final GoogleSignInAuthentication auth = await account.authentication;
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'dibano_db');
  final File dbFile = File(path);

  if (!await dbFile.exists()) {
    return false;
  }

  final DateTime timestamp = DateTime.now();
  final formattedDate = DateFormat('dd.MM.yyyy').format(timestamp);

  final String fileName = "Dibano_Datenbank_Backup_$formattedDate.db";

  final Uri uri = Uri.parse(
    'https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart',
  );

  final metadata = http.MultipartFile.fromString(
    'metadata',
    '{"name": "$fileName", "mimeType": "application/x-sqlite3"}',
    contentType: MediaType('application', 'json'),
  );

  final request =
      http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer ${auth.accessToken}'
        ..files.add(metadata)
        ..files.add(
          http.MultipartFile.fromBytes(
            'file',
            await dbFile.readAsBytes(),
            filename: fileName,
            contentType: MediaType('application', 'octet-stream'),
          ),
        );

  final response = await http.Response.fromStream(await request.send());
  await singOut();
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

///////////// Restore from Google Drive /////////////

Future<List<Map<String, dynamic>>> listBackupFiles() async {
  final GoogleSignInAccount? account = await singIn();
  if (account == null) {
    return [];
  }

  final GoogleSignInAuthentication auth = await account.authentication;

  final Uri uri = Uri.parse(
    'https://www.googleapis.com/drive/v3/files?q=mimeType="application/x-sqlite3"&spaces=drive',
  );

  final response = await http.get(
    uri,
    headers: {'Authorization': 'Bearer ${auth.accessToken}'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List files = jsonResponse['files'];
    return files.map((file) {
      return {'id': file['id'], 'name': file['name']};
    }).toList();
  } else {
    return [];
  }
}

Future<bool> downloadBackupFile(String fileId) async {
  final GoogleSignInAccount? account = await singIn();
  if (account == null) {
    return false;
  }

  final GoogleSignInAuthentication auth = await account.authentication;

  final Uri uri = Uri.parse(
    'https://www.googleapis.com/drive/v3/files/$fileId?alt=media',
  );

  final response = await http.get(
    uri,
    headers: {'Authorization': 'Bearer ${auth.accessToken}'},
  );

  if (response.statusCode == 200) {
    final databasePath = await getDatabasesPath();
    final savePath = join(databasePath, 'dibano_db');

    final file = File(savePath);

    final directory = file.parent;
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    await file.writeAsBytes(response.bodyBytes);
    await singOut();
    return true;
  } else {
    await singOut();
    return false;
  }
}

Future<void> restoreDatabase(String backupFilePath) async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'dibano_db');

  final backupFile = File(backupFilePath);

  if (!await backupFile.exists()) {
    return;
  }
  await backupFile.copy(path);
  await openDatabase(path);
}
