import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/features/user/presentation/pages/otp_page.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _phoneController = TextEditingController();

  static Country _selectedFilteredDialoCountry = CountryPickerUtils.getCountryByPhoneCode("58");

  
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
                      const SizedBox(height: 40,), 
                      Center(
                        child: 
                          Text(S.of(context).Verify_your_phone_number,
                            style: 
                              const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: tabColor,
                              ),
                            //style  
                          ),
                      ),
                
                      Text(S.of(context).WhatsApp_will_send_an_SMS_message,
                        textAlign: TextAlign.center,
                        style: 
                          const TextStyle(
                            fontSize: 15,
                          ),
                        //style
                      ),
                
                      const SizedBox(height: 30,),
                
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                        onTap: _openFilteredCountryPickerDialog,
                        title: _buildDialogItem(_selectedFilteredDialoCountry),
                      ),
                
                      Row(
                        children: <Widget> [
                          Container(
                            decoration:
                              const BoxDecoration(
                                border: 
                                  Border(
                                    bottom: 
                                      BorderSide(
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
                          const SizedBox(
                            width: 8.0,
                          ),
                // Suggested code may be subject to a license. Learn more: ~LicenseLog:3818608879.
                          Expanded(
                            child: Container(
                                height: 40,
                                margin: const EdgeInsets.only(top: 1.5),
                                decoration: const BoxDecoration(border: Border(bottom:BorderSide(color: tabColor,width: 1.5),),),
                                child: TextField(
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).Phone_Number,
                                    border: InputBorder.none,),
                              ),   
                            ),
                          ),
                        ],
                      ),
                
                      
                    ],
                  ),
              ),
              GestureDetector(
                onTap: () {  
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpPage()));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom:20),
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: tabColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                child: Center(
                  child: Text(S.of(context).Next,
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

  void _openFilteredCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (_) =>
        Theme(
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
            

          )          
        ),
    );
  }
}

Widget _buildDialogItem(Country country) {
  return Container( 
    height: 40,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: tabColor,width: 1.5),
      ),
    ),
    child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Text(" +${country.phoneCode}"),
          Expanded(child: Text(" ${country.name}",maxLines: 1,overflow: TextOverflow.ellipsis,)),
          const Spacer(),
          const Icon(Icons.arrow_drop_down),          
        ],
      ),
  );

}