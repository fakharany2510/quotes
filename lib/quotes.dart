import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/locale/app_localizations_setup.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/features/splash/presentation/cubit/localizationcubit_cubit.dart';
import 'package:quotes/features/splash/presentation/cubit/localizationcubit_state.dart';
import 'config/themes/app_theme.dart';
import 'injection_container.dart' as di;


class Quotes extends StatelessWidget {
  const Quotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(providers: [
      BlocProvider(create:(context)=>
          LocalizationCubit(
              changeLanguageUseCase: di.sl(),
              getSavedLanguageUseCase: di.sl())
            ..getSavedLanguage())
    ],
        child: BlocBuilder<LocalizationCubit , LocalizationState>(
          buildWhen: (currentState , nextState){
            return currentState != nextState;
          },
          builder: (context, state) {
            return MaterialApp(
              title: AppStrings.appName,
              debugShowCheckedModeBanner: false,
              locale: state.locale,
              theme: AppTheme(),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback:
              AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates:
              AppLocalizationsSetup.localizationsDelegates,
            );
          },
        )
    );
  }
  }

