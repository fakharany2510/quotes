import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class LocalizationState extends Equatable{
final Locale locale;
const LocalizationState(this.locale);
@override
List<Object?> get props => [locale];
}

class ChangeLocalState extends LocalizationState {
  const ChangeLocalState(Locale selectedLocale) : super(selectedLocale);

}
