import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/models/Coordinator_All_Data_Model.dart';
import 'package:coordinator_app/modules/Coordinator_App/Profile_Screen.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Messages_Screen extends StatelessWidget {
  var Message_Controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Chats model;

  Messages_Screen({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {
        if (state is Coordinator_Post_Message_Success_State) {
          Navigator.pop(context);
          My_Toast_Message(msg: 'Message Sent successfully');
        } else if (state is Coordinator_Post_Message_Error_State) {
          My_Toast_Message(
            msg: state.error,
            isError: true,
          );
        }
      },
      builder: (context, state) => Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    appBar(context: context, text: ''),
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 37,
                            backgroundImage: NetworkImage(
                              model.firstParticipant!.profilePic != null
                                  ? '${model.firstParticipant!.profilePic}'
                                  : 'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 90,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                My_Text(
                                  context: context,
                                  text: model.firstParticipant!.firstName != ''
                                      ? model.firstParticipant!.firstName
                                      : model.firstParticipant!.username,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                if (model.firstParticipant!.lastName != '')
                                  My_Text(
                                    context: context,
                                    text: model.firstParticipant!.lastName,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit(context).chats.isNotEmpty,
                    builder: (context) => ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (model.messages![index].sender ==
                            model.firstParticipant!.username) {
                          return Receiver_Message(
                            model: model.messages![index],
                          );
                        } else {
                          return Sender_Message(
                            model: model.messages![index],
                          );
                        }
                      },
                      itemCount: model.messages!.length,
                    ),
                    fallback: (context) => const Text('There are no chats'),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 15,
                      start: 20,
                      end: 20,
                    ),
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColor,
                        ),
                      ),
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              controller: Message_Controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return My_Toast_Message(
                                    msg: 'Type your message',
                                    isError: true,
                                  );
                                }
                                return null;
                              },
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: "Type your message",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit(context).postMessage(
                                  reciever_id: model.firstParticipant!.id!,
                                  message_content: Message_Controller.text,
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              size: 30,
                              color: Colors.grey,
                            )),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            if (state is Coordinator_Post_Message_Loding_State)
              My_Loading_Shape(),
          ],
        ),
      ),
    );
  }

  Align Receiver_Message({
    required Messages model,
  }) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          end: 50,
          start: 10,
          top: 5,
          bottom: 5,
        ),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.3),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomEnd: Radius.circular(10),
              )),
          child: Text(
            model.content,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Align Sender_Message({
    required Messages model,
  }) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          end: 10,
          start: 50,
          top: 5,
          bottom: 5,
        ),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
              color: AppColor.withOpacity(.8),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
              )),
          child: Text(
            model.content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
