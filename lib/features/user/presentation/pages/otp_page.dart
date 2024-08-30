// OtpPage: Página de verificación OTP en la carpeta lib/features/user/presentation/pages
// OtpPage: OTP verification page in the lib/features/user/presentation/pages folder

import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      S.of(context).Verify_your_OTP,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tabColor),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    S.of(context).Enter_your_OTP,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 30),
                  _buildPinCodeWidget(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            GestureDetector(
              onTap: _submitSmsCode,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: tabColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    S.of(context).Next,
                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinCodeWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          PinCodeFields(
            controller: _otpController,
            length: 6,
            activeBorderColor: tabColor,
            onComplete: (String pinCode) {},
          ),
          Text(S.of(context).Enter_your_6_digit_code),
        ],
      ),
    );
  }

  void _submitSmsCode() {
    if (_otpController.text.isNotEmpty) {
      BlocProvider.of<CredentialCubit>(context).submitSmsCode(smsCode: _otpController.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).Enter_your_OTP)),
      );
    }
  }
}
