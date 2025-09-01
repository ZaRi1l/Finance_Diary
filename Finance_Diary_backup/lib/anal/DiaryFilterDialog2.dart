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

class DiaryFilterDialog2 extends StatefulWidget {
  List dataList;
  DiaryFilterDialog2(this.dataList);

  @override
  State<DiaryFilterDialog2> createState() => _DiaryFilterDialog2State(dataList);
}

class _DiaryFilterDialog2State extends State<DiaryFilterDialog2> {
  DateTime date = DateTime.now();
  DateTime date2 = DateTime.now();
  List addData;
  ListAddData lad = ListAddData();

  _DiaryFilterDialog2State(this.addData) {
    if (addData[0]) {
      date = DateTime.parse(addData[2]);
      date2 = DateTime.parse(addData[1]);
    } else {
      addData[2] = getToday(date);
      var day = addData[2].split('-');
      print(day);
      var n = int.parse(day[0]);
      n -= 1;
      day[0] = n.toString();
      addData[1]= day.join("-");
      date2 = DateTime.parse(addData[1]);
    }
  }




  @override
  Widget build(BuildContext context2) {

    ScreenUtil.init(context);

    return Scaffold(
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
                child: Icon(Icons.filter_alt, color: Colors.white, size: 27.sp),
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                "필터",
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("날짜", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                  Checkbox(
                      value: addData[0],
                      onChanged: (value) {
                        setState(() {
                          addData[0] = value;
                        });
                      },)
                ],
              ),

              Builder(
                builder: (context) {

                  if (addData[0]) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150.w,
                              height: 30.h,
                              child: OutlinedButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context2,
                                    initialDate: date2,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Colors.green,
                                            // header background color
                                            onPrimary: Colors.white,
                                            // header text color
                                            onSurface: Colors.green, // body text color
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  setState(() {
                                    date2 = selectedDate!;
                                    addData[1] = getToday(selectedDate!);
                                  });
                                },
                                child: Text(
                                  addData[1],
                                  style:
                                  TextStyle(fontSize: 17.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10)),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 5.h,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: Text("~", style: TextStyle(fontSize: 17.sp),)),
                            Container(
                              width: 150.w,
                              height: 30.h,
                              child: OutlinedButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context2,
                                    initialDate: date,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Colors.green,
                                            // header background color
                                            onPrimary: Colors.white,
                                            // header text color
                                            onSurface: Colors.green, // body text color
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  setState(() {
                                    date = selectedDate!;
                                    addData[2] = getToday(selectedDate!);
                                  });
                                },
                                child: Text(
                                  addData[2],
                                  style:
                                  TextStyle(fontSize: 17.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Container();
                }
              ),




              //----------------^ 날짜

              SizedBox(
                height: 5.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("종목", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                  Checkbox(
                    value: addData[3],
                    onChanged: (value) {
                      setState(() {
                        addData[3] = value;
                      });
                    },)
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Container(
                  //     height: 30,
                  //     child: Center(
                  //         child: PopupMenuButton(
                  //       child: Container(
                  //         padding: EdgeInsets.only(left: 10, right: 10),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(5), //모서리를 둥글게
                  //           border: Border.all(color: Colors.black12, width: 1),
                  //         ),
                  //         child: Text(
                  //           "삭제",
                  //           style: TextStyle(fontSize: 20),
                  //         ),
                  //       ),
                  //       itemBuilder: (context) {
                  //         return [
                  //           PopupMenuItem(
                  //             child: Text('삭제'),
                  //             onTap: () {
                  //               print('삭제 선택');
                  //             },
                  //           ),
                  //           PopupMenuItem(
                  //               child: Text('수정'),
                  //               onTap: () {
                  //                 print('수정 선택');
                  //               })
                  //         ];
                  //       },
                  //     ))),

                  Builder(
                    builder: (context) {
                      if (addData[3]) {
                        return Container(
                          width: 150.w,
                          height: 30.h,
                          child: OutlinedButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return SelectStock(addData);
                                  });
                              setState(() {
                                addData;
                              });
                            },
                            child: Text(
                              addData[4],
                              style:
                              TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.normal),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.only(left: 10, right: 10)),
                          ),
                        );
                      }
                      return Container();
                    }
                  )
                ],
              ),
              // --------------------^ 팝업메뉴 나중에 변수 추가해야함., 추가삭제 버튼도 만들기
            ],
          ),
        ),






        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                lad.dataFilter2(addData);
                print(addData);
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
    );
  }

  String getToday(DateTime date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    var strToday = formatter.format(date);
    return strToday;
  }
}

//
//
//-------------------- 종목추가선택
//
//

class SelectStock extends StatefulWidget {
  List addData;

  SelectStock(this.addData);

  @override
  State<SelectStock> createState() => _SelectStockState(addData);
}

class _SelectStockState extends State<SelectStock> {
  final textField1 = TextEditingController();
  List addData;

  AddData ad = AddData();

  _SelectStockState(this.addData) {
    ad.dataInitial().then(
          (_) {
        setState(() {
          ad.getData();
        });
      },
    );
  }


  @override
  Widget build(BuildContext context3) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: SingleChildScrollView(
          child: AlertDialog(
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
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "종목선택",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  )
                ],
              ),
            ),
            titlePadding: const EdgeInsets.all(0),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //------------------------^ 제목 꾸미기

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 150.w,
                      height: 30.h,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: textField1,
                        maxLines: 1,
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          ad.getData().add(textField1.text);
                          ad.dataSave(ad.getData());
                        });
                      },
                      icon: Icon(
                        Icons.add_box,
                        color: Colors.green[400],
                        size: 26.sp,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 300.h,
                  width: 200.w,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: ad.getData().length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.only(left: 5, top: 2),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black26))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      addData[4] = ad.getData()[index];
                                      ad.dataSave(ad.getData());
                                    });
                                    Navigator.pop(context3);
                                  },
                                  child: Text(
                                    ad.getData()[index],
                                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ad.getData().remove(ad.getData()[index]);
                                    ad.dataSave(ad.getData());
                                  });
                                },
                                icon: Icon(
                                  Icons.delete_forever,
                                  color: Colors.green[400],
                                  size: 26.sp,
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ),
              ],
            ),

            actions: [
              ElevatedButton(
                onPressed: () {
                  ad.dataSave(ad.getData());
                  Navigator.pop(context3);
                },
                child: Text("취소", style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400], foregroundColor: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}




