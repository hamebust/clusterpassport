//LoginPage: página de inicio de sesión en la carpeta lib/features/user/presentation/pages
//LoginPage: login page in the lib/features/user/presentation/pages folder

//Paquete que permite conectar a Style: estilo de la aplicación en la carpeta lib/features/app/theme/style
//Package that allows connecting to Style: style of the application in the lib/features/app/theme/style folder
import 'package:cluster_passport/features/app/theme/style.dart';
//Paquete que permite conectar a OtpPage: página de inicio de sesión en la carpeta lib/features/user/presentation/pages
//Package that allows connecting to OtpPage: login page in the lib/features/user/presentation/pages folder
import 'package:cluster_passport/features/user/presentation/pages/otp_page.dart';
//Paquete que permite conectar a S: internacionalización de la aplicación en la carpeta lib/generated/l10n
//Package that allows connecting to S: internationalization of the application in the lib/generated/l10n folder
import 'package:cluster_passport/generated/l10n.dart';
//Paquete que permite conectar a Country: paises en la carpeta lib/country_pickers
//Package that allows connecting to Country: countries in the lib/country_pickers folder
import 'package:country_pickers/country.dart';
//Paquete que permite conectar a CountryPickerDialog: dialogo de seleccion de paises en la carpeta lib/country_pickers
//Package that allows connecting to CountryPickerDialog: country selection dialog in the lib/country_pickers folder
import 'package:country_pickers/country_picker_dialog.dart';
//Paquete que permite conectar a Utils: utilidades en la carpeta lib/country_pickers
//Package that allows connecting to Utils: utilities in the lib/country_pickers folder
import 'package:country_pickers/utils/utils.dart';
//Paquete que permite conectar a Flutter: widget principal de la aplicación en la carpeta main.dart
//Package that allows connecting to Flutter: main widget of the application in main.dart
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();

  static Country _selectedFilteredDialoCountry =
      CountryPickerUtils.getCountryByPhoneCode("58");

  // ignore: unused_field
  String _countryCode = _selectedFilteredDialoCountry.phoneCode;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  //Texto de bienvenida e imagen de fondo
                  //Welcome text and background image
                  const SizedBox(height: 40,),
                  Center(
                    child: Text(
                      //Paquete l10n -> S.of(context).Verify_your_phone_number, contiene el texto de verificar el numero de telefono
                      //Package l10n -> S.of(context).Verify_your_phone_number contains the verify phone number text
                      S.of(context).Verify_your_phone_number,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: tabColor,
                      ),
                      //style
                    ),
                  ),
                  Text(
                    //Paquete l10n -> S.of(context).WhatsApp_will_send_an_SMS_message, contiene el texto de WhatsApp enviando un mensaje SMS
                    //Package l10n -> S.of(context).WhatsApp_will_send_an_SMS_message contains the WhatsApp sending an SMS message text
                    S.of(context).WhatsApp_will_send_an_SMS_message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    //style
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                    onTap: _openFilteredCountryPickerDialog,
                    title: _buildDialogItem(_selectedFilteredDialoCountry),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: tabColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        width: 80,
                        height: 42,
                        alignment: Alignment.center,
                        child: Text(_selectedFilteredDialoCountry.phoneCode),
                      ),
                      //Caja separadora
                      //Separator box
                      const SizedBox(width: 8.0,),
                      // Suggested code may be subject to a license. Learn more: ~LicenseLog:3818608879.
                      Expanded(
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
                              hintText:
                                  //Paquete l10n -> S.of(context).Phone_Number, contiene el texto de numero de telefono
                                  //Package l10n -> S.of(context).Phone_Number contains the phone number text
                                  S.of(context).Phone_Number,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Boton de siguiente
            //Next button
            GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => const OtpPage()));
              },
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
                    //Paquete l10n -> S.of(context).Next, contiene el texto de siguiente
                    //Package l10n -> S.of(context).Next contains the next text
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

  // Abre el dialogo de seleccion de paises
  // Opens the country selection dialog
  void _openFilteredCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (_) => Theme(
          data: Theme.of(context).copyWith(
            primaryColor: tabColor,
          ),
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
          )),
    );
  }
}

//Caja de busqueda de paises
//Country search box
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        Text(" +${country.phoneCode}"),
        Expanded(
            child: Text(
          " ${country.name}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
        const Spacer(),
        const Icon(Icons.arrow_drop_down),
      ],
    ),
  );
}
