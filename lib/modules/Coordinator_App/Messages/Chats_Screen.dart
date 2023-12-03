import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/models/Coordinator_All_Data_Model.dart';
import 'package:coordinator_app/modules/Coordinator_App/Messages/Messages_Screen.dart';
import 'package:coordinator_app/modules/Coordinator_App/Messages/New_Message_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../shared/components/components.dart';
import '../../../shared/styels/colors.dart';
import '../menu_screen.dart';

class Chats_Screen extends StatelessWidget {
  const Chats_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Column(
          children: [
            appBar(context: context, text: 'All Messages'),
            Expanded(
                child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Chat_Item(
                context: context,
                model: cubit(context).chats[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              itemCount: cubit(context).chats.length,
            )),
          ],
        ),
      ),
    );
  }

  Padding Chat_Item({
    required BuildContext context,
    required Chats model,
  }) =>
      Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 15,
        ),
        child: InkWell(
          onTap: () {
            My_NavigatTo(
              context: context,
              nextPage: Messages_Screen(
                model: model,
              ),
              type: PageTransitionType.rightToLeft,
            );
          },
          child: Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GreyColor,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.black12,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(
                        model.firstParticipant!.profilePic != null
                            ? "${model.firstParticipant!.profilePic}"
                            : 'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg',
                      ),
                    ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        My_Text(
                          context: context,
                          text: model.firstParticipant!.firstName != ''
                              ? "${model.firstParticipant!.firstName} ${model.firstParticipant!.lastName}"
                              : '${model.firstParticipant!.username} ${model.firstParticipant!.username}',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        My_Text(
                          context: context,
                          text: model.firstParticipant!.username,
                          fontSize: 17,
                          color: Colors.black.withOpacity(.8),
                        ),
                        My_Text(
                          context: context,
                          text: timeago.format(DateTime.parse(model
                              .messages![model.messages!.length - 1].timestamp
                              .toString())),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
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

  // Align backgroundBottom(context) {
  //   return Align(
  //     alignment: AlignmentDirectional.center,
  //     child: Padding(
  //       padding: const EdgeInsetsDirectional.only(
  //         start: 15,
  //         end: 15,
  //         top: 215,
  //       ),
  //       child: Container(
  //         decoration: const BoxDecoration(
  //           borderRadius: BorderRadiusDirectional.only(
  //             topStart: Radius.circular(30),
  //             topEnd: Radius.circular(30),
  //           ),
  //           color: Colors.white,
  //           boxShadow: [
  //             BoxShadow(
  //               blurRadius: 5,
  //               color: Colors.black26,
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsetsDirectional.symmetric(
  //             horizontal: 10,
  //             vertical: 20,
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 ' My Messages',
  //                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //               ),
  //               const Divider(),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Expanded(
  //                 child: Column(
  //                   children: [
  //                     MessageItem(
  //                       context: context,
  //                       text: 'Incoming Messages',
  //                     ),
  //                     MessageItem(
  //                       context: context,
  //                       text: 'Unread Messages',
  //                     ),
  //                     MessageItem(
  //                       context: context,
  //                       text: 'Outgoing Messages',
  //                       icon: Icons.outgoing_mail,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Center(
  //                   child: InkWell(
  //                     onTap: () {
  //                       My_NavigatTo(
  //                         context: context,
  //                         nextPage: New_Messages_Screen(),
  //                         type: PageTransitionType.rightToLeft,
  //                       );
  //                     },
  //                     child: Container(
  //                       height: 55,
  //                       width: width(context) / 1.8,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(5),
  //                         gradient: GradientColor(),
  //                       ),
  //                       child: const Center(
  //                           child: Text(
  //                         'New Message',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                         ),
  //                       )),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Padding MessageItem(
      {required BuildContext context,
      IconData icon = Icons.mail_outlined,
      required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 7.5,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 35,
          width: width(context),
          child: Row(
            children: [
              Icon(
                icon,
                color: HexColor('#1C1B1F').withOpacity(.5),
                size: 26,
              ),
              const SizedBox(
                width: 7.5,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14,
                      color: HexColor('#1C1B1F').withOpacity(.5),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
