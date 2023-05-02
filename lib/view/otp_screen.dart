import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_snack_bar.dart';
import '../view_model/auth_provider.dart';
import 'home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
              child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 200,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple.shade50,
                          ),
                          child: Image.asset(
                            "assets/images/enter_OTP.png",
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Verification",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Enter the OTP send to your phone number",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.purple.shade200,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: CustomButton(
                            child: Text("Verify", style: TextStyle(fontSize: 16),),
                            onPressed: () {
                              if (otpCode != null) {
                               // verifyOtp(context, otpCode!);
                              } else {
                                showsnackbar(context, "Enter 6-Digit code");
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
            ),
      ),
    );
  }

  // verify otp
  // void verifyOtp(BuildContext context, String userOtp) {
  //   final auth_provider = Provider.of<AuthProvider>(context, listen: false);
  //   auth_provider.verifyOtp(
  //     context: context,
  //     verificationId: widget.verificationId,
  //     userOtp: userOtp,
  //     onSuccess: () {
  //       // checking whether user exists in the db
  //       auth_provider.checkExistingUser().then(
  //         (value) async {
  //           if (value == true) {
  //             // user exists in our app
  //             auth_provider.getDataFromFirestore().then(
  //                   (value) => auth_provider.saveUserDataToSP().then(
  //                         (value) => auth_provider.setSignIn().then(
  //                               (value) => Navigator.pushAndRemoveUntil(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                     builder: (context) => const HomeScreen(),
  //                                   ),
  //                                   (route) => false),
  //                             ),
  //                       ),
  //                 );
  //           } else {
  //             // new user
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const UserInfromationScreen()),
  //                 (route) => false);
  //           }
  //         },
  //       );
  //     },
  //   );
  // }
}
