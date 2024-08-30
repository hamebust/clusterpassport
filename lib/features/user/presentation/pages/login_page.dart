// LoginPage: Página de inicio de sesión en la carpeta lib/features/user/presentation/pages
// LoginPage: Login page in the lib/features/user/presentation/pages folder

//import 'package:cluster_passport/features/app/const/app_const.dart';
import 'package:cluster_passport/features/app/home/home_page.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:cluster_passport/features/user/presentation/pages/initial_profile_submit_page.dart';
import 'package:cluster_passport/features/user/presentation/pages/otp_page.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();

  static Country _selectedFilteredDialoCountry = CountryPickerUtils.getCountryByPhoneCode("58");

  String _countryCode = _selectedFilteredDialoCountry.phoneCode;
  String _phoneNumber = "";

  @override
  void dispose() {
    // Liberar recursos al cerrar la página
    // Release resources when closing the page
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
      listener: (BuildContext context, CredentialState state) {
        if (state is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        } else if (state is CredentialFailure) {
          _showToast("Something went wrong");
        }
      },
      builder: (context, state) {
        if (state is CredentialLoading) {
          return const Center(child: CircularProgressIndicator(color: tabColor));
        } else if (state is CredentialPhoneAuthSmsCodeReceived) {
          return const OtpPage();
        } else if (state is CredentialPhoneAuthProfileInfo) {
          return InitialProfileSubmitPage(phoneNumber: _phoneNumber);
        } else if (state is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(uid: authState.uid);
              }
              return _buildLoginForm();
            },
          );
        }
        return _buildLoginForm();
      },
    );
  }

  /// Construye el widget de formulario de inicio de sesión.
  /// Builds the login form widget.
  Widget _buildLoginForm() {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      S.of(context).Verify_your_phone_number,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: tabColor,
                      ),
                    ),
                  ),
                  Text(
                    S.of(context).WhatsApp_will_send_an_SMS_message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                    onTap: _openFilteredCountryPickerDialog,
                    title: _buildDialogItem(_selectedFilteredDialoCountry),
                  ),
                  Row(
                    children: [
                      _buildCountryCodeBox(),
                      const SizedBox(width: 8.0),
                      _buildPhoneNumberField(),
                    ],
                  ),
                ],
              ),
            ),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  /// Construye el cuadro que muestra el código de país seleccionado.
  /// Builds the box displaying the selected country code.
  Widget _buildCountryCodeBox() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: tabColor, width: 1.5),
        ),
      ),
      width: 80,
      height: 42,
      alignment: Alignment.center,
      child: Text(_selectedFilteredDialoCountry.phoneCode),
    );
  }

  /// Construye el campo de entrada para el número de teléfono.
  /// Builds the input field for the phone number.
  Widget _buildPhoneNumberField() {
    return Expanded(
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(top: 1.5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: tabColor, width: 1.5),
          ),
        ),
        child: TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            hintText: S.of(context).Phone_Number,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  /// Construye el botón de "Siguiente".
  /// Builds the "Next" button.
  Widget _buildNextButton() {
    return GestureDetector(
      onTap: _submitVerifyPhoneNumber,
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

  /// Abre el diálogo para seleccionar un país y su código de marcación.
  /// Opens the dialog to select a country and its dialing code.
  void _openFilteredCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (_) => Theme(
        data: Theme.of(context).copyWith(primaryColor: tabColor),
        child: CountryPickerDialog(
          titlePadding: const EdgeInsets.all(8.0),
          searchCursorColor: tabColor,
          searchInputDecoration: InputDecoration(
            hintText: S.of(context).Search,
          ),
          isSearchable: true,
          title: Text(S.of(context).Select_your_phone_code),
          onValuePicked: (Country country) {
            setState(() {
              _selectedFilteredDialoCountry = country;
              _countryCode = country.phoneCode;
            });
          },
          itemBuilder: _buildDialogItem,
        ),
      ),
    );
  }

  /// Construye un elemento de la lista de selección de países.
  /// Builds an item in the country selection list.
  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: tabColor, width: 1.5),
        ),
      ),
      child: Row(
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          Expanded(
            child: Text(
              country.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  /// Envía el número de teléfono para la verificación.
  /// Submits the phone number for verification.
  void _submitVerifyPhoneNumber() {
    if (_phoneController.text.isNotEmpty) {
      _phoneNumber = "+$_countryCode${_phoneController.text}";
      print("phoneNumber $_phoneNumber");
      BlocProvider.of<CredentialCubit>(context).submitVerifyPhoneNumber(phoneNumber: _phoneNumber);
    } else {
      _showToast("Enter your phone number");
    }
  }

  /// Muestra un mensaje de toast.
  /// Shows a toast message.
  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
