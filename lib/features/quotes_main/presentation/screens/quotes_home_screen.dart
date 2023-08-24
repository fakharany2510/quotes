import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/core/utils/app_size.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/utils/app_text_style.dart';
import 'package:quotes/core/utils/extensions.dart';
import 'package:quotes/features/posts/presentation/screens/posts_screen.dart';
import 'package:quotes/features/quotes_main/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/features/splash/presentation/cubit/localizationcubit_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/quotes_content_widget.dart';
import 'package:quotes/injection_container.dart' as di;

class QuotesHomeScreen extends StatelessWidget {
  const QuotesHomeScreen({Key? key}) : super(key: key);

  // _getRandomQuote()=>BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => RandomQuoteCubit(getRandomQuotesUseCase:di.sl())..getRandomQuote(),
  child: BlocConsumer<RandomQuoteCubit , RandomQuoteState>(
    builder: (context, state) {
        if(state is RandomQuoteLoading){
          return const Scaffold(
            backgroundColor: Colors.white,
            body:  Center(
                child: CircularProgressIndicator()
            ),
          );
        }else if(state is RandomQuoteLoaded){
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  AppStrings.appName.tr(context)!,style: boldTextStyle(fontSize: 20,color: AppColors.mainColor),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: (){
                    if(AppLocalizations.of(context)!.isEnLocale){
                      LocalizationCubit.get(context).changeLanguageToArabic();
                    }else{
                      LocalizationCubit.get(context).changeLanguageToEnglish();

                    }
                  },
                  icon: const Icon(Icons.abc_outlined,color: AppColors.mainColor,size: 20),
                ),
              ),
              body:Padding(
                padding: getPadding(top: getSize(20),right: getSize(16),left: getSize(16),bottom: getSize(20)),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                        physics:const  NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return QuotesContentWidget(index: index,quote:state.quotes,);
                          },
                          separatorBuilder:(context, index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                          itemCount: state.quotes.length),
                      SizedBox(height: getVerticalSize(50),),
InkWell(
    onTap: (){
     // _getRandomQuote();
      RandomQuoteCubit.get(context).getRandomQuote();
    },
    child: Container(
      width: getHorizontalSize(50),
      height: getVerticalSize(50),
      decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(50)
      ),
      child: Icon(Icons.refresh,size: 40,color: Colors.white),
    ),
),
InkWell(
    onTap: (){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>PostsScreen()));
    },
    child: Container(
      width: getHorizontalSize(50),
      height: getVerticalSize(50),
      decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(50)
      ),
      child: Icon(Icons.games_outlined,size: 40,color: Colors.white),
    ),
),

                    ],
                  ),
                ),
              )
          );
        }else if(state is RandomQuoteError){
          return const Center(child: Text('error'));
        }else{
          return  Center(
              child:Column(
                children: [
                  CircularProgressIndicator(color: Colors.red),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PostsScreen()));
                    },
                    child: Container(
                      width: getHorizontalSize(50),
                      height: getVerticalSize(50),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Icon(Icons.games_outlined,size: 40,color: Colors.green),
                    ),
                  ),

                ],
              )
          );
        }
      },
  listener: (context, state) {

  },

  ),
);
  }
}
