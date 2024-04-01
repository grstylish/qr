import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:registration_ui/constants/colors.dart';
import 'package:registration_ui/features/app/ui/pages/registration_page.dart';
import 'package:registration_ui/features/app/ui/pages/welcome_page.dart';
import 'package:registration_ui/translations/locale_keys.g.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LogginigPage extends StatefulWidget {
  const LogginigPage({Key? key}) : super(key: key);

  @override
  State<LogginigPage> createState() => _LogginigPageState();
}

class _LogginigPageState extends State<LogginigPage> {
  bool _hidepassword = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();


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
                    Color(0xFFf9cc7b),
                    Color(0xFFf7764a)
                  ]),
            ),
            child: ListView(
              padding: const EdgeInsets.only(
                  top: 210, bottom: 240, right: 40, left: 40),
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: GradientText(
                    LocaleKeys.login.tr(),
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight:FontWeight.bold,
                    ),
                    colors: const [
                      Color(0xFFf15256),
                      Color(0xFFf15256)],),
                ),
                const SizedBox(height: 15),

                TextFormField(
                  focusNode: _usernameFocus,
                  autofocus: true,
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _usernameFocus, _emailFocus);
                  },
                  controller: _usernameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.LoginInput,
                      hintText: LocaleKeys.inputusername.tr(),
                      prefixIcon: Icon(
                        Icons.assignment_ind,
                        color: AppColors.PeachIconBorderLogin,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                        BorderSide(color: AppColors.PeachIconBorderLogin, width: 2.0),
                      )),
                  validator: validateloginUsername,
                  onSaved: (value) => value!,
                ),

                const SizedBox(height: 7),

                TextFormField(
                  focusNode: _emailFocus,
                  autofocus: true,
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _emailFocus, _passFocus);
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.LoginInput,
                      hintText: LocaleKeys.inputemail.tr(),
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: AppColors.PeachIconBorderLogin,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                        BorderSide(color: AppColors.PeachIconBorderLogin, width: 2.0),
                      )),
                  validator: validatelloginEmail,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) =>  value!,

                ),

                const SizedBox(height: 7),

                TextFormField(
                  focusNode: _passFocus,
                  controller: _passController,
                  obscureText: _hidepassword,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.LoginInput,
                      hintText: LocaleKeys.inputpassword.tr(),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _hidepassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.PeachIconBorderLogin),
                        onPressed: () {
                          setState(() {
                            _hidepassword = !_hidepassword;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: AppColors.PeachIconBorderLogin,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 2.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                        BorderSide(color: AppColors.PeachIconBorderLogin, width: 2.0),
                      )),
                  validator: _validateloginPassword,
                ),

                const SizedBox(height: 10),

                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xFFf15256),
                        Color(0xFFff6b29)],
                    ),
                  ),
                  height: 35,
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const StadiumBorder(),
                    onPressed: _submitloginForm,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 115),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.buttonSign.tr(),
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
                      child: Text(LocaleKeys.noAcc.tr(),
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13
                        ),),
                    ),
                    TextButton(
                      onPressed:() {
                        Navigator.push( context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationPage(),
                          ),
                        );},
                      child: Text(
                        LocaleKeys.buttonRegist.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFdd434f),
                          fontSize: 14,
                        ),
                      ),)
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _submitloginForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    } else {
      _showMessage(message: LocaleKeys.submitForm.tr());
    }
  }


  String? validateloginUsername(String? value) {
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return LocaleKeys.validUsernamereq.tr();
    } else if (!nameExp.hasMatch(value)) {
      return LocaleKeys.validUsernamealph.tr();
    } else {
      return null;
    }
  }

  String? validatelloginEmail(String? value) {
    if (value == null) {
      return LocaleKeys.validEmailempty.tr();
    } else if (!_emailController.text.contains('@')) {
      return LocaleKeys.validEmailaddress.tr();
    } else {
      return null;
    }
  }


  String? _validateloginPassword(String? value) {
    if (_passController.text.length <= 7) {
      return LocaleKeys.validPassword.tr();
    }  else {
      return null;
    }
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
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 15
          ),),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      ),
    );
  }
}
