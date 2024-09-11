
import 'package:reactive_forms/reactive_forms.dart';
import '../model/state.dart' as p;

class StateValidator extends Validator<dynamic> {
  const StateValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    if (control.isNotNull && control.value is p.State) {
      return null; // Value is an instance of Country, so it's valid
    } else {
      return {'notOnlyState': true}; // Value is not an instance of Country
    }
  }
}