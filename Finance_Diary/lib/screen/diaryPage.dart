import 'package:finance_diary/data/addData.dart';
import 'package:finance_diary/data/diaryListData.dart';
import 'package:finance_diary/system/diaryList.dart';
import 'package:finance_diary/system/diarySystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:async/async.dart';

import '../system/DiaryFilterDialog.dart';
import '../system/SeedDialog.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => DiaryPageState();
}

class DiaryPageState extends State<DiaryPage> {
  ListAddData lad = ListAddData();
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  List fcolor = [Colors.black, Colors.black];

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {

    if (ListAddData.analData[0] > 0) {
      if (double.parse(ListAddData.analData[1]) >= 0.0) {
        fcolor[0] = Colors.black;
      } else {
        fcolor[0] = Colors.redAccent;
      }

      if (double.parse(ListAddData.analData[4]) >= 0.0) {
        fcolor[1] = Colors.black;
      } else {
        fcolor[1] = Colors.redAccent;
      }
      print("hi");
    } else {
      fcolor[0] = Colors.black;
      fcolor[1] = Colors.black;
    }

    print(fcolor);



    ScreenUtil.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Trading Diary", style: TextStyle(fontSize: 20.sp),),
        backgroundColor: Colors.green[300],
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              List filterList;
              if (lad.getFilter().length == 0) {
                filterList = [false, '', '', false, '종목선택'];
              } else {
                filterList = lad.getFilter();
              }

              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return DiaryFilterDialog(filterList);
                },
              );

              setState(() {
                lad.getFilterData();
                lad.save(lad.getData());
                lad.analCal();
              });


              print(lad.getFilterData());

            },
            icon: Icon(
              Icons.filter_alt,
              size: 30.sp,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          IconButton(
            onPressed: () async {
              
              //데이터 초기화
              AddData ad = AddData();

              ad.dataInitial();

              // 데이터 입력
              List dataList = ['', '종목선택', 0, 0,''];

              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return DiaryAddDialog(dataList);
                },
              );

              print("도출값: " + dataList.toString());

              setState(() {
                lad.getFilterData();
                lad.save(lad.getData());
                lad.analCal();
              });


            },
            icon: Icon(
              Icons.add_box,
              size: 30.sp,
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {},
          //       child: Icon(
          //         Icons.filter_alt,
          //         size: 30,
          //       ),
          //       style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.green[500],
          //           foregroundColor: Colors.white,
          //           minimumSize: const Size(100, 35),
          //           shadowColor: Colors.transparent),
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         setState(() {
          //           diaryList.add('dd');
          //         });
          //       },
          //       child: Icon(
          //         Icons.add_box,
          //         size: 30,
          //       ),
          //       style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.green[500],
          //           foregroundColor: Colors.white,
          //           minimumSize: const Size(100, 35),
          //           shadowColor: Colors.transparent),
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //   ],
          // ),
          // ------------------------ ^ 필터 + 추가 버튼 ----------------------------

          Container(
            height: 25.h,
            color: Colors.green[300],
            child: Row(
              children: [
                SizedBox(
                    width: 65.w,
                    child: Center(
                        child:
                            Text("날짜", style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                VerticalDivider(
                  thickness: 2.0,
                  color: Colors.white,
                  width: 0,
                ),
                SizedBox(
                    width: 55.w,
                    child: Center(
                        child:
                            Text("종목", style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                VerticalDivider(
                  thickness: 2.0,
                  color: Colors.white,
                  width: 0,
                ),
                SizedBox(
                    width: 65.w,
                    child: Center(
                        child: Text("투자금액",
                            style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                VerticalDivider(
                  thickness: 2.0,
                  color: Colors.white,
                  width: 0,
                ),
                SizedBox(
                    width: 65.w,
                    child: Center(
                        child: Text("최종금액",
                            style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                VerticalDivider(
                  thickness: 2.0,
                  color: Colors.white,
                  width: 0,
                ),
                SizedBox(
                    width: 55.w,
                    child: Center(
                        child:
                            Text("수익", style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                VerticalDivider(
                  thickness: 2.0,
                  color: Colors.white,
                  width: 0,
                ),
                SizedBox(
                    width: 55.w,
                    child: Center(
                        child: Text("수익률",
                            style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
              ],
            ),
          ),
          //-----------------------------------^ 칼럼



          //
          //
          //
          //
          //
          // ---------------------------------------------------- futureBuiler 가 리빌딩 될 수 있도록  수정하기 ( 그냥 빌더일 때는 setState() 로 됨)
          FutureBuilder(
              future: _future(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                //해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
                if (snapshot.hasData == false || lad.getData().length == 0) {

                  return Expanded(
                      child: Center(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_box,
                            size: 20.sp,
                              color: Colors.green[700]
                          ),
                          Text("를 눌러 거래목록을 추가하세요."
                          ,style: TextStyle(fontSize: 20.sp, color: Colors.green[700]),
                          ),
                        ],
                      ))
                  );// CircularProgressIndicator : 로딩 에니메이션
                }

                else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Text(
                      "데이터 없음", // 에러명을 텍스트에 뿌려줌
                      style: TextStyle(fontSize: 15.sp, color: Colors.black),
                    ),
                  );
                }

                // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
                else {

                  return Expanded(
                      child: DiaryList(ListAddData.diaryFilterList)
                  );
                }
              }),

          //-----------------------^ 리스트뷰


          FutureBuilder(
              future: _future2(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                //해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
                if (snapshot.hasData == false || lad.getData().length == 0) {

                  return Container(
                    color: Colors.green[300],
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(ListAddData.analData[0].toString(), style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                            SizedBox(
                                width: 65.w,
                                child: Center(
                                    child: Text("거래 수",
                                        style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                        Column(
                          children: [
                            Text("0%", style: TextStyle(color: fcolor[0], fontSize: 14.sp),),
                            SizedBox(
                                width: 70.w,
                                child: Center(
                                    child: Text("승률",
                                        style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              child: OutlinedButton(
                                onPressed: () async {

                                  await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return SeedDialog(ListAddData.analData);
                                    },
                                  );

                                  ListAddData lad = ListAddData();


                                  setState(() {
                                    ListAddData.analData;
                                    lad.analCal2();
                                  });


                                },
                                child: Text(ListAddData.analData[2].toString(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.sp),),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                              height: 20.h,
                            ),
                            SizedBox(
                                width: 90.w,
                                child: Center(
                                    child: Text("시드 머니",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                        Column(
                          children: [
                            Text(ListAddData.analData[3].toString(), style: TextStyle(color: fcolor[1], fontSize: 14.sp)),
                            SizedBox(
                                width: 75.w,
                                child: Center(
                                    child: Text("총수익",
                                        style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                        Column(
                          children: [
                            Text(ListAddData.analData[4].toString() + "%", style: TextStyle(color: fcolor[1], fontSize: 14.sp)),
                            SizedBox(
                                width: 60.w,
                                child: Center(
                                    child: Text("수익률",
                                        style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                      ],
                    ),
                  );// CircularProgressIndicator : 로딩 에니메이션
                }

                else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Text(
                      "데이터 없음", // 에러명을 텍스트에 뿌려줌
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  );
                }

                // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
                else {

                  return  Container(
                    color: Colors.green[300],
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(ListAddData.analData[0].toString(), style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                            SizedBox(
                                width: 65.w,
                                child: Center(
                                    child: Text("거래 수",
                                        style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                        Column(
                          children: [
                            Text(ListAddData.analData[1].toString() + "%", style: TextStyle(color: fcolor[0], fontSize: 14.sp),),
                            SizedBox(
                                width: 70.w,
                                child: Center(
                                    child: Text("승률",
                                        style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              child: OutlinedButton(
                                onPressed: () async {

                                  await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return SeedDialog(ListAddData.analData);
                                    },
                                  );

                                  ListAddData lad = ListAddData();


                                  setState(() {
                                    ListAddData.analData;
                                    lad.analCal2();
                                  });


                                },
                                child: Text(ListAddData.analData[2].toString(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.sp),),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                              height: 20.h,
                            ),
                            SizedBox(
                                width: 90.w,
                                child: Center(
                                    child: Text("시드 머니",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                        Column(
                          children: [
                            Text(ListAddData.analData[3].toString(), style: TextStyle(color: fcolor[1], fontSize: 14.sp)),
                            SizedBox(
                                width: 75.w,
                                child: Center(
                                    child: Text("총수익",
                                        style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                        Column(
                          children: [
                            Text(ListAddData.analData[4].toString() + "%", style: TextStyle(color: fcolor[1], fontSize: 14.sp)),
                            SizedBox(
                                width: 60.w,
                                child: Center(
                                    child: Text("수익률",
                                        style: TextStyle(color: Colors.white, fontSize: 14.sp)))),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }),


          // Container(
          //   color: Colors.green[300],
          //   child: Row(
          //     children: [
          //       Column(
          //         children: [
          //           Text(ListAddData.analData[0].toString()),
          //           SizedBox(
          //               width: 75,
          //               child: Center(
          //                   child: Text("거래 수",
          //                       style: TextStyle(color: Colors.white)))),
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Text(ListAddData.analData[1].toString() + "%", style: TextStyle(color: fcolor[0]),),
          //           SizedBox(
          //               width: 80,
          //               child: Center(
          //                   child: Text("승률",
          //                       style: TextStyle(color: Colors.white)))),
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           SizedBox(
          //             child: OutlinedButton(
          //               onPressed: () async {
          //
          //                 await showDialog(
          //                   context: context,
          //                   barrierDismissible: false,
          //                   builder: (context) {
          //                     return SeedDialog(ListAddData.analData);
          //                   },
          //                 );
          //
          //
          //                 setState(() {
          //                   ListAddData.analData;
          //                 });
          //
          //
          //               },
          //               child: Text(ListAddData.analData[2].toString(), style: TextStyle(fontWeight: FontWeight.normal),),
          //               style: OutlinedButton.styleFrom(
          //                 backgroundColor: Colors.transparent,
          //                 foregroundColor: Colors.black,
          //                 padding: EdgeInsets.zero,
          //               ),
          //             ),
          //             height: 20,
          //           ),
          //           SizedBox(
          //               width: 100,
          //               child: Center(
          //                   child: Text("시드 머니",
          //                       style: TextStyle(
          //                           color: Colors.white)))),
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Text(ListAddData.analData[3].toString()),
          //           SizedBox(
          //               width: 85,
          //               child: Center(
          //                   child: Text("총수익",
          //                       style: TextStyle(color: Colors.white)))),
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Text(ListAddData.analData[4].toString() + "%", style: TextStyle(color: fcolor[1])),
          //           SizedBox(
          //               width: 70,
          //               child: Center(
          //                   child: Text("수익률",
          //                       style: TextStyle(color: Colors.white)))),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          //------------------------^ 통계
        ],
      ),
    );
  }

  Future _future() async {// 딜레이 시킨다.

    return _memoizer.runOnce(() async {
      await lad.dataLoad();
      print("로딩");
      return '완료';
    });

  }

  Future _future2() async {// 딜레이 시킨다.

    return _memoizer.runOnce(() async {
      await lad.analCal();
      print("로딩");
      return '완료';
    });

  }
}
