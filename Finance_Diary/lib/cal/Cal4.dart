import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cal4 extends StatefulWidget {
  const Cal4({super.key});

  @override
  State<Cal4> createState() => _Cal4State();
}

class _Cal4State extends State<Cal4> {
  var textField1 = TextEditingController();
  var textField2 = TextEditingController();

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
                  child: Text("고가", style: TextStyle(fontSize: 18.sp),),
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
                  child: Text("저가", style: TextStyle(fontSize: 18.sp),),
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
                        child: Text("0", style: TextStyle(fontSize: 18.sp),),
                        width: 60.w,
                      ),

                      Flexible(child: Text(result[0].toString(), style: TextStyle(fontSize: 18.sp), )),
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
                        child: Text("0.236", style: TextStyle(fontSize: 18.sp),),
                        width: 60.w,
                      ),

                      Flexible(child: Text(result[1].toString(), style: TextStyle(fontSize: 18.sp), )),
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
                        child: Text("0.382", style: TextStyle(fontSize: 18.sp),),
                        width: 60.w,
                      ),

                      Flexible(child: Text(result[2].toString(), style: TextStyle(fontSize: 18.sp), )),
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
                        child: Text("0.5", style: TextStyle(fontSize: 18.sp),),
                        width: 60.w,
                      ),

                      Flexible(child: Text(result[3].toString(), style: TextStyle(fontSize: 18.sp), )),
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
                        child: Text("0.618", style: TextStyle(fontSize: 18.sp),),
                        width: 60.w,
                      ),

                      Flexible(child: Text(result[4].toString(), style: TextStyle(fontSize: 18.sp), )),
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
                        child: Text("0.786", style: TextStyle(fontSize: 18.sp),),
                        width: 60.w,
                      ),

                      Flexible(child: Text(result[5].toString(), style: TextStyle(fontSize: 18.sp), )),
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
                        child: Text("1", style: TextStyle(fontSize: 18.sp),),
                        width: 60.w,
                      ),

                      Flexible(child: Text(result[6].toString(), style: TextStyle(fontSize: 18.sp), )),
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
                        child: Text("1.618", style: TextStyle(fontSize: 18.sp),),
                        width: 60.w,
                      ),

                      Flexible(child: Text(result[7].toString(), style: TextStyle(fontSize: 18.sp), )),
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
      var top = double.parse(textField1.text);
      var bottom = double.parse(textField2.text);
      var dif = top - bottom;
      
      result[0] = bottom.toStringAsFixed(1);
      result[1] = (bottom + dif * 0.236).toStringAsFixed(1);
      result[2] = (bottom + dif * 0.382).toStringAsFixed(1);
      result[3] = (bottom + dif * 0.5).toStringAsFixed(1);
      result[4] = (bottom + dif * 0.618).toStringAsFixed(1);
      result[5] = (bottom + dif * 0.764).toStringAsFixed(1);
      result[6] = (bottom + dif * 1).toStringAsFixed(1);
      result[7] = (bottom + dif * 1.618).toStringAsFixed(1);

    } catch(E) {

    }

  }
}
