import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  Map<String,dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stripe payment'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: ()async
            {
              await makePayment();
            },
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.green
              ),
              child: Text('Pay'),
            ),
          )
        ],
      ),
    );
  }

 Future<void> makePayment() async{
    try{
      paymentIntentData=await createPaymentIntet('20','USD');
      await Stripe.instance.initPaymentSheet(paymentSheetParameters:SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        applePay: true,
        googlePay: true,
        style: ThemeMode.dark,
        merchantCountryCode: 'US',
        merchantDisplayName: 'ASIF'

      ));
      displayPaymentSheet();
    }
    catch(e){print(e);}
 }
 createPaymentInter(String amount,String currency)
 {

 }

  createPaymentIntet(String s, String t) async
  {
    try{
      Map<String,dynamic> body={'amount':calculateAmount(s),
      'currency':t,
       'payment_method_types[]':'card'
      };
      var response=await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),body: body,
          headers:{
            'Authorization':'Bearer sk_test_51Jp7vCSHerxWeLWjTHDjSsjUK5BajcaU6wUtCcUuMP54xF0ZZNzaTptBaXLRkxhE6efEviwSn7fM10GJLVijXnRO00v4cRjFWS',
            'Content-Type':'application/x-www-form-urlencoded'
          });
      return json.decode(response.body.toString());

    }catch(e){

    }
  }
  calculateAmount(String amount)
  {
    final price=int.parse(amount)*100;
    return price.toString();
  }

  void displayPaymentSheet() async
  {
    try{
     await Stripe.instance.presentPaymentSheet(parameters: PresentPaymentSheetParameters(clientSecret: paymentIntentData!['client_secret'],confirmPayment: true));
      setState(() {
        paymentIntentData=null;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Paid Successfull')));
    }
    catch(e)
    {
      print(e.toString());
    }
  }
}
