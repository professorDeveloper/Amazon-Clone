import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/common/widgets/custom_textfiled.dart';
import 'package:untitled1/constains/global_variables.dart';
import 'package:untitled1/features/search/screen/search_screen.dart';
import 'package:untitled1/providers/user_provider.dart';

import '../../../constains/utils.dart';
import '../service/address_service.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;

  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

final _addressFormKey = GlobalKey<FormState>();
List<PaymentItem> paymentItems = [];
String addressToBeUsed = "Namangan";
final AddressServices addressServices = AddressServices();

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  void navigateToSearchScreen(String qurey) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: qurey);
  }

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    addressController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressController.text);
    }
    addressServices.placeOrder(
      context: context,
      address: addressController.text,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void onGooglePayResult(String addressFromProvider) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressController.text);
    }else{
      bool isForm = flatBuildingController.text.isEmpty &&
          areaController.text.isEmpty &&
          pincodeController.text.isEmpty &&
          cityController.text.isEmpty &&
          addressController.text.isEmpty;

      if (!isForm) {
        if (_addressFormKey.currentState!.validate()) {
          addressController.text =
          '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
        } else {
          
        }
      } else if (addressFromProvider.isNotEmpty) {
        addressController.text = addressFromProvider;
      } else {
        showSnackBar(context, 'Bo`sh maydonlarni To`ldring ');
      }
    }
    addressServices.placeOrder(
      context: context,
      address: addressController.text,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void onPayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressController.text);
    }else{

    }
    addressServices.placeOrder(
      context: context,
      address: addressController.text,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    // addressToBeUsed = "";

   showSnackBar(context, "Bo`sh maydonlarni To`ldiring");
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextFiled(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextFiled(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextFiled(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextFiled(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                    CustomTextFiled(
                      controller: addressController,
                      hintText: 'Address',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              RaisedButton(
                onPressed :(){
                  onGooglePayResult(addressController.text);
                },
                textColor: Colors.white,
                color: GlobalVariables.secondaryColor,
                padding: const EdgeInsets.only(right: 100,left: 100,top: 20,bottom: 20),
                child: new Text(
                  " UzPay",
                ),
              ),
              const SizedBox(height: 10),
              GooglePayButton(
                onPressed: () => payPressed(address),
                paymentConfigurationAsset: 'gpay.json',
                // onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                height: 70,
                width: 250,
                style: GooglePayButtonStyle.white,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                onPaymentResult: (Map<String, dynamic> result) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
