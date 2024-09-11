import 'package:ecommerce_flutter/checkout/widget/checkout_form.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({Key? key}) : super(key: key);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (error) => 'Field must not be empty',
        ValidationMessage.email: (error) => 'Must enter a valid email',
        ValidationMessage.minLength: (error) =>
        'Must be at least ${(error as Map)['requiredLength']} characters long',
        'notOnlyState' : (error) => 'Must select a state',
        'notOnlyCountry' : (error) => 'Must select a country'
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: const SingleChildScrollView(
          child: CheckoutForm(),
        )
      ),
    );
  }
}
