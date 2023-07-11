import 'package:flutter/material.dart';

import '../../utils/font/text_style.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: smallTitleTextStyle,
        ),
      ),
    );
  }
}
