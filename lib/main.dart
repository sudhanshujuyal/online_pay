import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'home_page.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey='pk_test_51Jp7vCSHerxWeLWjBFukHYfvlXfmAPu0oKiohk17CUICu7psaY907NLoy48Aby9Ju2MNP5aTOh4aF257yzv6LTCb00YfEq6vQQ';
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
