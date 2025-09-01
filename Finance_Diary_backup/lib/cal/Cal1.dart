import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cal1 extends StatefulWidget {
  const Cal1({super.key});

  @override
  State<Cal1> createState() => _Cal1State();
}

class _Cal1State extends State<Cal1> {
  var textField1 = TextEditingController();
  var textField2 = TextEditingController(text: "1");
  var textField3 = TextEditingController();
  var result = 0.0;
  var resultPer = 0.0;
  var resultPerS = "0.0";

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
                  child: Text("매수가", style: TextStyle(fontSize: 18.sp),),
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
                  child: Text("수량", style: TextStyle(fontSize: 18.sp),),
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


          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Text("매도가", style: TextStyle(fontSize: 18.sp),),
                  width: 100.w,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: textField3,
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
                  child: Text("수익률", style: TextStyle(fontSize: 18.sp),),
                  width: 100.w,
                ),
                Text(result.toString() + "(" + resultPerS.toString() + "%)", style: TextStyle(fontSize: 18.sp), )
              ],
            ),
          ),

        ],
      ),
    );
  }

  calculate() {
    var profit = 0.0;
    var profitPer = 0.0;

    try {
      profit = double.parse(textField3.text) - double.parse(textField1.text);
      profitPer = profit / double.parse(textField1.text) * 100;

      result = profit * double.parse(textField2.text);
      resultPer = profitPer * double.parse(textField2.text);
      resultPerS = resultPer.toStringAsFixed(2);


    } catch(E) {

    }

  }
}
