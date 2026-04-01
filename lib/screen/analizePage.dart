import 'package:finance_diary/anal/DiaryFilterDialog2.dart';
import 'package:flutter/material.dart';
import 'package:finance_diary/data/diaryListData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:finance_diary/anal/Chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalizePage extends StatefulWidget {
  const AnalizePage({super.key});

  @override
  State<AnalizePage> createState() => _AnalizePageState();
}

class _AnalizePageState extends State<AnalizePage> {
  ListAddData lad = ListAddData();
  List sw = ["누적수익", "수익"];
  List fcolor = [];
  var index = 0;
  var tum = 1;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    if (ListAddData.analData[1].length != 0) {
      if (double.parse(ListAddData.analData[1]) >= 0.0) {
        fcolor.add(Colors.black);
      } else {
        fcolor.add(Colors.redAccent);
      }

      if (double.parse(ListAddData.analData[4]) >= 0.0) {
        fcolor.add(Colors.black);
      } else {
        fcolor.add(Colors.redAccent);
      }
    } else {
      fcolor.add(Colors.black);
      fcolor.add(Colors.black);
    }


    print("analData임");
    print(ListAddData.analData2);

    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis", style: TextStyle(fontSize: 20.sp),),
        backgroundColor: Colors.green[300],
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 30.w, right: 10.w, left: 7.w),
                height: 400.h,
                child: LineChart(ChartData(index, tum))),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50.w,
                    child: ElevatedButton(
                      onPressed: () {
                        if (tum < 3) {
                          tum += 1;
                        } else {
                          tum = 0;
                        }
                        setState(() {
                          tum;
                        });
                      },
                      child: //Text("I", style: TextStyle(fontSize: 15.sp),),
                      Icon(Icons.circle_outlined, size: 20.sp,),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                        width: 50.w,
                        child: ElevatedButton(
                          onPressed: () async {
                            List filterList;
                            if (lad.getFilter2().length == 0) {
                              filterList = [false, '', '', false, '종목선택'];
                            } else {
                              filterList = lad.getFilter2();
                            }

                            await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return DiaryFilterDialog2(filterList);
                              },
                            );



                            setState(() {
                              lad.getFilterData2();
                              lad.analCal2();
                            });
                          },
                          child: Icon(Icons.filter_alt, size: 22.sp,),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[400],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 10.w,
                      ),


                      Container(
                        width: 90.w,
                        child: ElevatedButton(
                          onPressed: () {
                            if (index == 0) {
                              index = 1;
                            } else if (index == 1) {
                              index = 0;
                            }

                            setState(() {
                              index;
                            });
                          },
                          child: Text(sw[index], style: TextStyle(fontSize: 15.sp),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[400],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),



            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black38), top: BorderSide(color: Colors.black87))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(ListAddData.analData2[0].toString(), style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                      SizedBox(
                          child: Center(
                              child: Text("거래 수",
                                  style: TextStyle(color: Colors.black, fontSize: 14.sp)))),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        ListAddData.analData2[1].toString() + "%",
                        style: TextStyle(color: fcolor[0], fontSize: 14.sp),
                      ),
                      SizedBox(
                          child: Center(
                              child: Text("승률",
                                  style: TextStyle(color: Colors.black, fontSize: 14.sp)))),
                    ],
                  ),
                  Column(
                    children: [
                      Text(ListAddData.analData2[2].toString(), style: TextStyle( fontSize: 14.sp),),
                      SizedBox(
                          child: Center(
                              child: Text("시드 머니",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.sp)))),
                    ],
                  ),
                  Column(
                    children: [
                      Text(ListAddData.analData2[3].toString(),
                          style: TextStyle(color: fcolor[1], fontSize: 14.sp)),
                      SizedBox(
                          child: Center(
                              child: Text("총수익",
                                  style: TextStyle(color: Colors.black, fontSize: 14.sp)))),
                    ],
                  ),
                  Column(
                    children: [
                      Text(ListAddData.analData2[4].toString() + "%",
                          style: TextStyle(color: fcolor[1], fontSize: 14.sp)),
                      SizedBox(
                          child: Center(
                              child: Text("수익률",
                                  style: TextStyle(color: Colors.black, fontSize: 14.sp)))),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              constraints: BoxConstraints(minHeight: 50),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                  width: 85.w,
                      child: Text("총이익", style: TextStyle(fontSize: 14.sp),)),
                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[5].toString() + "(" + ListAddData.analData2[6].toString() + "%)",
                          style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              constraints: BoxConstraints(minHeight: 50),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                    width: 85.w,
                      child: Text("총손실", style: TextStyle(fontSize: 14.sp))),

                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[7].toString() + "(" + ListAddData.analData2[8].toString() + "%)",
                          style: TextStyle(color: Colors.redAccent, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              constraints: BoxConstraints(minHeight: 50.h),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                      width: 85.w,
                      child: Text("수익팩터", style: TextStyle(fontSize: 14.sp))),

                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[9].toString(),
                          style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),


            Container(
              padding: EdgeInsets.all(10),
              height: 75.h,
              constraints: BoxConstraints(minHeight: 50.h),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                    width: 85.w,
                      child: Text("최대손실폭(MDD)", style: TextStyle(fontSize: 14.sp))
                  ),

                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[10].toString() + "(" + ListAddData.analData2[11].toString() + "%)",
                          style: TextStyle(color: Colors.redAccent, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),


            Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              constraints: BoxConstraints(minHeight: 50.h),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                      width: 85.w,
                      child: Text("수익 거래수", style: TextStyle(fontSize: 14.sp))),
                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[12].toString(),
                          style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                    ),
                  ),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                      width: 85.w,
                      child: Text("손실 거래수", style: TextStyle(fontSize: 14.sp))),
                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[13].toString(),
                          style: TextStyle(color: Colors.redAccent, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              constraints: BoxConstraints(minHeight: 50.h),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                      width: 85.w,
                      child: Text("평균 거래", style: TextStyle(fontSize: 14.sp))),
                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[14].toString() + "(" + ListAddData.analData2[15].toString() + "%)",
                          style: TextStyle(color: fcolor[1], fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),



            Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              constraints: BoxConstraints(minHeight: 50.h),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                      width: 85.w,
                      child: Text("평균 수익거래", style: TextStyle(fontSize: 14.sp))),
                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[16].toString(),
                          style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),




            Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              constraints: BoxConstraints(minHeight: 50.h),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                      width: 85.w,
                      child: Text("평균 손실거래", style: TextStyle(fontSize: 14.sp))),
                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[17].toString(),
                          style: TextStyle(color: Colors.redAccent, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),



            Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              constraints: BoxConstraints(minHeight: 50.h),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                      width: 85.w,
                      child: Text("최대 수익거래", style: TextStyle(fontSize: 14.sp))),
                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[18].toString(),
                          style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),





            Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              constraints: BoxConstraints(minHeight: 50.h),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Container(
                      width: 85.w,
                      child: Text("최대 손실거래", style: TextStyle(fontSize: 14.sp))),
                  SizedBox(width: 10.w,),
                  VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(ListAddData.analData2[19].toString(),
                          style: TextStyle(color: Colors.redAccent, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),





          ],
        ),
      ),
    );
  }
}
