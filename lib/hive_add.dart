import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

class HiveFromServer extends StatefulWidget {
  @override
  _HiveFromServerState createState() => _HiveFromServerState();
}

class _HiveFromServerState extends State<HiveFromServer> {
  late Box box;

  Future<void> _downloadHiveFile() async {
    try {
      // آدرس فایل در سرور
      final url = "https://example.com/your_hive_file.hive";

      // دانلود فایل
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // مسیر ذخیره فایل در دستگاه
        final directory = await getApplicationDocumentsDirectory();
        final filePath = "${directory.path}/your_hive_file.hive";

        // ذخیره فایل در دستگاه
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // مقداردهی Hive با فایل دانلود شده
        Hive.init(directory.path);
        box = await Hive.openBox('yourBoxName', path: filePath);

        setState(() {
          print("Hive file downloaded and loaded successfully.");
        });
      } else {
        print("Failed to download file: ${response.statusCode}");
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _downloadHiveFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hive from Server")),
      body: Center(
        child: box == null
            ? CircularProgressIndicator()
            : Text("Hive Box Loaded: ${box.name}"),
      ),
    );
  }
}
