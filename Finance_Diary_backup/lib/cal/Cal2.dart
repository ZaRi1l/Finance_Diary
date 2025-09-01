import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cal2 extends StatefulWidget {
  const Cal2({super.key});

  @override
  State<Cal2> createState() => _Cal2State();
}

class _Cal2State extends State<Cal2> {
  var textField1 = TextEditingController();
  var textField2 = TextEditingController(text: "2");

  var result = ["0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0"];


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black38))),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Text("자본금", style: TextStyle(fontSize: 18.sp),),
                  width: 100.w,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: textField1,
                    style: TextStyle(fontSize: 18.sp),

                    onChanged: (value) {
                      setState(() {
                        calculate();
                      });
                    },
                  ),
                )
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Text("배율", style: TextStyle(fontSize: 18.sp),),
                  width: 100.w,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: textField2,
                    style: TextStyle(fontSize: 18.sp),

                    onChanged: (value) {
                      setState(() {
                        calculate();
                      });
                    },
                  ),
                )
              ],
            ),
          ),


          Container(height: 50.h,
            child: Divider(color: Colors.black,),
            padding: EdgeInsets.only(right: 10, left: 10),
          ),


          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("1차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[9].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),

                SizedBox(height:30.h, child: VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,)),


                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("2차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[8].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),


              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("3차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[7].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),

                SizedBox(height:30.h, child: VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,)),


                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("4차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[6].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),


              ],
            ),
          ),


          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("5차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[5].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),

                SizedBox(height:30.h, child: VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,)),


                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("6차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[4].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),


              ],
            ),
          ),


          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("7차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[3].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),

                SizedBox(height:30.h, child: VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,)),


                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("8차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[2].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),


              ],
            ),
          ),


          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("9차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[1].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),

                SizedBox(height:30.h, child: VerticalDivider(width: 10.w, thickness: 2, color: Colors.black26,)),


                Container(
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("10차", style: TextStyle(fontSize: 18.sp),),
                        width: 45.w,
                      ),

                      Flexible(child: Text(result[0].toString(), style: TextStyle(fontSize: 18.sp), )),
                    ],
                  ),
                ),


              ],
            ),
          ),

        ],
      ),
    );
  }

  calculate() {
    try {
      var res = double.parse(textField1.text);

      for(var i = 0; i < result.length; i ++) {
        res = res / double.parse(textField2.text);
        result[i] = res.toStringAsFixed(2);
      }

      // (1 * 2 + a) / 2 = a
      // b2 + a = xa
      // 2b = (x-1)a
      // b = (x-1)/2*a

    } catch(E) {

    }

  }
}
