import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:registration_ui/constants/colors.dart';
import 'package:registration_ui/translations/locale_keys.g.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List products = [
    LocaleKeys.newsText1.tr(),
    LocaleKeys.newsText2.tr(),
    LocaleKeys.newsText3.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PeachMainView,
      appBar: AppBar(
        title: Text(
          LocaleKeys.appbarNews.tr(),
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
      body: Container(
        color: AppColors.PeachMainView,
        child: Center(
          child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('${products[index]}',
                        textAlign: TextAlign.justify),
                    trailing: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 50,
                        maxHeight: 64,
                      ),
                      child: LikeButton(
                        size: 20,
                        circleColor: const CircleColor(
                            start: Colors.redAccent, end: Colors.red),
                        bubblesColor: const BubblesColor(
                            dotPrimaryColor: Colors.redAccent,
                            dotSecondaryColor: Colors.deepOrange),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.red : Colors.grey,
                            size: 20,
                          );
                        },
                        likeCount: 0,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
