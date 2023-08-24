import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quotes/quotes.dart';

import 'bloc_observer.dart';
import 'injection_container.dart' as di;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned((){
    runApp(const Quotes());
  },
    blocObserver: MyBlocObserver(),
  );
}

