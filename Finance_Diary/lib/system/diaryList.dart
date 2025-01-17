import 'package:finance_diary/data/diaryListData.dart';
import 'package:flutter/material.dart';
import 'package:finance_diary/system/diaryEditSystem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/addData.dart';
import '../screen/diaryPage.dart';
import 'diarySystem.dart';

// 리스트뷰
class DiaryList extends StatefulWidget {
  List<List<dynamic>> diaryList;

  DiaryList(this.diaryList, {super.key});

  @override
  State<DiaryList> createState() => _DiaryListState(diaryList);
}

class _DiaryListState extends State<DiaryList> {
  ListAddData lad = ListAddData();
  late List<List<dynamic>> diaryList;

  _DiaryListState(this.diaryList);



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(diaryList);

  }


  @override
  Widget build(BuildContext context) {
    DiaryPageState? parent = context.findAncestorStateOfType<DiaryPageState>();
    ScreenUtil.init(context);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: diaryList.length,
      itemBuilder: (context, index) {
        var fcolor;
        if (diaryList[index][5] < 0) {
          fcolor = Colors.redAccent;
        } else {
          fcolor = Colors.black;
        }

        return Container(
          color: Colors.white,

          child: GestureDetector(
            onLongPress: () async {
              ListAddData lad = ListAddData();


              List editData = [];


              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return DiaryEditDialog(diaryList[index]);
                },
              );

                if (diaryList[index][2].compareTo("삭제") == 0) {
                  await diaryList.removeAt(index);
                  setState(() {
                    diaryList;
                    lad.save(diaryList);
                  });
                  parent!.setState(() {
                    lad.analCal();
                  });
                } else {
                  setState(() {
                    diaryList;
                    lad.cal();
                    lad.save(diaryList);
                  });
                  parent!.setState(() {
                    lad.analCal();
                  });
                }

                List a = [];
                a.addAll(diaryList);
                //diaryList.clear();


                for(var i = 0; i < a.length; i++) {
                  lad.dataAdd2(i, a[i], a.length);
                }

                a.clear();
                a.addAll(diaryList);

                for(var i = 0; i < a.length; i++) {
                  lad.dataAdd2(i, a[i], a.length);
                }









            },
            child: Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),


                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(minHeight: 30.h, minWidth: double.infinity),

                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                              width: 65.w,
                              child: Center(
                                  child:
                                  Text(diaryList[index][0].toString(), style: TextStyle(color: Colors.black, fontSize: 11.sp),))),

                          SizedBox(
                            height: 20.h,
                            child: VerticalDivider(
                              thickness: 2.0,
                              color: Colors.black12,
                              width: 0.w,
                            ),
                          ),

                          Container(
                              padding: EdgeInsets.all(4),
                              width: 55.w,
                              child: Center(
                                  child:
                                  Text(diaryList[index][1].toString(), style: TextStyle(color: Colors.black, fontSize: 11.sp),))),

                          SizedBox(
                            height: 20.h,
                            child: VerticalDivider(
                              thickness: 2.0,
                              color: Colors.black12,
                              width: 0.w,
                            ),
                          ),


                          Container(
                              padding: EdgeInsets.all(4),
                              width: 65.w,
                              child: Center(
                                  child:
                                  Text(diaryList[index][2].toString(), style: TextStyle(color: Colors.black, fontSize: 11.sp),))),

                          SizedBox(
                            height: 20.h,
                            child: VerticalDivider(
                              thickness: 2.0,
                              color: Colors.black12,
                              width: 0.w,
                            ),
                          ),



                          Container(
                              padding: EdgeInsets.all(4),
                              width: 65.w,
                              child: Center(
                                  child:
                                  Text(diaryList[index][3].toString(), style: TextStyle(color: Colors.black, fontSize: 11.sp),))),

                          SizedBox(
                            height: 20.h,
                            child: VerticalDivider(
                              thickness: 2.0,
                              color: Colors.black12,
                              width: 0.w,
                            ),
                          ),



                          Container(
                              padding: EdgeInsets.all(4),
                              width: 55.w,
                              child: Center(
                                  child:
                                  Text(diaryList[index][5].toString(), style: TextStyle(color: fcolor, fontSize: 11.sp),))),

                          SizedBox(
                            height: 20.h,
                            child: VerticalDivider(
                              thickness: 2.0,
                              color: Colors.black12,
                              width: 0.w,
                            ),
                          ),



                          Container(
                              padding: EdgeInsets.all(4),
                              width: 55.w,
                              child: Center(
                                  child:
                                  Text(diaryList[index][6].toString() + "%", style: TextStyle(color: fcolor, fontSize: 11.sp),))),


                        ],
                      ),
                    ),

                    Builder(builder: (context) {
                      if(diaryList[index][4].length == 0) {
                        return SizedBox();
                      } else {
                        return Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(bottom: 10, right: 5, left: 5),
                            child: Row(
                              children: [
                                Icon(Icons.subdirectory_arrow_right, color: Colors.greenAccent, size: 15.sp,)
                                ,
                                Flexible(
                                  child: Text(diaryList[index][4],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11.sp
                                  ),
                                  ),
                                ),
                              ],
                            )
                        );
                      }
                    },)
                    // builder에 함수내에 조건문 걸어서 4번째 메모 값이 없으면 공간 안차지하게 만들기
                  ],
                ),
              ),
            ),
          )


          // Center(
          //   child: Text(diaryList[index].toString()),
          // ),
        );
      },
    );
  }
}
