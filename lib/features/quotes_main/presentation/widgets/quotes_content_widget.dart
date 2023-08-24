import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../domain/entities/quotes_entity.dart';
class QuotesContentWidget extends StatelessWidget {
  final List<QuotesEntity> quote;
  final int index;
  const QuotesContentWidget({required this.quote ,required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(top: 20,left: 10,right: 10,bottom: 20),
      width:getHorizontalSize(343),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            quote[index].quote,
            textAlign: TextAlign.center,
            style: secondaryTextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: AppFonts.appFontFmily,
                letterSpacing: 1.4
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            'Author : ${quote[index].author}',
            textAlign: TextAlign.center,
            style: secondaryTextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: AppFonts.appFontFmily,
                letterSpacing: 1.4
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            'Category : ${quote[index].category}',
            textAlign: TextAlign.center,
            style: secondaryTextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: AppFonts.appFontFmily,
                letterSpacing: 1.4
            ),
          ),
        ],
      ),
    );
  }
}
