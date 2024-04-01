import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:registration_ui/constants/colors.dart';
import 'package:registration_ui/translations/locale_keys.g.dart';

import '../../../../model/example_list.dart';
import '../../bloc/list_bloc.dart';

class ExampleListPage extends StatefulWidget {
  const ExampleListPage({super.key});

  @override
  State<ExampleListPage> createState() => _ExampleListPageState();
}

class _ExampleListPageState extends State<ExampleListPage> {
  late ListBloc listBloc;
  List<ExampleList> exampleList = [];

  @override
  void initState() {
    listBloc = ListBloc();
    listBloc.add(FetchedListEvent());
    super.initState();
  }

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
      body: BlocBuilder(
        bloc: listBloc,
        builder: (context, state) {
          if (state is LoadingListState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is LoadedListState) {
            exampleList = state.exampleList;
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
    List<Widget> children = [];
    for (var item in exampleList) {
      children.add(
        Stack(
          children: [
            Card(
              child: ListTile(
                title: Text(item.title.toString(),
                  textAlign: TextAlign.start,),
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
                  ),),
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      child: SingleChildScrollView(
        child: Column(children: children),
      ),
    );
  }
}
