
import 'package:finance_diary/system/diarySystem.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class AddData {
  List<String> stockList = ['BTC', '삼성'];

  Future<String> dataInitial() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      stockList = contents.split(',');
    } catch (e) {
      final file = await _localFile;

      file.create();

      file.writeAsString('BTC, 삼성');

      final contents = await file.readAsString();

      stockList = contents.split(',');
    }
    return "d";
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/stocks.txt");
  }

  dataSave(stockList) async {
    print("저장");
    try {
      final file = await _localFile;
      String data = "";

      for (var i = 0; i < stockList.length; i++) {
        data += stockList[i];
        if (i + 1 < stockList.length) {
          data += ",";
        }
      }

      file.writeAsString(data);
    } catch (e) {
      print("파일 저장 안됨.");
    }
  }

  getData() {
    return stockList;
  }
}