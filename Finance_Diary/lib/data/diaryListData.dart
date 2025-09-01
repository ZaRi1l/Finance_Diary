
import 'dart:convert';
import 'dart:math';

import 'package:finance_diary/system/diarySystem.dart';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:excel/excel.dart';


class ListAddData {
  static late List<List<dynamic>> diaryList;
  static late List<List<dynamic>> diaryFilterList=[];
  static late List<List<dynamic>> diaryFilterList2=[];
  static List filterList = [];
  static List filterList2 = [];
  static List analData = [0, '', '1000', '', ''];
  static List analData2 = [];
  static List allProfit = [];


  Future<String> dataLoad() async {

    try {
      final file = await _localFile;

      // Read the file
      final input = file.openRead();
      final contents = await input.transform(utf8.decoder).transform(CsvToListConverter()).toList();
      diaryList = contents;
      print("dataLoad ");
    } catch (e) {
      print("dataLoad 오류 발생");

      final file = await _localFile;
      file.create();

      diaryList = [];
      print("dataLoad2");

    }

    diaryFilterList.clear();
    diaryFilterList.addAll(diaryList);
    diaryFilterList2.clear();
    diaryFilterList2.addAll(diaryList.reversed);
    calAllProfit();



    try {
      final file = await _localFile2;

      // Read the file
      final contents = await file.readAsString();
      analData[2] = contents;

    } catch (e) {
      final file = await _localFile2;

      file.create();

      file.writeAsString('1000');

      final contents = await file.readAsString();

      analData[2] = contents;
    }

    analCal();
    analCal2();

    return "d";
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/diaryList.csv");
  }

  Future<String> get _localPath2 async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile2 async {
    final path = await _localPath2;
    return File("$path/anal.txt");
  }

  dataAdd(data) async {
    try {

      if (diaryList.length == 0) {
        diaryList.add(data);
      } else {
        var i = daySoltIndex(data);
        diaryList.insert(i, data);
      }

      print(daySoltIndex(data));

      cal();

      diaryFilterList.clear();
      diaryFilterList.addAll(diaryList);
      diaryFilterList2.clear();
      diaryFilterList2.addAll(diaryList.reversed);

      save(diaryList);



    } catch (e) {
      print("");
    }
  }

  dataAdd2(index, data, length) async {
    if (index == 0) {
      diaryList.clear();
    }

    try {

      if (diaryList.length == 0) {
        diaryList.add(data);
      } else {
        var i = daySoltIndex(data);
        diaryList.insert(i, data);
      }

      print(daySoltIndex(data));

      cal();

      if (index >= length - 1) {
        diaryFilterList.clear();
        diaryFilterList.addAll(diaryList);
        diaryFilterList2.clear();
        diaryFilterList2.addAll(diaryList.reversed);

        save(diaryList);

      }



    } catch (e) {
      print("");
    }
  }


  cal() {   // 수익 수익률 계산
    for(var i = 0; i < diaryList.length; i ++) {
      if(diaryList[i].length < 6) {
        var sum = double.parse(diaryList[i][3]) - double.parse(diaryList[i][2]);
        diaryList[i].add(sum);

        sum = sum / double.parse(diaryList[i][2]) * 100;
        var sum2 = sum.toStringAsFixed(2);
        diaryList[i].add(sum2);
      }
    }
  }

  save(data) async {
    try{
      final file = await _localFile;

      diaryList = List.from(data);

      String csv = const ListToCsvConverter().convert(diaryList);
      file.writeAsString(csv);

      print(diaryList);
      print("저장");

    } catch (e) {
      print("파일 저장 안됨.");
    }
  }

  getData() {
    return diaryList;
  }

  daySoltIndex(data) {
    var dayNum = dayCutting(data[0]);

    for (var i = 0; i < diaryList.length; i ++) {
      if (i == 0){
        if (dayNum >= dayCutting(diaryList[i][0])) {
          return 0;
        }
      } else {
        if (dayCutting(diaryList[i - 1][0]) > dayNum && dayNum >= dayCutting(diaryList[i][0])) {
          return i;
        }
      }
    }

    return diaryList.length;
  }

  dayCutting(day) {
    day = day.split("-");
    var dayNum = int.parse(day[0] + day[1] + day[2]);
    return dayNum;
  }

  dayCutting2(day) {
    day = day.split("-");
    var dayNum = double.parse(day[0] + day[1] + day[2]);
    return dayNum;
  }



  // --- 필터 부분


  void dataFilter(data) {
    filterList = data;
    List demo = [];

    diaryFilterList.clear();

    if (filterList[0]) {
      for(var i = 0; i <  diaryList.length; i ++) {
        if(dayCutting(filterList[1]) <= dayCutting(diaryList[i][0]) && dayCutting(diaryList[i][0]) <= dayCutting(filterList[2])) {
          demo.add(diaryList[i]);
        }
      }
    } else {
      for(var i = 0; i <  diaryList.length; i ++) {
        demo.add(diaryList[i]);
      }
    }

    if (filterList[3]) {
      for(var i = 0; i <  demo.length; i ++) {
        if(demo[i][1].compareTo(filterList[4]) == 0) {
          diaryFilterList.add(demo[i]);
        }
      }
    } else {
      for(var i = 0; i <  diaryList.length; i ++) {
        diaryFilterList.add(demo[i]);
      }
    }

  }

  void dataFilter2(data) {
    filterList2 = data;
    List demo = [];

    diaryFilterList2.clear();

    if (filterList2[0]) {
      for(var i = 0; i <  diaryList.length; i ++) {
        if(dayCutting(filterList2[1]) <= dayCutting(diaryList[i][0]) && dayCutting(diaryList[i][0]) <= dayCutting(filterList2[2])) {
          demo.add(diaryList[i]);
        }
      }
    } else {
      for(var i = 0; i <  diaryList.length; i ++) {
        demo.add(diaryList[i]);
      }
    }

    if (filterList2[3]) {
      for(var i = 0; i <  demo.length; i ++) {
        if(demo[i][1].compareTo(filterList2[4]) == 0) {
          diaryFilterList2.add(demo[i]);
        }
      }
    } else {
      for(var i = 0; i <  diaryList.length; i ++) {
        diaryFilterList2.add(demo[i]);
      }
    }

    diaryFilterList2 = List.from(diaryFilterList2.reversed);

  }

  getFilter() {
    return filterList;
  }

  getFilter2() {
    return filterList2;
  }

  getFilterData() {
    return diaryFilterList;
  }

  getFilterData2() {
    return diaryFilterList2;
  }

  getAllProfit() {
    return allProfit;
  }



  //--- 분석 부분

  analDataSave() async {
    final file = await _localFile2;
    file.writeAsString(analData[2].toString());
  }



  analCal() {
    analData[0] = diaryFilterList.length;

    var win = 0;
    for(var i = 0; i < diaryFilterList.length ; i++) {
      if(diaryFilterList[i][5] >= 0) {
        win++;
      }
    }
    var rate = win / diaryFilterList.length * 100;
    var rate2 = rate.toString();
    if (rate2.length > 6) {
      rate2 = rate2.substring(0,5);
    }
    analData[1] = rate2;

    var money = 0.0;
    for(var i = 0; i < diaryFilterList.length ; i ++) {
      money += diaryFilterList[i][5];
    }
    analData[3] = money.toString();

    var prate = double.parse(analData[3]) / double.parse(analData[2]) * 100;
    var prate3 = prate.toString();
    if (prate3.length > 6) {
      prate3 = prate3.substring(0,5);
    }
    analData[4] = prate3;

  }

  // analCal2(data) {
  //   analData[0] = data.length.toString();
  //
  //   var win = 0;
  //   for(var i = 0; i < data.length ; i++) {
  //     if(data[i][5] >= 0) {
  //       win++;
  //     }
  //   }
  //   var rate = win / data.length * 100;
  //   var rate2 = rate.toString();
  //   if (rate2.length > 6) {
  //     rate2 = rate2.substring(0,5);
  //   }
  //   analData[1] = rate2;
  //
  //   var money = 0.0;
  //   for(var i = 0; i < data.length ; i ++) {
  //     money += data[i][5];
  //   }
  //   analData[3] = money.toString();
  //
  //   var prate = double.parse(analData[3]) / double.parse(analData[2]) * 100;
  //   var prate3 = prate.toString();
  //   if (prate3.length > 6) {
  //     prate3 = prate3.substring(0,5);
  //   }
  //   analData[4] = prate3;
  //
  // }


  calAllProfit() {
    allProfit.clear();
    double adds = 0.0;


    for(var i = 0; i< diaryFilterList2.length; i++) {
      adds += diaryFilterList2[i][5];
      allProfit.add(adds);
    }


  }

  analCal2() {
    analData2.clear();
    analData2.add(diaryFilterList2.length.toString()); //0


    // 승패
    var win = 0;
    var lose = 0;

    var winList = [];
    var loseList = [];

    for(var i = 0; i < diaryFilterList2.length ; i++) {
      if(diaryFilterList2[i][5] >= 0) {
        win++;
        winList.add(diaryFilterList2[i][5]);
      } else {
        lose++;
        loseList.add(diaryFilterList2[i][5]);
      }
    }
    if(winList.length == 0) {
      winList.add(0.0);
    }
    if(loseList.length == 0) {
      loseList.add(0.0);
    }


    var rate = win / diaryFilterList2.length * 100;
    analData2.add(rate.toStringAsFixed(2)); //1

    analData2.add(analData[2]); //2


    var mLength = analData2[2].toString().length;



    var money = 0.0;
    var maxMoney = 0.0;
    // 최대손실폭 mdd
    var mddList = [];
    var mddList2 = [];

    for(var i = 0; i < diaryFilterList2.length ; i ++) {
      var fmoney = money;

      money += diaryFilterList2[i][5];


      if (fmoney < money && maxMoney < money) {
        maxMoney = money;
      }
      if (maxMoney > money) {
        mddList.add(money - maxMoney);
        mddList2.add((money - maxMoney) / maxMoney * 100);
      }

    }
    analData2.add(money.toString()); //3



    var prate = double.parse(analData2[3]) / double.parse(analData2[2]) * 100;
    analData2.add(prate.toStringAsFixed(2)); //4
    



    // 상세분석

    // 총이익,총손해
    var profit = 0.0, loss = 0.0;

    for(var i = 0; i < diaryFilterList2.length ; i ++) {

      // 이익 손실 나누기
      if (0.0 < diaryFilterList2[i][5]) {
        profit += diaryFilterList2[i][5];
      } else {
        loss += diaryFilterList2[i][5];
      }



    }

    analData2.add(profit);//5 //총이익
    var prorate = analData2[5] / double.parse(analData2[2]) * 100;
    analData2.add(prorate.toStringAsFixed(2));//6 이익퍼센트

    analData2.add(loss);//7 총손실
    var lossRate = analData2[7] / double.parse(analData2[2]) * 100;
    analData2.add(lossRate.toStringAsFixed(2));//8 손실퍼센트

    //수익팩터
    var profitFector = analData2[5] / -analData2[7];
    analData2.add(profitFector.toStringAsFixed(2)); //9 수익팩터


    // 최대손실폭 mdd 이어서 계산
    var min;
    var min2;
    try {
      min = mddList.reduce((current, next) => current < next ? current : next);
      min2 = mddList2.reduce((current, next) => current < next ? current : next);
    } catch (E) {
      min = 0.0;
      min2 = 0.0;
    }

    analData2.add(min);//10 mdd 값

    analData2.add(min2.toStringAsFixed(2));//11 mdd 퍼센트 값
    

    // 승패 추가
    analData2.add(win); //12
    analData2.add(lose);  //13


    // 평균거래 추가
    var avg = (double.parse(analData2[3]) / double.parse(analData2[0])).toStringAsFixed(2);
    analData2.add(avg); //14

    var avgRate = double.parse(avg) / double.parse(analData2[2]) * 100;
    analData2.add(avgRate.toStringAsFixed(2)); //15

    // 수익, 손실 거래 분석
    winList.sort();
    print(winList);
    loseList.sort();
    print(loseList);

    var winSum = 0.0;
    var loseSum = 0.0;

    for (var i = 0; i < winList.length; i ++) {
      winSum += winList[i];
    }
    for (var i = 0; i < loseList.length; i ++) {
      loseSum += loseList[i];
    }

    var winAvg = (winSum/winList.length).toStringAsFixed(2);

    var loseAvg = (loseSum/loseList.length).toStringAsFixed(2);

    analData2.add(winAvg); //16 평균 수익거래
    analData2.add(loseAvg); //17 평균 손실거래

    analData2.add(winList[winList.length - 1]); // 18 최대 수익거래
    analData2.add(loseList[0]); // 19 최대 손실거래래

  }




  csvSave(fname) {
    List<List<dynamic>> csvList = [["날짜", "종목", "투자금액", "최종금액", "수익", "수익률", "메모"]];

    for(var i = 0; i < diaryList.length; i++) {
      List line = [];
      line.add(diaryList[i][0]);
      line.add(diaryList[i][1]);
      line.add(diaryList[i][2]);
      line.add(diaryList[i][3]);
      line.add(diaryList[i][5]);
      line.add(diaryList[i][6]);
      line.add(diaryList[i][4]);

      csvList.add(line);
    }

    // String csv = const ListToCsvConverter().convert(csvList);
    //
    // FileStorage.writeCounter(csv, fname);

    var excel = Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    Sheet sheetObject = excel[fname];
    excel.delete("Sheet1");

    for(var i = 0; i < csvList.length; i++) {
      // 각 항목을 문자열로 변환한 후, TextCellValue 객체로 만듭니다.
      List<CellValue> rowData = csvList[i].map((cell) => TextCellValue(cell.toString())).toList();
      sheetObject.appendRow(rowData);
    }
    print(sheetObject);
    FileStorage.writeCounter(excel.save(), fname);


  }

}








// To save the file in the device
class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeCounter(bytes,String name) async {
    final path = await _localPath;
    // Create a file for the path of
    // device and file name with extension
    File file= File('$path/$name');;
    print("Save file");

    // Write the data in the file you have created
    return file.writeAsBytes(bytes);
  }
}
