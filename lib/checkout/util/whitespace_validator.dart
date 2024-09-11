
import 'package:reactive_forms/reactive_forms.dart';

class WhiteSpaceValidator extends Validator<dynamic> {
  const WhiteSpaceValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return control.isNotNull &&
        control.value.toString().trim().isNotEmpty
        ? null
        : {'notOnlyWhitespace': true};
  }
}