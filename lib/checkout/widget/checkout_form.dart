import 'package:ecommerce_flutter/cart/repo/cart_repo.dart';
import 'package:ecommerce_flutter/checkout/model/country.dart';
import 'package:ecommerce_flutter/checkout/model/order_item.dart';
import 'package:ecommerce_flutter/checkout/model/payment_info.dart';
import 'package:ecommerce_flutter/checkout/model/purchase.dart';
import 'package:ecommerce_flutter/checkout/model/state.dart' as p;
import 'package:ecommerce_flutter/checkout/service/checkout_service.dart';
import 'package:ecommerce_flutter/checkout/util/country_validator.dart';
import 'package:ecommerce_flutter/checkout/util/state_validator.dart';
import 'package:ecommerce_flutter/checkout/util/whitespace_validator.dart';
import 'package:ecommerce_flutter/checkout/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cart/database/cart_database.dart';
import '../../util/util.dart';
import '../model/address.dart' as p;
import '../model/customer.dart';
import '../model/order.dart';
import '../service/country_state_service.dart';

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({Key? key}) : super(key: key);

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  bool _isChecked = false;
  late Future<List<Country>> shippingFutureCountry;

  late Future<List<Country>> billingFutureCountry;

  late Future<List<p.State>>? shippingFutureState;

  late Future<List<p.State>>? billingFutureState;

  late FormGroup customerForm;

  late FormGroup shipForm;

  late FormGroup billForm;

  late Order order;

  @override
  void initState() {
    customerForm = _customerForm();
    shipForm = _shippingAddress();
    billForm = _billingAddress();
    shippingFutureCountry = CountryStateService.fetchCountries();
    billingFutureCountry = CountryStateService.fetchCountries();
    shippingFutureState = null;
    billingFutureState = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ReactiveForm(
                formGroup: customerForm,
                child: Column(
                  children: [
                    const Text('Personal Info: '),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ReactiveTextField(
                              formControlName: 'firstName',
                              decoration: const InputDecoration(
                                labelText: 'First Name',
                              ),
                              textCapitalization: TextCapitalization.none,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  backgroundColor: Colors.white),
                            ),
                            ReactiveTextField(
                              formControlName: 'lastName',
                              decoration: const InputDecoration(
                                labelText: 'Last Name',
                              ),
                              textCapitalization: TextCapitalization.none,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  backgroundColor: Colors.white),
                            ),
                            ReactiveTextField(
                              formControlName: 'email',
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                              textCapitalization: TextCapitalization.none,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  backgroundColor: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ReactiveForm(
                formGroup: shipForm,
                child: Column(
                  children: [
                    const Text('Shipping Address: '),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ReactiveTextField(
                              formControlName: 'street',
                              decoration: const InputDecoration(
                                labelText: 'Street',
                              ),
                              textCapitalization: TextCapitalization.none,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  backgroundColor: Colors.white),
                            ),
                            ReactiveTextField(
                              formControlName: 'city',
                              decoration: const InputDecoration(
                                labelText: 'City',
                              ),
                              textCapitalization: TextCapitalization.none,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  backgroundColor: Colors.white),
                            ),
                            FutureBuilder<List<Country>>(
                                future: shippingFutureCountry,
                                builder: (context, snapshot) {
                                  List<Country> countries = [];
                                  if (snapshot.hasData) {
                                    // Convert the data to a list of product categories
                                    countries = snapshot.data!;
                                  }
                                  return ReactiveDropdownField<Country>(
                                    formControlName: 'country',
                                    hint: const Text('Select country...'),
                                    items: countries.map((country) {
                                      return DropdownMenuItem(
                                        value: country,
                                        child: Text(country.name),
                                      );
                                    }).toList(),
                                    onChanged: (formControl) {
                                      setState(() {
                                        String countryCode =
                                            formControl.value!.code;

                                        shippingFutureState =
                                            CountryStateService.fetchStates(
                                                countryCode);
                                      });
                                    },
                                  );
                                }),
                            FutureBuilder<List<p.State>>(
                                future: shippingFutureState,
                                builder: (context, snapshot) {
                                  List<p.State> states = [];
                                  if (snapshot.hasData) {
                                    states = snapshot.data!;
                                  }
                                  return ReactiveDropdownField<p.State>(
                                    formControlName: 'state',
                                    hint: const Text('Select state...'),
                                    items: states.map((state) {
                                      return DropdownMenuItem(
                                        value: state,
                                        child: Text(state.name),
                                      );
                                    }).toList(),
                                  );
                                }),
                            ReactiveTextField(
                              formControlName: 'zipCode',
                              decoration: const InputDecoration(
                                labelText: 'Zip Code',
                              ),
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.none,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  backgroundColor: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isChecked = !_isChecked;
                        // _copyShipToBill(_isChecked);
                      });
                    },
                  ),
                  const Text('Shipping and Billing Address are the same')
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _isChecked
                  ? const SizedBox(
                      height: 10,
                    )
                  : ReactiveForm(
                      formGroup: billForm,
                      child: Column(
                        children: [
                          const Text('Billing Address: '),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  ReactiveTextField(
                                    formControlName: 'street',
                                    decoration: const InputDecoration(
                                      labelText: 'Street',
                                    ),
                                    textCapitalization: TextCapitalization.none,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        backgroundColor: Colors.white),
                                  ),
                                  ReactiveTextField(
                                    formControlName: 'city',
                                    decoration: const InputDecoration(
                                      labelText: 'City',
                                    ),
                                    textCapitalization: TextCapitalization.none,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        backgroundColor: Colors.white),
                                  ),
                                  FutureBuilder<List<Country>>(
                                      future: billingFutureCountry,
                                      builder: (context, snapshot) {
                                        List<Country> countries = [];
                                        if (snapshot.hasData) {
                                          // Convert the data to a list of product categories
                                          countries = snapshot.data!;
                                        }
                                        return ReactiveDropdownField<Country>(
                                          formControlName: 'country',
                                          hint: const Text('Select country...'),
                                          items: countries.map((country) {
                                            return DropdownMenuItem(
                                              value: country,
                                              child: Text(country.name),
                                            );
                                          }).toList(),
                                          onChanged: (formControl) {
                                            setState(() {
                                              String countryCode =
                                                  formControl.value!.code;

                                              billingFutureState =
                                                  CountryStateService
                                                      .fetchStates(countryCode);
                                            });
                                          },
                                        );
                                      }),
                                  FutureBuilder<List<p.State>>(
                                      future: billingFutureState,
                                      builder: (context, snapshot) {
                                        List<p.State> states = [];
                                        if (snapshot.hasData) {
                                          states = snapshot.data!;
                                        }
                                        return ReactiveDropdownField<p.State>(
                                          formControlName: 'state',
                                          hint: const Text('Select state...'),
                                          items: states.map((state) {
                                            return DropdownMenuItem(
                                              value: state,
                                              child: Text(state.name),
                                            );
                                          }).toList(),
                                        );
                                      }),
                                  ReactiveTextField(
                                    formControlName: 'zipCode',
                                    decoration: const InputDecoration(
                                      labelText: 'Zip Code',
                                    ),
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization.none,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        backgroundColor: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _onPressed(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  _onPressed(BuildContext context) async {
    customerForm.markAllAsTouched();
    shipForm.markAllAsTouched();
    billForm.markAllAsTouched();

    if (_isChecked) {
      if (customerForm.valid && shipForm.valid) {
        Util.logOutput('Hello  Here ==>>>>> 2 Valid');

        _placeOrder(context);
      }
    } else {
      if (customerForm.valid && shipForm.valid && billForm.valid) {
        Util.logOutput('Hello  Here ==>>>>> 3 Valid');

        // initPaymentSheet();

        _placeOrder(context);
      }
    }
  }

  FormGroup _customerForm() {
    const emailPattern = '^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}\$';
    return fb.group({
      'firstName': [
        'Anthony',
        Validators.required,
        Validators.minLength(2),
        const WhiteSpaceValidator()
      ],
      'lastName': [
        'Gibah',
        Validators.required,
        Validators.minLength(2),
        const WhiteSpaceValidator()
      ],
      'email': [
        'gibatekpro@gmail.com',
        Validators.required,
        const WhiteSpaceValidator(),
        Validators.pattern(emailPattern)
      ],
    });
  }

  FormGroup _shippingAddress() {
    return FormGroup({
      'street': FormControl<String>(value: 'No. 5', validators: [
        Validators.required,
        Validators.minLength(2),
        const WhiteSpaceValidator()
      ]),
      'city': FormControl<String>(value: 'London', validators: [
        Validators.required,
        Validators.minLength(2),
        const WhiteSpaceValidator()
      ]),
      'country': FormControl<Country>(validators: [
        Validators.required,
        const CountryValidator(),
        const WhiteSpaceValidator()
      ]),
      'state': FormControl<p.State>(validators: [
        Validators.required,
        const StateValidator(),
        const WhiteSpaceValidator()
      ]),
      'zipCode': FormControl<String>(value: '55555', validators: [
        Validators.required,
        Validators.minLength(5),
        const WhiteSpaceValidator()
      ]),
    });
  }

  FormGroup _billingAddress() {
    return FormGroup({
      'street': FormControl<String>(value: 'No. 5', validators: [
        Validators.required,
        Validators.minLength(2),
        const WhiteSpaceValidator()
      ]),
      'city': FormControl<String>(value: 'London', validators: [
        Validators.required,
        Validators.minLength(2),
        const WhiteSpaceValidator()
      ]),
      'country': FormControl<Country>(validators: [
        Validators.required,
        const CountryValidator(),
        const WhiteSpaceValidator()
      ]),
      'state': FormControl<p.State>(validators: [
        Validators.required,
        const StateValidator(),
        const WhiteSpaceValidator()
      ]),
      'zipCode': FormControl<String>(value: '55555', validators: [
        Validators.required,
        Validators.minLength(5),
        const WhiteSpaceValidator()
      ]),
    });
  }

  void _placeOrder(BuildContext context) async {
    //The purchase contains the following
    /*
    * Customer customer;

      Address shippingAddress;

      Address billingAddress;

      Order order;

      List<OrderItem> orderItems;
    * */

    // get cart items from database
    CartRepo? cartRepo;
    cartRepo = Provider.of(context, listen: false);
    List<CartItem> cartItems = cartRepo!.cartItems;

    //get cart total quantity and total price and
    //use it to create an order

    int totalQuantity = cartRepo.totalQuantity;
    double totalPrice = cartRepo.totalPrice;

    //Customer
    var customerData = customerForm.value;
    Customer customer = Customer.fromJson(customerData);

    //Shipping Address
    var shippingAddressData = shipForm.value;
    p.Address shippingAddress = p.Address.fromJson(shippingAddressData);

    //Billing Address
    //Check if billing and shipping are the same
    var billingAddressData = _isChecked ? shipForm.value : billForm.value;
    p.Address billingAddress = p.Address.fromJson(billingAddressData);

    //set the order
    Order order = Order(totalQuantity: totalQuantity, totalPrice: totalPrice);

    //Order Items
    List<OrderItem> orderItems = [];
    for (var cartItem in cartItems) {
      orderItems.add(OrderItem(
          imageUrl: cartItem.imageUrl,
          unitPrice: cartItem.unitPrice,
          quantity: cartItem.quantity,
          productId: cartItem.id));
    }

    //Then, set up purchase
    Purchase purchase = Purchase(
        customer: customer,
        shippingAddress: shippingAddress,
        billingAddress: billingAddress,
        order: order,
        orderItems: orderItems);

    PaymentInfo paymentInfo = PaymentInfo(
        amount: (order.totalPrice * 100).round(),
        currency: 'USD',
        description: "Ecommerce Shop",
        receiptEmail: purchase.customer.email);

    initPaymentSheet(paymentInfo, purchase);
  }

  Future<void> initPaymentSheet(
      PaymentInfo paymentInfo, Purchase purchase) async {
    try {
      // 1. create payment intent on the server
      final data = await CheckoutService.createTestPaymentSheet(paymentInfo);

      // create some billingDetails
      final billingDetails = BillingDetails(
        name: '${purchase.customer.firstName} ${purchase.customer.lastName}',
        email: paymentInfo.receiptEmail,
        address: Address(
          city: purchase.billingAddress.city,
          country: purchase.billingAddress.country,
          line1: purchase.billingAddress.street,
          line2: '',
          state: purchase.billingAddress.state,
          postalCode: purchase.billingAddress.zipCode,
        ),
      ); // mocked data for tests

      // create some billingDetails
      final shippingDetails = ShippingDetails(
        name: '${purchase.customer.firstName} ${purchase.customer.lastName}',
        address: Address(
          city: purchase.shippingAddress.city,
          country: purchase.shippingAddress.country,
          line1: purchase.shippingAddress.street,
          line2: '',
          state: purchase.shippingAddress.state,
          postalCode: purchase.shippingAddress.zipCode,
        ),
      ); // mocked data for tests

      // 2. initialize the payment sheet
      try {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            // Main params
            merchantDisplayName: 'Ecommerce Flutter',
            paymentIntentClientSecret: data['client_secret'],
            // Extra options
            style: ThemeMode.light,
            billingDetails: billingDetails,
          ),
        );
      } catch (e) {
        Util.logOutput('===>>> $e');
      }
      setState(() {
        displayPaymentSheet(purchase);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  void displayPaymentSheet(Purchase purchase) async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      var response =
          await CheckoutService.placeOrder(purchase).then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("Successful!!\n Order Tracking Number: $value"),
                  ),
                )
              });
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: $e'),
          ),
        );
      }
    }
  }
}
