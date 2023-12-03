import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/modules/Coordinator_App/About_Screen.dart';
import 'package:coordinator_app/modules/Coordinator_App/Add_Internship_Screen.dart';
import 'package:coordinator_app/modules/Coordinator_App/All_Requests_Screen.dart';
import 'package:coordinator_app/modules/Coordinator_App/Messages/Chats_Screen.dart';
import 'package:coordinator_app/modules/Coordinator_App/Profile_Screen.dart';
import 'package:coordinator_app/modules/Coordinator_App/Settings_Screens/Settings_Screen.dart';
import 'package:coordinator_app/shared/remote/network/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

import '../../shared/components/components.dart';
import 'Announcement_Screens.dart/Announcement_Screen.dart';

Widget menu(BuildContext context) {
  List<String> menuButtonTittles = [
    'All Requests',
    'Messages',
    'Announcement',
    'Add Internship',
    'Settings',
    'About',
  ];
  List<Widget> menunavigateScreenn = [
    const All_Requests_Screen(),
    const Chats_Screen(),
    Announcements_Screen(
      isNotification: false,
    ),
    AddInternship_Screen(),
    const Settings_Screen(),
    const About_Screen(),
  ];

  return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
    listener: (context, state) {},
    builder: (context, state) => Padding(
      padding: const EdgeInsets.only(
        bottom: 0,
      ),
      child: Container(
        height: double.infinity,
        width: width(context) / 1.5,
        decoration: BoxDecoration(
          color: HexColor('F5F5F5'),
          border: Border.all(
            color: HexColor('#09B3AD'),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: SafeArea(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    My_NavigatTo(
                      context: context,
                      type: PageTransitionType.leftToRight,
                      nextPage: Profile_Screen(),
                    );
                  },
                  child: SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 31.5,
                          backgroundColor: Colors.grey,
                          child: Center(
                            child: CircleAvatar(
                              radius: 31,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: NetworkImage(
                                cubit(context)
                                            .coordinator_all_data_model!
                                            .profilePic! !=
                                        ""
                                    ? cubit(context).Media_URL(
                                        url: cubit(context)
                                            .coordinator_all_data_model!
                                            .profilePic!,
                                      )
                                    : 'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 7.5,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit(context)
                                    .coordinator_all_data_model!
                                    .name!,
                                maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Bellefair',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                cubit(context)
                                    .coordinator_all_data_model!
                                    .email!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Bellefair',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 15,
                  ),
                  child: Divider(
                    color: HexColor('#09B3AD'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => DrawerMenuItem(
                              context,
                              menuButtonTittles[index],
                              () {
                                My_NavigatTo(
                                  context: context,
                                  type: PageTransitionType.leftToRight,
                                  nextPage: menunavigateScreenn[index],
                                );
                              },
                            ),
                            itemCount: menuButtonTittles.length,
                          ),
                        ),
                        Image.asset('assets/images/Frame 25.png',
                            width: width(context) / 1.7),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: HexColor('#09B3AD'),
                ),
                InkWell(
                  onTap: () {
                    cubit(context).logout(context);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout_outlined,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Log Out',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

InkWell DrawerMenuItem(BuildContext context, String text, Function function) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 19,
              ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            end: 15,
          ),
          child: Divider(
            color: HexColor('#09B3AD'),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
