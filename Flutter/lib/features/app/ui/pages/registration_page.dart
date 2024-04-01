import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:registration_ui/constants/colors.dart';
import 'package:registration_ui/features/app/ui/pages/logginig_page.dart';
import 'package:registration_ui/features/app/ui/pages/welcome_page.dart';
import 'package:registration_ui/services/shared_preference.dart';
import 'package:registration_ui/translations/locale_keys.g.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _hidepassword = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();

  final _fullnameFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  final maskFormatter = MaskTextInputFormatter(mask: '+7(###)###-##-##');

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF4d3e96),
                    Color(0xFF924cba),
                    Color(0xFF4d3e96)
                  ]),
            ),
            child: ListView(
              padding: const EdgeInsets.only(
                  top: 200, bottom: 250, right: 40, left: 40),
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: GradientText(
                    LocaleKeys.registr.tr(),
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: const [Color(0xFFd2089a), Color(0xFFdf2166)],
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  focusNode: _fullnameFocus,
                  autofocus: true,
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _fullnameFocus, _usernameFocus);
                  },
                  controller: _fullnameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.RegInput,
                      hintText: LocaleKeys.inputfullname.tr(),
                      prefixIcon: Icon(Icons.people,
                          color: AppColors.PurpleIconBorderReg),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: AppColors.PurpleIconBorderReg, width: 2.0),
                      )),
                  validator: validateFullName,
                  onSaved: (value) => value!,
                ),
                const SizedBox(height: 7),
                TextFormField(
                  focusNode: _usernameFocus,
                  autofocus: true,
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _usernameFocus, _emailFocus);
                  },
                  controller: _usernameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.RegInput,
                      hintText: LocaleKeys.inputusername.tr(),
                      prefixIcon: Icon(
                        Icons.assignment_ind,
                        color: AppColors.PurpleIconBorderReg,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: AppColors.PurpleIconBorderReg, width: 2.0),
                      )),
                  validator: validateUsername,
                  onSaved: (value) => value!,
                ),
                const SizedBox(height: 7),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.RegInput,
                      hintText: LocaleKeys.inputemail.tr(),
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: AppColors.PurpleIconBorderReg,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: AppColors.PurpleIconBorderReg, width: 2.0),
                      )),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  onSaved: (value) => value!,
                ),
                const SizedBox(height: 7),
                TextFormField(
                  focusNode: _phoneFocus,
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _phoneFocus, _passFocus);
                  },
                  controller: _phoneController,
                  // maxLength: 10,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.RegInput,
                      hintText: LocaleKeys.inputphone.tr(),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: AppColors.PurpleIconBorderReg,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: AppColors.PurpleIconBorderReg, width: 2.0),
                      )),
                  keyboardType: TextInputType.phone,
                  // inputFormatters: [
                  //   maskFormatter,
                  //   FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,10}$'),
                  //       allow: true),
                  // ],
                  inputFormatters: [maskFormatter],
                  // validator: (value) => validatePhoneNumber(value!)
                  //     ? null
                  //     : 'Phone number must be entered as (###)###-####',
                  onSaved: (value) => value!,
                ),
                const SizedBox(height: 7),
                TextFormField(
                  focusNode: _passFocus,
                  controller: _passController,
                  obscureText: _hidepassword,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.RegInput,
                      hintText: LocaleKeys.inputpassword.tr(),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _hidepassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.PurpleIconBorderReg),
                        onPressed: () {
                          setState(() {
                            _hidepassword = !_hidepassword;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: AppColors.PurpleIconBorderReg,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: AppColors.PurpleIconBorderReg, width: 2.0),
                      )),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [Color(0xFFBA68C8), Color(0xFF8E24AA)],
                    ),
                  ),
                  height: 35,
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const StadiumBorder(),
                    onPressed: _submitForm,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 115),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.buttonSubmit.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        LocaleKeys.haveacc.tr(),
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogginigPage()),
                        );
                      },
                      child: Text(
                        LocaleKeys.buttonSign.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.amberAccent,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  //
  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     // const url = 'https://registrationui-349af-default-rtdb.firebaseio.com/user.json';
  //     // http.post(Uri.parse(url),body: jsonEncode({
  //     //   'fullname': _fullnameController,
  //     //   'phone': _phoneController,
  //     //   'email': _emailController,
  //     //   'password': _passController,
  //     //   'username': _usernameController
  //     // }));
  //     _showDialog(name: _fullnameController.text);
  //   } else {
  //     _showMessage(message: LocaleKeys.submitForm.tr());
  //   }
  // }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      const url1 =
          'https://registrationui-349af-default-rtdb.firebaseio.com/profileInfo.json';
      http
          .post(Uri.parse(url1),
              body: jsonEncode({
                'name': _fullnameController.text,
                'phone': _phoneController.text,
                'Email': _emailController.text,
              }))
          .then((response) {
        print(json.decode(response.body));
        String userName = json.decode(response.body)['name'];
        _showDialog(name: '$userName');
        sharedPreference.saveUserName(_fullnameController.text);
        sharedPreference.saveUserFullname(_usernameController.text);
        sharedPreference.saveUserEmail(_emailController.text);
        sharedPreference.saveUserPhone(_phoneController.text);
      });
    } else {
      _showMessage(message: LocaleKeys.submitForm.tr());
    }
  }

  String? validateFullName(String? value) {
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return LocaleKeys.validFullnamereq.tr();
    } else if (!nameExp.hasMatch(value)) {
      return LocaleKeys.validFullnamealph.tr();
    } else {
      return null;
    }
  }

  String? validateUsername(String? value) {
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return LocaleKeys.validUsernamereq.tr();
    } else if (!nameExp.hasMatch(value)) {
      return LocaleKeys.validUsernamealph.tr();
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value == null) {
      return LocaleKeys.validEmailempty.tr();
    } else if (!_emailController.text.contains('@')) {
      return LocaleKeys.validEmailaddress.tr();
    } else {
      return null;
    }
  }

  // bool validatePhoneNumber(String input) {
  //   final phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\-\d\d$');
  //   return phoneExp.hasMatch(input);
  // }

  String? _validatePassword(String? value) {
    if (_passController.text.length <= 7) {
      return LocaleKeys.validPassword.tr();
    } else {
      return null;
    }
  }

  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: Text(
            LocaleKeys.dialogDone.tr(),
            style: TextStyle(
                color: AppColors.PurpleIconBorderReg,
                fontFamily: 'helvetica_neue_light',
                fontSize: 23),
          ),
          content: Text(
            '$name' + LocaleKeys.dialogText.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              fontFamily: 'helvetica_neue_light',
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.PurpleIconBorderReg),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(
                              color: AppColors.PurpleIconBorderReg)))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomePage()));
              },
              child: Text(
                LocaleKeys.dialogButton.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'helvetica_neue_light',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0xFFEF5350),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w300, fontSize: 15),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
