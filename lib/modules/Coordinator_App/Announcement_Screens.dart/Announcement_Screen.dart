import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/models/Announcement_Model.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'New_Announcement.dart';

class Announcements_Screen extends StatelessWidget {
  var Scaffold_key = GlobalKey<ScaffoldState>();
  bool isNotification;
  Announcements_Screen({
    required this.isNotification,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        key: Scaffold_key,
        body: Column(
          children: [
            appBar(context: context, text: 'Announcements'),
            Expanded(
              child: ConditionalBuilder(
                condition: state is! Coordinator_Get_Announcements_Loding_State,
                fallback: (context) => My_Circular_Loading(),
                builder: (context) => cubit(context).Announcements.isNotEmpty
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Announcement_Item(
                          context: context,
                          model: cubit(context).Announcements[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: cubit(context).Announcements.length,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Rectangle 86.png',
                            height: 300,
                            width: 300,
                          ),
                          Text(
                            'There are no announcements',
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            //if (state is Coordinator_Get_Announcements_Loding_State)
          ],
        ),
        floatingActionButton: isNotification
            ? Container()
            : InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  My_NavigatTo(
                    context: context,
                    type: PageTransitionType.rightToLeft,
                    nextPage: New_Announcement_Screen(),
                  );
                },
                child: CircleAvatar(
                  radius: 34,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      gradient: GradientColor(),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Padding Announcement_Item({
    required BuildContext context,
    required Announcement_Model model,
  }) =>
      Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 15,
        ),
        child: InkWell(
          onTap: () {
            Scaffold_key.currentState!
                .showBottomSheet((context) => ShowBottomSheet(
                      context: context,
                      model: model,
                    ));
          },
          child: Container(
            height: 115,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GreyColor,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/Announc.png',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 5,
                      end: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        My_Text(
                          context: context,
                          text: model.title!,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                        My_Text(
                          context: context,
                          text: model.content!,
                          fontSize: 16,
                          color: Colors.black.withOpacity(.8),
                        ),
                        My_Text(
                          context: context,
                          text: 'Summer Practice',
                          fontSize: 15,
                          color: Colors.black.withOpacity(.8),
                        ),
                        My_Text(
                          context: context,
                          text: timeago
                              .format(DateTime.parse(model.datePublished)),
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  // ignore: non_constant_identifier_names
  BlocConsumer ShowBottomSheet({
    required BuildContext context,
    required Announcement_Model model,
  }) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {},
      builder: (context, state) => Container(
        height: height(context) / 1.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsetsDirectional.only(
                top: 12.5,
                start: 12.5,
                end: 12.5,
                bottom: 8,
              ),
              height: height(context) / 7.2,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: GradientColor(),
                borderRadius: const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20),
                  topStart: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 5.5,
                    width: width(context) / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            My_Text(
                              context: context,
                              text: 'About ${model.title!}',
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            My_Text(
                              context: context,
                              // TODO:
                              text: 'Instrator Name',
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/anno_W.png',
                        height: height(context) / 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/Rectangle 86.png',
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: My_Text(
                        context: context,
                        text: model.content!,
                        maxLines: false,
                        color: Colors.black45,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 10,
                  bottom: 5,
                ),
                child: My_Text(
                  context: context,
                  text: timeago.format(DateTime.parse(model.datePublished)),
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              height: height(context) / 13,
              decoration: BoxDecoration(
                gradient: GradientColor(),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(20),
                  bottomStart: Radius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
