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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                    _buildHeaderText(context),
                    const SizedBox(height: 20),
                    _buildSubHeaderText(context),
                    const SizedBox(height: 30),
                  _buildPinCodeWidget(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).Verify_your_OTP,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: tabColor,
        ),
      ),
    );
  }

  Widget _buildSubHeaderText(BuildContext context) {
    return Text(
      S.of(context).Enter_your_OTP,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    );
  }

  Widget _buildPinCodeWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
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

  Widget _buildSubmitButton(BuildContext context) {
    return GestureDetector(
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _submitSmsCode() {
    if (_otpController.text.isNotEmpty) {
      try {
        BlocProvider.of<CredentialCubit>(context).submitSmsCode(smsCode: _otpController.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).Enter_your_OTP)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred')),
      );
    }
  }
}