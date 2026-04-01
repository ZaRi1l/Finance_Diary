import 'dart:async';
import 'dart:io';

import 'package:finance_diary/screen/diaryPage.dart';
import 'package:finance_diary/system/diarySystem.dart';
import 'package:finance_diary/data/addData.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


import 'package:csv/csv.dart';

import '../data/diaryListData.dart';

class SeedDialog extends StatefulWidget {
  List dataList;
  SeedDialog(this.dataList);

  @override
  State<SeedDialog> createState() => _SeedDialogState(dataList);
}

class _SeedDialogState extends State<SeedDialog> {
  DateTime date = DateTime.now();
  List addData;
  ListAddData lad = ListAddData();
  late var textFieldNum1;

  _SeedDialogState(this.addData) {
    textFieldNum1 = TextEditingController(text: addData[2].toString());
  }




  @override
  Widget build(BuildContext context2) {
    ScreenUtil.init(context);

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          shadowColor: Colors.transparent,

          title: Container(
            decoration: ShapeDecoration(
                color: Colors.green[500],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)))),
            alignment: Alignment.centerLeft,
            height: 40.h,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5, top: 2),
                  child: Icon(Icons.paid_rounded, color: Colors.white, size: 27.sp),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "금액 설정",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                )
              ],
            ),
          ),
          titlePadding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //------------------------^ 제목 꾸미기

          content: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("시드 머니", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        width: 150.w,
                        height: 30.h,
                        child: TextField(
                          style: TextStyle(fontSize: 15.sp, color: Colors.black),
                          keyboardType: TextInputType.number,
                          controller: textFieldNum1,
                        ),
                      ),
                    ],
                  ),
                  // --------------------^ 팝업메뉴 나중에 변수 추가해야함., 추가삭제 버튼도 만들기
                ],
              ),
            ),
          ),






          actions: [
            ElevatedButton(
              onPressed: () {
                addData[2] = textFieldNum1.text;

                try {
                  double.parse(addData[2]);
                } catch (e) {
                  // Fluttertoast.showToast(       // 토스트 메세지 꾸미기 오류 수정 -----------------------
                  //     msg: "투자금액과 최종금액에 숫자를 입력해주세요.",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.CENTER,
                  //     backgroundColor: Colors.greenAccent,
                  //     textColor: Colors.white,
                  //     fontSize: 16.0
                  // );





                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message:
                      "시드 머니에 숫자만 입력해주세요.",
                    ),
                  );



                  return;
                }
                lad.analDataSave();
                print(addData);
                setState(() {
                  lad.analCal();
                });
                Navigator.pop(context2);
              },

              child: Text("확인", style: TextStyle(fontSize: 15.sp, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400], foregroundColor: Colors.white),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context2);
              },
              child: Text("취소", style: TextStyle(fontSize: 15.sp, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400], foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }

}
