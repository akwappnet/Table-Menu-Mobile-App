import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CreditCard(
        cardNumber: "5450 7879 4864 7854",
        cardExpiry: "10/25",
        cardHolderName: "Card Holder",
        cvv: "456",
        bankName: "Axis Bank",
        cardType: CardType.masterCard, // Optional if you want to override Card Type
        showBackSide: false,
        frontBackground: CardBackgrounds.black,
        backBackground: CardBackgrounds.white,
        showShadow: true,
        textExpDate: 'Exp. Date',
        textName: 'Name',
        textExpiry: 'MM/YY'
    );
  }
}
