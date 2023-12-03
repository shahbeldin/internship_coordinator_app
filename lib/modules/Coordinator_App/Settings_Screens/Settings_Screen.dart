import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/modules/Coordinator_App/Settings_Screens/Privacy_Policy_Screen.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../layout/cubit/coordinator_cubit.dart';

class Settings_Screen extends StatelessWidget {
  const Settings_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
              body: Stack(
                children: [
                  My_TopStack(
                    context: context,
                    isMenu: false,
                    logo: false,
                    is_Settings_Screen: true,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 15,
                        end: 15,
                        top: height(context) / 4,
                      ),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(30),
                            topEnd: Radius.circular(30),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 20,
                                    end: 20,
                                    top: 10,
                                    bottom: 5,
                                  ),
                                  child: Row(
                                    children: [
                                      My_Text(
                                        context: context,
                                        text: 'Account Settings',
                                        color: Colors.grey,
                                      ),
                                      // Text(
                                      //   'Account Settings',
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .titleLarge!
                                      //       .copyWith(
                                      //           fontSize: 20,
                                      //           fontWeight: FontWeight.w600,
                                      //           color: Colors.grey),
                                      // ),
                                      const Spacer(),
                                      Icon(
                                        Icons.settings,
                                        size: 36,
                                        color: Colors.grey.withOpacity(.8),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(.6),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Settings_Item_builder(
                                    context: context,
                                    onPressed: () {},
                                    text: 'Edit Profile',
                                    icon: Icons.keyboard_arrow_right_outlined),
                                Settings_Item_builder(
                                    context: context,
                                    onPressed: () {},
                                    text: 'Change Password',
                                    icon: Icons.keyboard_arrow_right_outlined),
                                Settings_Item_builder(
                                    context: context,
                                    onPressed: () {},
                                    text: 'Change Language',
                                    icon: Icons.language),
                                Settings_Item_builder(
                                    context: context,
                                    onPressed: () {
                                      My_NavigatTo(
                                        context: context,
                                        type: PageTransitionType.rightToLeft,
                                        nextPage: const Privacy_Policy_Screen(),
                                      );
                                    },
                                    text: 'Privacy Policy',
                                    icon: Icons.keyboard_arrow_right_outlined),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                    vertical: 15,
                                  ),
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Push Notifications',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          const Spacer(),
                                          Switch(
                                              splashRadius: 2,
                                              activeColor: Colors.white,
                                              activeTrackColor: AppColor,
                                              value: true,
                                              onChanged: (value) {}),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Settings_Item_builder(
                                    context: context,
                                    onPressed: () {
                                      cubit(context).logout(context);
                                    },
                                    text: 'Log out',
                                    icon: Icons.logout),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Padding Settings_Item_builder({
    required BuildContext context,
    required Function onPressed,
    required String text,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 15,
      ),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Spacer(),
                Icon(
                  icon,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
