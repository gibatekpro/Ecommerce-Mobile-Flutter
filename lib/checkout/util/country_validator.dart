
import 'package:reactive_forms/reactive_forms.dart';

import '../model/country.dart';

class CountryValidator extends Validator<dynamic> {
  const CountryValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    if (control.isNotNull && control.value is Country) {
      return null; // Value is an instance of Country, so it's valid
    } else {
      return {'notOnlyCountry': true}; // Value is not an instance of Country
    }
  }
}