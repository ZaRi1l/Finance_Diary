

import 'package:finance_diary/cal/Cal2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cal/Cal1.dart';
import '../cal/Cal3.dart';
import '../cal/Cal4.dart';

class Calcultor extends StatefulWidget {
  const Calcultor({super.key});

  @override
  State<Calcultor> createState() => _CalcultorState();
}

class _CalcultorState extends State<Calcultor> {
  var calSw1 = false;
  var icon1 = Icons.add;

  var calSw2 = false;
  var icon2 = Icons.add;

  var calSw3 = false;
  var icon3 = Icons.add;

  var calSw4 = false;
  var icon4 = Icons.add;


  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Calcultor", style: TextStyle(fontSize: 20.sp)),
        backgroundColor: Colors.green[300],
        shadowColor: Colors.transparent,
      ),

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [

            Column(
              children: [
                Container(
                  height: 70.h,
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (calSw1) {
                          calSw1 = false;
                          icon1 = Icons.add;
                        } else {
                          calSw1 = true;
                          icon1 = Icons.remove;
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("수익률 계산",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal
                          ),
                        ),

                        SizedBox(
                            width: 50.w,
                            child: Icon(icon1, size: 45.sp, color: Colors.green[400],)),

                      ],
                    ),
                  ),
                ),

                Builder(builder: (context) {
                  if (calSw1) {
                    return Cal1();
                  } else {
                    return Container();
                  }
                },),

              ],
            ),



            Column(
              children: [
                Container(
                  height: 70.h,
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12), )),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (calSw2) {
                          calSw2 = false;
                          icon2 = Icons.add;
                        } else {
                          calSw2 = true;
                          icon2 = Icons.remove;
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("마틴 계산",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal
                          ),
                        ),

                        SizedBox(
                            width: 50.sp,
                            child: Icon(icon2, size: 45.sp, color: Colors.green[400],)),

                      ],
                    ),
                  ),
                ),

                Builder(builder: (context) {
                  if (calSw2) {
                    return Cal2();
                  } else {
                    return Container();
                  }
                },),

              ],
            ),



            Column(
              children: [
                Container(
                  height: 70.h,
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12), )),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (calSw3) {
                          calSw3 = false;
                          icon3 = Icons.add;
                        } else {
                          calSw3 = true;
                          icon3 = Icons.remove;
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("피보나치 되돌림(상승추세)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal
                          ),
                        ),

                        SizedBox(
                            width: 50.w,
                            child: Icon(icon3, size: 45.sp, color: Colors.green[400],)),

                      ],
                    ),
                  ),
                ),

                Builder(builder: (context) {
                  if (calSw3) {
                    return Cal3();
                  } else {
                    return Container();
                  }
                },),

              ],
            ),




            Column(
              children: [
                Container(
                  height: 70.h,
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12), )),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (calSw4) {
                          calSw4 = false;
                          icon4 = Icons.add;
                        } else {
                          calSw4 = true;
                          icon4 = Icons.remove;
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("피보나치 되돌림(하락추세)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal
                          ),
                        ),

                        SizedBox(
                            width: 50.w,
                            child: Icon(icon4, size: 45.sp, color: Colors.green[400],)),

                      ],
                    ),
                  ),
                ),

                Builder(builder: (context) {
                  if (calSw4) {
                    return Cal4();
                  } else {
                    return Container();
                  }
                },),

              ],
            ),


          ],
        ),
      ),
    );
  }
}
