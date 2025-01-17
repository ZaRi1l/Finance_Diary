



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../data/addData.dart';
import '../data/diaryListData.dart';
import 'diarySystem.dart';

class DiaryEditDialog extends StatefulWidget {
  List dataList;
  DiaryEditDialog(this.dataList);

  @override
  State<DiaryEditDialog> createState() => _DiaryEditDialogState(dataList);
}

class _DiaryEditDialogState extends State<DiaryEditDialog> {
  DateTime date = DateTime.now();
  List addData;
  List editData = [];
  var textFieldNum1;
  var textFieldNum2;
  var textFieldMemo;


  _DiaryEditDialogState(this.addData) {
    editData.clear();
    for(var i = 0; i < addData.length; i++){
      editData.add(addData[i]);
    }

    textFieldNum1 = TextEditingController(text: editData[2].toString());
    textFieldNum2 = TextEditingController(text: editData[3].toString());
    textFieldMemo = TextEditingController(text: editData[4]);
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
                  child: Icon(Icons.mode_edit, color: Colors.white, size: 27.sp),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "수정",
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
                    Text("날짜", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                    Container(
                      width: 150.w,
                      height: 30.h,
                      child: OutlinedButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context2,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.green, // header background color
                                    onPrimary: Colors.white, // header text color
                                    onSurface: Colors.green, // body text color
                                  ),
                                ),
                                child: child!,
                              );
                            }, initialDate: DateTime.parse(editData[0]),
                          );
                          setState(() {
                            date = selectedDate!;
                            editData[0] = getToday(selectedDate!);
                          });
                        },
                        child: Text(
                          editData[0],
                          style:
                          TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.only(left: 10, right: 10)),
                      ),
                    )
                  ],
                ),
                //----------------^ 날짜

                SizedBox(
                  height: 5.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("종목", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                    SizedBox(
                      width: 10.w,
                    ),
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

                    Container(
                      width: 150.w,
                      height: 30.h,
                      child: OutlinedButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return SelectStock(editData);
                              });
                          setState(() {
                            editData;
                          });
                        },
                        child: Text(
                          editData[1],
                          style:
                          TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.only(left: 10, right: 10)),
                      ),
                    )
                  ],
                ),
                // --------------------^ 팝업메뉴 나중에 변수 추가해야함., 추가삭제 버튼도 만들기

                SizedBox(
                  height: 5.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("투자금액", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
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

                SizedBox(
                  height: 5.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("최종금액", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 150.w,
                      height: 30.h,
                      child: TextField(
                        style: TextStyle(fontSize: 15.sp, color: Colors.black),
                        keyboardType: TextInputType.number,
                        controller: textFieldNum2,
                      ),
                    ),
                  ],
                ),


                SizedBox(
                  height: 20.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("메모", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 150.w,
                      height: 150.h,
                      child: TextField(
                        style: TextStyle(fontSize: 15.sp, color: Colors.black),
                        keyboardType: TextInputType.text,
                        controller: textFieldMemo,
                        decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                        maxLines: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),






          actions: [
            ElevatedButton(
              onPressed: () {
                editData[2] = textFieldNum1.text;
                editData[3] = textFieldNum2.text;
                editData[4] = textFieldMemo.text;

                try {
                  double.parse(editData[2]);
                  double.parse(editData[3]);
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
                      "투자금액과 최종금액에 숫자를 입력해주세요.",
                    ),
                  );

                  return;

                }
                Navigator.pop(context2);

                addData.clear();
                for(var i = 0; i < editData.length; i++){
                  addData.add(editData[i]);
                }


                addData.removeLast();
                addData.removeLast();



                setState(() {
                  addData;
                });
              },
              child: Text("수정", style: TextStyle(fontSize: 15.sp, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400], foregroundColor: Colors.white),
            ),

            ElevatedButton(
              onPressed: () {
                addData[2] = "삭제";
                Navigator.pop(context2);
              },
              child: Text("삭제", style: TextStyle(fontSize: 15.sp, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
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
    return Center(
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
                      style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      keyboardType: TextInputType.text,
                      controller: textField1,
                      maxLines: 1,
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
                                    addData[1] = ad.getData()[index];
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
    );
  }
}


