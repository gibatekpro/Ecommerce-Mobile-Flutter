import 'package:ecommerce_flutter/cart/repo/cart_repo.dart';
import 'package:ecommerce_flutter/checkout/model/country.dart';
import 'package:ecommerce_flutter/checkout/model/order_item.dart';
import 'package:ecommerce_flutter/checkout/model/purchase.dart';
import 'package:ecommerce_flutter/checkout/model/state.dart' as p;
import 'package:ecommerce_flutter/checkout/service/checkout_service.dart';
import 'package:ecommerce_flutter/checkout/util/country_validator.dart';
import 'package:ecommerce_flutter/checkout/util/state_validator.dart';
import 'package:ecommerce_flutter/checkout/util/whitespace_validator.dart';
import 'package:ecommerce_flutter/checkout/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cart/database/cart_database.dart';
import '../../util/util.dart';
import '../model/address.dart';
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

  late FormGroup form;

  late Order order;

  @override
  void initState() {
    form = _checkoutForm();
    shippingFutureCountry = CountryStateService.fetchCountries();
    billingFutureCountry = CountryStateService.fetchCountries();
    shippingFutureState = null;
    billingFutureState = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
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
                              formControlName: 'customer.firstName',
                              decoration: const InputDecoration(
                                labelText: 'First Name',
                              ),
                              textCapitalization: TextCapitalization.none,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  backgroundColor: Colors.white),
                            ),
                            ReactiveTextField(
                              formControlName: 'customer.lastName',
                              decoration: const InputDecoration(
                                labelText: 'Last Name',
                              ),
                              textCapitalization: TextCapitalization.none,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  backgroundColor: Colors.white),
                            ),
                            ReactiveTextField(
                              formControlName: 'customer.email',
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
                const SizedBox(
                  height: 20,
                ),
                Column(
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
                              formControlName: 'shippingAddress.street',
                              decoration: const InputDecoration(
                                labelText: 'Street',
                              ),
                              textCapitalization: TextCapitalization.none,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  backgroundColor: Colors.white),
                            ),
                            ReactiveTextField(
                              formControlName: 'shippingAddress.city',
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
                                    formControlName: 'shippingAddress.country',
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
                                    formControlName: 'shippingAddress.state',
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
                              formControlName: 'shippingAddress.zipCode',
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
                    : Column(
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
                                    formControlName: 'billingAddress.street',
                                    decoration: const InputDecoration(
                                      labelText: 'Street',
                                    ),
                                    textCapitalization: TextCapitalization.none,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        backgroundColor: Colors.white),
                                  ),
                                  ReactiveTextField(
                                    formControlName: 'billingAddress.city',
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
                                          formControlName:
                                              'billingAddress.country',
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
                                          formControlName:
                                              'billingAddress.state',
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
                                    formControlName: 'billingAddress.zipCode',
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
      ),
    );
  }

  _onPressed(BuildContext context) {
    form.markAllAsTouched();
    Util.logOutput('Hello  Here ==>>>>> ${form.value.toString()}');

    if (form.valid) {
      Util.logOutput('Hello  Here ==>>>>> ${form.value.toString()}');

      _placeOrder(context);
    }
  }

  FormGroup _checkoutForm() {
    //If billing is the same as Shipping, we don't need a billing address
    //else, we do
    return _isChecked
        ? fb.group({
            'customer': _customerForm(),
            'shippingAddress': _shippingAddress(),
            // 'billingAddress': _billingAddress(),
            // 'creditCard': _creditCard()
          })
        : fb.group({
            'customer': _customerForm(),
            'shippingAddress': _shippingAddress(),
            'billingAddress': _billingAddress(),
            // 'creditCard': _creditCard()
          });
  }

  FormGroup _creditCard() {
    const americanExpressCardPattern = r'^3[47][0-9]{13}$';
    return FormGroup({
      'cardNumber': FormControl<String>(
        validators: [Validators.pattern(americanExpressCardPattern)],
      ),
      'month': FormControl<String>(
        validators: [
          Validators.number,
          Validators.minLength(2),
          Validators.maxLength(2)
        ],
      ),
      'year': FormControl<String>(
        validators: [
          Validators.number,
          Validators.minLength(2),
          Validators.maxLength(2)
        ],
      ),
      'securityCode': FormControl<String>(
        validators: [
          Validators.number,
          Validators.minLength(3),
          Validators.maxLength(3)
        ],
      ),
    });
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

  Widget _personalInfo() {
    return Column(
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
                  formControlName: 'customer.firstName',
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
                ),
                ReactiveTextField(
                  formControlName: 'customer.lastName',
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
                ),
                ReactiveTextField(
                  formControlName: 'customer.email',
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
      'zipCode': FormControl<String>(value: '555', validators: [
        Validators.required,
        Validators.minLength(2),
        const WhiteSpaceValidator()
      ]),
    });
  }

  Widget _shippingInfo() {
    return Column(
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
                  formControlName: 'shippingAddress.street',
                  decoration: const InputDecoration(
                    labelText: 'Street',
                  ),
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
                ),
                ReactiveTextField(
                  formControlName: 'shippingAddress.city',
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
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
                        formControlName: 'shippingAddress.country',
                        hint: const Text('Select country...'),
                        items: countries.map((country) {
                          return DropdownMenuItem(
                            value: country,
                            child: Text(country.name),
                          );
                        }).toList(),
                        onChanged: (formControl) {
                          setState(() {
                            String countryCode = formControl.value!.code;

                            shippingFutureState =
                                CountryStateService.fetchStates(countryCode);
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
                        formControlName: 'shippingAddress.state',
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
                  formControlName: 'shippingAddress.zipCode',
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                  ),
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
      'zipCode': FormControl<String>(value: '555', validators: [
        Validators.required,
        Validators.minLength(2),
        const WhiteSpaceValidator()
      ]),
    });
  }

  Widget _billingInfo() {
    return Column(
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
                  formControlName: 'billingAddress.street',
                  decoration: const InputDecoration(
                    labelText: 'Street',
                  ),
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
                ),
                ReactiveTextField(
                  formControlName: 'billingAddress.city',
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
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
                        formControlName: 'billingAddress.country',
                        hint: const Text('Select country...'),
                        items: countries.map((country) {
                          return DropdownMenuItem(
                            value: country,
                            child: Text(country.name),
                          );
                        }).toList(),
                        onChanged: (formControl) {
                          setState(() {
                            String countryCode = formControl.value!.code;

                            billingFutureState =
                                CountryStateService.fetchStates(countryCode);
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
                        formControlName: 'billingAddress.state',
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
                  formControlName: 'billingAddress.zipCode',
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                  ),
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _copyShipToBill(bool isChecked) {
    var shipControl = form.control('shippingAddress');
    var billControl = form.control('billingAddress');

    var shipCountry = form.control('shippingAddress.country');
    var billCountry = form.control('billingAddress.country');

    if (isChecked) {
      billControl.patchValue(shipControl.value);
      billCountry.patchValue(shipCountry.value);
    } else {
      billControl.reset();
    }
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
    var customerData = form.control('customer').value;
    Customer customer = Customer.fromJson(customerData);

    //Shipping Address
    var shippingAddressData = form.control('shippingAddress').value;
    Address shippingAddress = Address.fromJson(shippingAddressData);

    //Billing Address
    //Check if billing and shipping are the same
    var billingAddressData = _isChecked
        ? form.control('shippingAddress').value
        : form.control('billingAddress').value;
    Address billingAddress = Address.fromJson(billingAddressData);

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

    var response = await CheckoutService.placeOrder(purchase);

    Util.logOutput(response);
  }
}
