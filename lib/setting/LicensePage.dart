import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LicensePage2 extends StatefulWidget {
  var Lic;
  LicensePage2(this.Lic, {super.key});


  @override
  State<LicensePage2> createState() => _LicensePage2State(Lic);
}

class _LicensePage2State extends State<LicensePage2> {
  var Lic;

  _LicensePage2State(this.Lic);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("License", style: TextStyle(fontSize: 20.sp)),
        backgroundColor: Colors.green[300],
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(child: Text(Lic, style: TextStyle(fontSize: 13.sp)))
    );
  }
}