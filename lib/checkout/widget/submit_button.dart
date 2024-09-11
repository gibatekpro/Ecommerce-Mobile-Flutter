
import 'package:ecommerce_flutter/util/util.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return ElevatedButton(
      onPressed:() => form!.valid ? _onPressed(form) : Util.logOutput('Hello  ==>>>>>'),
      child: const Text('Submit'),
    );
  }

  _onPressed(AbstractControl<Object> form) {

    Util.logOutput('Hello  ==>>>>>${form.value.toString()}');
  }

}

