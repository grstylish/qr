import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_ui/constants/colors.dart';
import 'package:registration_ui/features/app/bloc/app_bloc.dart';
import 'package:registration_ui/features/app/ui/pages/registration_page.dart';

class ChooseLang extends StatefulWidget {
  const ChooseLang({Key? key}) : super(key: key);

  @override
  State<ChooseLang> createState() => _ChooseLangState();
}

class _ChooseLangState extends State<ChooseLang> {
  late AppBloc appBloc;

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.PeachMainView
      ),
      home: Scaffold(
        body: Center(
            child: Column(
              children: [
                SizedBox(height: 200,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.PeachAppView,
                        fixedSize: Size(320, 70),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    onPressed: () async{
                      await context.setLocale(Locale('en'));
                      appBloc.add(AppStartedEvent());
                        Navigator.push( context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationPage(),
                          ),
                        );
                    }, child:Text("ENGLISH") ),
                SizedBox(height: 100,),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.PeachAppView,
                        fixedSize: Size(320, 70),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    onPressed: () async{
                      await context.setLocale(Locale('ru'));
                      appBloc.add(AppStartedEvent());
                      Navigator.push( context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationPage(),
                        ),
                      );
                    }, child:Text("РУССКИЙ") ),
                SizedBox(height: 100,),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.PeachAppView,
                        fixedSize: Size(320, 70),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    onPressed: () async{
                      await context.setLocale(Locale('kk'));
                      appBloc.add(AppStartedEvent());
                      Navigator.push( context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationPage(),
                        ),
                      );
                    }, child:Text("КАЗАХСКИЙ") ),

              ],
            )
        ),
      ),
    );
  }
}