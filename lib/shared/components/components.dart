import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/models/Coordinator_All_Data_Model.dart';
import 'package:coordinator_app/models/Official_Letter_Model.dart';
import 'package:coordinator_app/modules/Coordinator_App/Announcement_Screens.dart/Announcement_Screen.dart';
import 'package:coordinator_app/modules/Coordinator_App/Official_Letter_Screens/Official_Letter_Requests_Screen.dart';
import 'package:coordinator_app/modules/Coordinator_App/Profile_Screen.dart';
import 'package:coordinator_app/shared/remote/network/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

import '../../modules/Coordinator_App/Practice_Requests_Screens/Approvement_Screen.dart';
import '../../modules/Coordinator_App/Practice_Requests_Screens/Practice_Requestes.dart';
import '../../modules/Coordinator_App/main_screen.dart';
import '../styels/colors.dart';

// @override
// Widget build(BuildContext context) {
//   return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
//       listener: (context, state) {}, builder: (context, state) => Scaffold());
// }

double height(context) => MediaQuery.of(context).size.height;

double width(context) => MediaQuery.of(context).size.width;

//! To Navigate With Transition
void My_NavigatTo({
  required context,
  required nextPage,
  PageTransitionType type = PageTransitionType.fade,
  int duration = 250,
  int reverseDuration = 250,
}) =>
    Navigator.of(context).push(PageTransition(
      child: nextPage,
      type: type,
      duration: Duration(
        milliseconds: duration,
      ),
      reverseDuration: Duration(
        milliseconds: reverseDuration,
      ),
    ));

Widget My_HomeIcon(
  context, {
  Color iconColor = Colors.white,
  bool padding = true,
}) =>
    Padding(
      padding: EdgeInsetsDirectional.only(
        top: padding ? 7.5 : 0,
        start: padding ? 7.5 : 0,
        end: padding ? 7.5 : 0,
      ),
      child: IconButton(
          onPressed: () {
            My_NavigatTo(
              context: context,
              nextPage: MainScreen(),
            );
          },
          icon: Icon(
            Icons.home_outlined,
            color: iconColor,
            size: 35,
          )),
    );

IconButton My_ProfileButton({
  required BuildContext context,
}) =>
    IconButton(
        onPressed: () {
          My_NavigatTo(
            context: context,
            type: PageTransitionType.rightToLeft,
            nextPage: Profile_Screen(),
          );
        },
        icon: Icon(
          Icons.person_outline,
          color: AppColor,
          size: 32.5,
        ));

Builder My_Drawer() => Builder(
      builder: (context) => IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: AppColor,
            size: 34,
          )),
    );

IconButton My_BackButton({
  required BuildContext context,
  bool isAppColor = true,
}) =>
    IconButton(
        onPressed: () {
          Navigator.pop(context);
          cubit(context).Picked_File = null;
        },
        icon: Icon(
          Icons.arrow_back,
          color: isAppColor ? AppColor : Colors.white,
          size: 32.5,
        ));

//! Stack of the top of the screens (Gradient Colors).
SizedBox My_TopStack({
  required BuildContext context,
  required bool isMenu,
  bool logo = true,
  bool is_Settings_Screen = false,
}) =>
    SizedBox(
      height: height(context) / 3,
      width: double.infinity,
      child: Stack(
        children: [
          Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Container(
                  //height: height(context) / 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(30),
                      bottomStart: Radius.circular(30),
                    ),
                    gradient: GradientColor(),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 12.5,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SafeArea(
                    child: Row(
                      children: [
                        // if (isMenu)
                        //   Padding(
                        //     padding: const EdgeInsetsDirectional.only(
                        //       top: 7.5,
                        //       start: 7.5,
                        //       end: 7.5,
                        //     ),
                        //     child: Builder(builder: (context) {
                        //       return IconButton(
                        //           onPressed: () {
                        //             Scaffold.of(context).openDrawer();
                        //           },
                        //           icon: const Icon(
                        //             Icons.menu,
                        //             color: Colors.white,
                        //           ));
                        //     }),
                        //   ),
                        // if (!isMenu)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 7.5,
                            start: 7.5,
                            end: 7.5,
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 32.5,
                              )),
                        ),
                        if (isMenu) const Spacer(),
                        if (isMenu) My_HomeIcon(context),
                      ],
                    ),
                  ),
                  if (is_Settings_Screen)
                    const SizedBox(
                      height: 10,
                    ),
                  if (is_Settings_Screen)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.settings,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          if (logo)
            SafeArea(
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: width(context) / 6,
                  ),
                  child: Image.asset(
                    'assets/images/Frame 25.png',
                    height: height(context) / 5.6,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

Widget My_UnderPage({
  required BuildContext context,
  required List<Widget> column,
}) =>
    Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 10,
          end: 10,
        ),
        child: Container(
          height: height(context) / 1.35,
          clipBehavior: Clip.antiAliasWithSaveLayer,
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
                horizontal: 15,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: column,
              ),
            ),
          ),
        ),
      ),
    );

// ignore: non_constant_identifier_names
Padding My_StudentBuilder({
  required BuildContext context,
  required PractiseSubmissions model,
  required String pracitceTitle,
}) {
  return Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      vertical: 10,
    ),
    child: InkWell(
      onTap: () {
        My_NavigatTo(
          context: context,
          nextPage: Approvement_Screen(
            Student_Information: model,
            pracitceTitle: pracitceTitle,
          ),
          type: PageTransitionType.rightToLeft,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12.5),
        height: 115,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColor,
            width: 1.3,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(
                model.studentProfile != ""
                    ? cubit(context).Media_URL(
                        url: model.studentProfile!,
                      )
                    : 'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg',
              ),
            ),
            const SizedBox(
              width: 7.5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.studentFirstName != ''
                        ? '${model.studentFirstName} ${model.studentLastName}'
                        : 'Student name',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    model.studentEmail != ''
                        ? '${model.studentEmail}'
                        : 'studentemail.email@uskudar.st.edu.tr',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                  Text(
                    '${model.studentDepartment!.name}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

SliverAppBar My_SliverAppBar({
  required BuildContext context,
  bool HomeButton = true,
}) =>
    SliverAppBar(
      floating: true,
      snap: true,
      actions: [
        if (HomeButton)
          My_HomeIcon(context, iconColor: AppColor, padding: false),
        My_ProfileButton(
          context: context,
        ),
      ],
      leading: My_BackButton(context: context),
    );

Widget My_NotificationButton({
  required BuildContext context,
  bool isAppColor = true,
}) =>
    Badge.count(
      alignment: const AlignmentDirectional(30, 10),
      count: cubit(context).Announcements.length,
      isLabelVisible: cubit(context).Announcements.isEmpty ? false : true,
      backgroundColor: HexColor('#CB1717').withOpacity(.8),
      child: IconButton(
          padding: const EdgeInsets.all(10),
          onPressed: () {
            My_NavigatTo(
              context: context,
              nextPage: Announcements_Screen(
                isNotification: true,
              ),
              type: PageTransitionType.rightToLeft,
            );
          },
          icon: Icon(
            Icons.notifications_outlined,
            color: isAppColor ? AppColor : Colors.white,
            size: 32.5,
          )),
    );

Center My_Title({
  required BuildContext context,
  required String text,
  double fontSize = 25,
  Color color = Colors.black,
}) =>
    Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
      ),
    );

Text My_Text({
  required BuildContext context,
  required String text,
  double fontSize = 25,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.w500,
  bool maxLines = true,
}) =>
    Text(
      text,
      maxLines: maxLines ? 1 : null,
      overflow: maxLines ? TextOverflow.ellipsis : null,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color,
          ),
    );

Column appBar({
  required BuildContext context,
  required String text,
}) =>
    Column(
      children: [
        Stack(
          children: [
            Container(
              height: height(context) / 7,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(20),
                  bottomStart: Radius.circular(20),
                ),
                gradient: GradientColor(),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: height(context) / 6.5 / 6,
                ),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: My_Text(
                    context: context,
                    text: text,
                    color: Colors.white,
                    fontSize: 27,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Row(
                children: [
                  My_BackButton(
                    context: context,
                    isAppColor: false,
                  ),
                  // const Spacer(),
                  // My_HomeIcon(
                  //   context,
                  //   padding: false,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ],
    );

Widget My_Button({
  required BuildContext context,
  required Function onPressed,
  required String text,
}) =>
    MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onPressed();
      },
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: GradientColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontSize: 22,
              ),
        )),
      ),
    );

Coordinator_Cubit cubit(context) => Coordinator_Cubit.get(context);

Padding My_Liner_Loading() => Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 5,
      ),
      child: LinearProgressIndicator(
        color: AppColor,
      ),
    );

Center My_Circular_Loading() => Center(
      child: CircularProgressIndicator(
        color: AppColor,
        strokeWidth: 4.5,
      ),
    );

Widget My_Emptytitle({
  required String text,
}) =>
    Expanded(
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
      ),
    );

// This for the parctice item
Padding internshipItem({
  required BuildContext context,
  required Practises model,
  required int index,
}) {
  List<int> status_ = [];
  model.practiseSubmissions!.forEach((e) {
    if (e.status == 0) {
      status_.add(0);
    }
  });
  print(status_.length);
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      bottom: 8,
    ),
    child: SizedBox(
      height: 130,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          InkWell(
            onTap: () {
              if (status_.isNotEmpty) {
                My_NavigatTo(
                  context: context,
                  type: PageTransitionType.rightToLeft,
                  nextPage: Practice_Requestes_Screen(
                    Students_Requests: model.practiseSubmissions!,
                    internshipTitle: model.title!,
                    practiceID: model.id!,
                  ),
                );
              } else {
                My_Toast_Message(
                  msg: "There are no requests",
                  isError: true,
                );
              }
            },
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              height: 120,
              width: width(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: GradientColor(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      model.title!,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
                    ),
                  ),
                  Expanded(child: Image.asset('assets/images/Frame 53.png')),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          if (status_.isNotEmpty)
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 7.5,
              ),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: AnimatedContainer(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 7.5,
                    vertical: 5,
                  ),
                  duration: const Duration(
                    seconds: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: HexColor('#CB1717').withOpacity(.8),
                  ),
                  child: Text(
                    '${status_.length > 999 ? '999+' : status_.length}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
My_Toast_Message({
  required String msg,
  bool isError = false,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
    );

Widget My_Loading_Shape() => Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(.5),
      child: My_Circular_Loading(),
    );

Container loadingPage(BuildContext context) => Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(.5),
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );

Padding Offical_Letter_Item({
  required BuildContext context,
}) {
  List<int> status_ = [];
  cubit(context).Offical_Letter_Reqs.forEach((e) {
    if (e.status == 0) {
      status_.add(0);
    }
  });
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      bottom: 8,
    ),
    child: SizedBox(
      height: 130,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          InkWell(
            onTap: () {
              if (status_.isNotEmpty) {
                My_NavigatTo(
                    context: context,
                    type: PageTransitionType.rightToLeft,
                    nextPage: Official_Letter_Requestes_Screen());
              } else {
                My_Toast_Message(
                  msg: "There are no requests",
                  isError: true,
                );
              }
            },
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              height: 120,
              width: width(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: GradientColor(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Official Letters',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
                    ),
                  ),
                  Expanded(child: Image.asset('assets/images/Frame 53.png')),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          if (status_.isNotEmpty)
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 7.5,
              ),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: AnimatedContainer(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 7.5,
                    vertical: 5,
                  ),
                  duration: const Duration(
                    seconds: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: HexColor('#CB1717').withOpacity(.8),
                  ),
                  child: Text(
                    '${status_.length > 999 ? '999+' : status_.length}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

InkWell Approve_Reje_Button({
  required BuildContext context,
  required bool isApprove,
  required Function onTap,
}) {
  return InkWell(
    onTap: () => onTap(),
    child: Container(
      height: 56,
      width: width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isApprove ? Colors.white : RedColor,
        border: Border.all(
          color: isApprove ? HexColor('#67DA74') : RedColor,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          isApprove ? 'Approve' : 'Reject',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: isApprove ? HexColor('#67DA74') : Colors.white,
              ),
        ),
      ),
    ),
  );
}

InkWell GrandiantButton({
  required BuildContext context,
  required String text,
  required Function onTap,
}) {
  return InkWell(
    onTap: () => onTap(),
    child: Container(
      height: 60,
      width: width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColor,
          width: 1.5,
        ),
        gradient: GradientColor(),
      ),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
        ),
      ),
    ),
  );
}

Padding Stu_Info({
  required BuildContext context,
  required String title,
  required String info,
}) {
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      bottom: 12.5,
    ),
    child: Container(
      height: 73,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor,
          width: 1.5,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black26,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title:',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black.withOpacity(.6),
                    fontSize: 17,
                  ),
            ),
            Text(
              '$info',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
    ),
  );
}
