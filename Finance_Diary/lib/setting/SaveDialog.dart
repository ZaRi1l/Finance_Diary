import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';


import 'package:csv/csv.dart';

import '../data/diaryListData.dart';
import 'package:finance_diary/main.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:finance_diary/Ads.dart';


class SaveDialog extends StatefulWidget {
  SaveDialog();

  @override
  State<SaveDialog> createState() => _SaveDialogState();
}

class _SaveDialogState extends State<SaveDialog> {
  ListAddData lad = ListAddData();
  final textFieldNum1 = TextEditingController(text: "투자 거래내역");


  _SaveDialogState() {
    if(rewardedAd == null) {
      loadRewardFullBanner();
    }
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
                  child: Icon(Icons.save_outlined, color: Colors.white, size: 28.sp),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "저장",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                )
              ],
            ),
          ),
          titlePadding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //------------------------^ 제목 꾸미기

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("파일 경로", style: TextStyle(fontSize: 15.sp),),
                    SizedBox(
                      width: 10.w,
                    ),
                    Flexible(child: Text("/storage/emulated/0/Download", style: TextStyle(fontSize: 15.sp))),

                  ],
                ),

                SizedBox(
                  height: 10.h,
                ),


                Row(
                  children: [
                    Text("파일 이름", style: TextStyle(fontSize: 15.sp)),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 150.w,
                      height: 30.h,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: textFieldNum1,
                        style: TextStyle(fontSize: 15.sp)
                      ),
                    ),
                  ],
                ),
                // --------------------^ 팝업메뉴 나중에 변수 추가해야함., 추가삭제 버튼도 만들기
              ],
            ),
          ),






          actions: [
            ElevatedButton(
              onPressed: () {
                // ----- 저장 안되는 중 오류 확인 하기
                
                try {
                  rewardedAd!.show(onUserEarnedReward: (ad, reward) {
                    print("----------------------------보상");
                    var fname = textFieldNum1.text + ".xlsx";
                    lad.csvSave(fname);
                    print("엑셀저장 완료");
                    Navigator.pop(context2);

                    Fluttertoast.showToast(msg: "파일 저장 완료(경로: /storage/emulated/0/Download)", toastLength: Toast.LENGTH_LONG);
                  });
                } catch(E) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message:
                      "인터넷에 연결해주세요.",
                    ),
                  );
                }

                loadRewardFullBanner();
                print("광고 재로딩 완료");

              },

              child: Text("광고 보고 추출하기", style: TextStyle(fontSize: 15.sp)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400], foregroundColor: Colors.white),
            ),

            ElevatedButton(
              onPressed: () {
                loadRewardFullBanner();
                print("광고 재로딩 완료");
                Navigator.pop(context2);
              },
              child: Text("취소", style: TextStyle(fontSize: 15.sp)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400], foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }

}


