// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `App Name`
  String get AppName {
    return Intl.message(
      'App Name',
      name: 'AppName',
      desc: '',
      args: [],
    );
  }

  /// `Cluster Passport`
  String get AppNameCP0 {
    return Intl.message(
      'Cluster Passport',
      name: 'AppNameCP0',
      desc: '',
      args: [],
    );
  }

  /// `CLUSTER PASSPORT`
  String get AppNameCP1 {
    return Intl.message(
      'CLUSTER PASSPORT',
      name: 'AppNameCP1',
      desc: '',
      args: [],
    );
  }

  /// `WelcomePage Translation`
  String get WelcomePageTranslation {
    return Intl.message(
      'WelcomePage Translation',
      name: 'WelcomePageTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Cluster Passport`
  String get WtoCP {
    return Intl.message(
      'Welcome to Cluster Passport',
      name: 'WtoCP',
      desc: '',
      args: [],
    );
  }

  /// `Read our Privacy Policy Tap, 'Agree and Continue' to accept the Team of Service.`
  String get ROPP {
    return Intl.message(
      'Read our Privacy Policy Tap, \'Agree and Continue\' to accept the Team of Service.',
      name: 'ROPP',
      desc: '',
      args: [],
    );
  }

  /// `AGREE AND CONTINUE`
  String get AC {
    return Intl.message(
      'AGREE AND CONTINUE',
      name: 'AC',
      desc: '',
      args: [],
    );
  }

  /// `LoginPage Translation`
  String get LoginPageTranslation {
    return Intl.message(
      'LoginPage Translation',
      name: 'LoginPageTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Verify your phone number`
  String get Verify_your_phone_number {
    return Intl.message(
      'Verify your phone number',
      name: 'Verify_your_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp will send an SMS message (carrier charges may apply) to verify your phone number. Enter the code and phone number`
  String get WhatsApp_will_send_an_SMS_message {
    return Intl.message(
      'WhatsApp will send an SMS message (carrier charges may apply) to verify your phone number. Enter the code and phone number',
      name: 'WhatsApp_will_send_an_SMS_message',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get Phone_Number {
    return Intl.message(
      'Phone number',
      name: 'Phone_Number',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Select your phone code`
  String get Select_your_phone_code {
    return Intl.message(
      'Select your phone code',
      name: 'Select_your_phone_code',
      desc: '',
      args: [],
    );
  }

  /// `OTPPage Translation`
  String get OtpPageTranslation {
    return Intl.message(
      'OTPPage Translation',
      name: 'OtpPageTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Verify your OTP`
  String get Verify_your_OTP {
    return Intl.message(
      'Verify your OTP',
      name: 'Verify_your_OTP',
      desc: '',
      args: [],
    );
  }

  /// `Enter your OTP for the WhatsApp Clone Verification (so that you will be moved for the further steps to complete)`
  String get Enter_your_OTP {
    return Intl.message(
      'Enter your OTP for the WhatsApp Clone Verification (so that you will be moved for the further steps to complete)',
      name: 'Enter_your_OTP',
      desc: '',
      args: [],
    );
  }

  /// `Enter your 6 digit code`
  String get Enter_your_6_digit_code {
    return Intl.message(
      'Enter your 6 digit code',
      name: 'Enter_your_6_digit_code',
      desc: '',
      args: [],
    );
  }

  /// `Settings Page`
  String get Settings_Page {
    return Intl.message(
      'Settings Page',
      name: 'Settings_Page',
      desc: '',
      args: [],
    );
  }

  /// `Security applications, change number`
  String get settingsItemWidget_text01 {
    return Intl.message(
      'Security applications, change number',
      name: 'settingsItemWidget_text01',
      desc: '',
      args: [],
    );
  }

  /// `Block contacts, temporary messages`
  String get settingsItemWidget_text02 {
    return Intl.message(
      'Block contacts, temporary messages',
      name: 'settingsItemWidget_text02',
      desc: '',
      args: [],
    );
  }

  /// `Theme, wallpapers, chat history`
  String get settingsItemWidget_text03 {
    return Intl.message(
      'Theme, wallpapers, chat history',
      name: 'settingsItemWidget_text03',
      desc: '',
      args: [],
    );
  }

  /// `Logout from WhatsApp Clone`
  String get settingsItemWidget_text04 {
    return Intl.message(
      'Logout from WhatsApp Clone',
      name: 'settingsItemWidget_text04',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Polices`
  String get PP {
    return Intl.message(
      'Privacy Polices',
      name: 'PP',
      desc: '',
      args: [],
    );
  }

  /// `Terms of service`
  String get TS {
    return Intl.message(
      'Terms of service',
      name: 'TS',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get TC {
    return Intl.message(
      'Terms and Conditions',
      name: 'TC',
      desc: '',
      args: [],
    );
  }

  /// `general word bank`
  String get general_word_bank {
    return Intl.message(
      'general word bank',
      name: 'general_word_bank',
      desc: '',
      args: [],
    );
  }

  /// `Passport`
  String get Passport0 {
    return Intl.message(
      'Passport',
      name: 'Passport0',
      desc: '',
      args: [],
    );
  }

  /// `Pasaporte`
  String get Passport1 {
    return Intl.message(
      'Pasaporte',
      name: 'Passport1',
      desc: '',
      args: [],
    );
  }

  /// `Cluster`
  String get Cluster {
    return Intl.message(
      'Cluster',
      name: 'Cluster',
      desc: '',
      args: [],
    );
  }

  /// `Cluster`
  String get Cluster1 {
    return Intl.message(
      'Cluster',
      name: 'Cluster1',
      desc: '',
      args: [],
    );
  }

  /// `Authorized`
  String get Authorized {
    return Intl.message(
      'Authorized',
      name: 'Authorized',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get Account {
    return Intl.message(
      'Account',
      name: 'Account',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get Privacy {
    return Intl.message(
      'Privacy',
      name: 'Privacy',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get Chats {
    return Intl.message(
      'Chats',
      name: 'Chats',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get Username {
    return Intl.message(
      'Username',
      name: 'Username',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'messages'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
