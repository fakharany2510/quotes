import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quotes/core/utils/app_text_style.dart';
class Constance{
  static void showErrorDialog({
    required BuildContext context ,
    required String errorMessage,
}){
     showDialog(context: context, builder: ((context) {
      return CupertinoAlertDialog(
        title: Text(errorMessage,style:secondaryTextStyle()),
        actions: [
          TextButton(onPressed: (){}, child: Text('Ok',
          style: secondaryTextStyle(),
          ),),
        ],
      );
    }));
}


///write toasts here
}