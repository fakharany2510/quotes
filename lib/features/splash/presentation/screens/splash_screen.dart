import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/core/utils/app_assets.dart';
import 'package:quotes/core/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  _goNext()=>Navigator.pushReplacementNamed(context, Routes.posts);

_startDelay (){
  _timer=Timer(const Duration(milliseconds: 2000), () =>_goNext());

}
@override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.mainColor,
      body: Center(
        child: Image.asset(AppAssets.quote),
      ),
    );
  }
}
