import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_ui/constants/colors.dart';
import 'package:registration_ui/features/app/bloc/app_bloc.dart';
import 'package:registration_ui/features/app/ui/pages/choose_lang.dart';
import 'package:registration_ui/model/profile.dart';
import 'package:registration_ui/services/shared_preference.dart';

import '../../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc profileBloc;
  late AppBloc appBloc;
  Profile? profile;
  String? userName = sharedPreference.getUserName;
  String? userFullname = sharedPreference.getUserFullname;
  String? userEmail = sharedPreference.getUserEmail;
  String? userPhone = sharedPreference.getUserPhone;

  @override
  void initState() {
    profileBloc = ProfileBloc();
    profileBloc.add(FetchedProfileEvent());
    appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PeachMainView,
      appBar: AppBar(
        title: Text(
          "User INFO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.elliptical(700, 50),
              bottomLeft: Radius.elliptical(700, 50)),
        ),
        centerTitle: true,
        backgroundColor: AppColors.PeachMainView,
      ),
      body: BlocBuilder(
        bloc: profileBloc,
        builder: (context, state) {
          if (state is LoadingProfileState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadedProfileState) {
            profile = state.profile;
            return buildBody();
          }
          if (state is FailureProfileState) {
            return Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildBody() {
    return ListView(
      children: [
        SizedBox(height: 50),
        Card(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          elevation: 15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text(userFullname!),
              ),
              ListTile(
                leading: Icon(Icons.assignment_ind),
                title: Text(userName!),
              ),
              ListTile(
                leading: Icon(Icons.alternate_email_outlined),
                title: Text(userEmail!),
              ),
              ListTile(
                leading: Icon(Icons.phone_android_outlined),
                title: Text(userPhone!),
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: AppColors.PeachIconBorderLogin,
              fixedSize: Size(100, 100),
              shape: CircleBorder()),
          onPressed: () {
            appBloc.add(LogoutAppEvent());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChooseLang(),
              ),
            );
          },
          child: Icon(
            Icons.logout_rounded,
            size: 40,
          ),
        ),
      ],
    );
  }
}
