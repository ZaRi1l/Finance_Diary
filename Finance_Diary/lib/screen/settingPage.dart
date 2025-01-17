import 'package:finance_diary/data/diaryListData.dart';
import 'package:finance_diary/setting/Calculator.dart';
import 'package:finance_diary/setting/SaveDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../setting/LicensePage.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ListAddData lad = ListAddData();


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Additional features", style: TextStyle(fontSize: 20.sp),),
          backgroundColor: Colors.green[300],
          shadowColor: Colors.transparent,
        ),
      body: ListView( // 라이센스, 엑셀 추출, 계산기, 어둠 모드, 등등
        children: [

          Container(
            height: 70.h,
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
            child: TextButton(
              onPressed: () {
                showDialog(context: context,
                    builder: (context) => SaveDialog(),
                );
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 50.w,
                      child: Icon(Icons.save_outlined, size: 50.sp, color: Colors.green[400],)),
                  SizedBox(width: 10.w,),
                  Text("엑셀 파일 추출 (거래 데이터)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                      fontWeight: FontWeight.normal
                  ),
                  )

                ],
              ),
            ),
          ),



          Container(
            height: 70.h,
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
            child: TextButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Calcultor(),));

              },
              child: Row(
                children: [
                  SizedBox(
                      width: 50.w,
                      child: Icon(Icons.calculate_outlined, size: 50.sp, color: Colors.green[400],)
                  ),
                  SizedBox(width: 10.w,),
                  Text("계산기",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal
                    ),
                  )

                ],
              ),
            ),
          ),



          Container(
            height: 70.h,
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
            child: TextButton(
              onPressed: () async {
                var Lic = await rootBundle.loadString('assets/License.txt');

                Navigator.push(context, MaterialPageRoute(builder: (context) => LicensePage2(Lic),));
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 50.w,
                      child: SvgPicture.asset("svg/iconmonstr-copyright-2.svg", height: 40.h, width: 40.w, color: Colors.green[400],)),
                  SizedBox(width: 10.w,),
                  Text("License",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      fontWeight: FontWeight.normal
                    ),
                  )

                ],
              ),
            ),
          ),




        ],
      ),
    );
  }
}