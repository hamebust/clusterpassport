// OtpPage: Página de verificación OTP en la carpeta lib/features/user/presentation/pages
// OtpPage: OTP verification page in the lib/features/user/presentation/pages folder

// Todos los notas son en español e inglés
// All notes are in spanish and english

// Sección de paquetes
// Package section
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      S.of(context).Verify_your_OTP,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: tabColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    S.of(context).Enter_your_OTP,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 30),
                  _pinCodeWidget(),
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pinCodeWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Column(
      children: <Widget>[
        PinCodeFields(
          controller: _otpController,
          length: 6,
          activeBorderColor: tabColor,
          keyboardType: TextInputType.number, // Esto muestra el teclado numérico
          onComplete: (String pinCode) {},
        ),
        Text(S.of(context).Enter_your_6_digit_code)
      ],
    ),
  );
}


  void _submitSmsCode() {
    final otpCode = _otpController.text;
    print("otpCode $otpCode");
    if (otpCode.isNotEmpty) {
      BlocProvider.of<CredentialCubit>(context).submitSmsCode(smsCode: otpCode);
    }
  }
}