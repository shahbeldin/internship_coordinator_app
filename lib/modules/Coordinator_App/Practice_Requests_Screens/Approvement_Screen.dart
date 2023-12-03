//import 'dart:wasm';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/models/Coordinator_All_Data_Model.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class Approvement_Screen extends StatelessWidget {
  var Scaffold_key = GlobalKey<ScaffoldState>();
  var Reject_Message_Controller = TextEditingController();
  var Form_Key = GlobalKey<FormState>();
  PractiseSubmissions Student_Information;
  String pracitceTitle;
  Approvement_Screen({
    required this.Student_Information,
    required this.pracitceTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {
        if (state is Coordinator_Download_File_Success_State) {
          cubit(context).isLoading_();
        }
        if (state
            is Coordinator_Approve_Or_Reject_Student_Request_Success_State) {
          cubit(context).isLoading_();
          if (state.isApprove) {
            My_Toast_Message(msg: 'The Student Approved');
          } else {
            Navigator.pop(context);
            My_Toast_Message(msg: 'The Student Rejected');
          }
          if (cubit(context).coordinator_all_data_model != null) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        } else if (state
            is Coordinator_Approve_Or_Reject_Student_Request_Error_State) {
          My_Toast_Message(msg: state.error);
        }
      },
      builder: (context, state) => Scaffold(
        key: Scaffold_key,
        body: Stack(
          children: [
            Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: SafeArea(
                    child: Row(
                      children: [
                        My_BackButton(context: context),
                        const Spacer(),
                        My_NotificationButton(
                          context: context,
                        ),
                        My_ProfileButton(
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ),
                My_Title(
                  context: context,
                  text: 'Approvement',
                  fontSize: 22,
                ),
                const Spacer(),
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 59,
                        ),
                        Container(
                          height: height(context) / 1.31,
                          width: width(context),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(30),
                              topEnd: Radius.circular(30),
                            ),
                            color: HexColor('#D9D9D9').withOpacity(.2),
                            // boxShadow: const [
                            //   BoxShadow(
                            //     blurRadius: 5,
                            //     color: Colors.black26,
                            //   ),
                            // ],
                          ),
                          child: Container(
                            height: height(context) / 1.35,
                            width: width(context),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(30),
                                topEnd: Radius.circular(30),
                              ),
                              color: HexColor('#D9D9D9').withOpacity(.2),
                            ),
                            child: PageInfo(
                              context: context,
                              model: Student_Information,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 59,
                      backgroundColor: AppColor,
                      child: CircleAvatar(
                        radius: 57,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(Student_Information
                                    .studentProfile !=
                                ''
                            ? cubit(context).Media_URL(
                                url: Student_Information.studentProfile!,
                              )
                            : 'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (state is Coordinator_Download_File_Loding_State ||
                state
                    is Coordinator_Approve_Or_Reject_Student_Request_Loding_State)
              My_Loading_Shape(),
            // if (state is Coordinator_Download_File_Loding_State)
            //   My_Circular_Loading(),
          ],
        ),
      ),
    );
  }

//! The Page Information
  Widget PageInfo({
    required BuildContext context,
    required PractiseSubmissions model,
  }) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 10,
          end: 10,
          bottom: 15,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),

            Text(
              model.studentFirstName != ''
                  ? '${model.studentFirstName} ${model.studentLastName}'
                  : 'Studnet name',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
            ),
            // TODO: Student mail
            Text(
              model.studentEmail != ''
                  ? '${model.studentEmail}'
                  : 'studentemail@uskudar.st.edu.tr',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    //fontWeight: FontWeight.w500,

                    color: Colors.black45,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            Stu_Info(
              context: context,
              title: 'Practice name',
              info: pracitceTitle,
            ),
            Stu_Info(
              context: context,
              title: 'Instructor name',
              info: 'Dr.${cubit(context).coordinator_all_data_model!.name!}',
            ),
            Row(
              children: [
                Expanded(
                  child: Stu_Info(
                    context: context,
                    title: 'International',
                    info: '${model.istInternational! ? 'Yes' : 'No'}',
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Stu_Info(
                    context: context,
                    title: 'Date',
                    info: model.added!.split('T').first,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                if (model.istInternational!)
                  Expanded(
                    child: GrandiantButton(
                        context: context,
                        text: 'Company History',
                        onTap: () {
                          if (model.companyHistory != null) {
                            cubit(context).DownloadFile(
                                url: cubit(context).Media_URL(
                              url: model.companyHistory!,
                              isFile: true,
                            ));
                          } else {
                            My_Toast_Message(
                              msg: "Error",
                              isError: true,
                            );
                          }
                        }),
                  ),
                if (model.istInternational!)
                  const SizedBox(
                    width: 20,
                  ),
                Expanded(
                  child: GrandiantButton(
                      context: context,
                      text: 'Transcript',
                      onTap: () {
                        if (model.transcriptFile != null) {
                          cubit(context).DownloadFile(
                              url: cubit(context).Media_URL(
                            url: model.transcriptFile!,
                            isFile: true,
                          ));
                        } else {
                          My_Toast_Message(
                            msg: "Error",
                            isError: true,
                          );
                        }
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 12.5,
            ),
            Row(
              children: [
                Expanded(
                  child: GrandiantButton(
                      context: context,
                      text: 'Student Form',
                      onTap: () {
                        if (model.uploadedForm != null) {
                          cubit(context).DownloadFile(
                              url: cubit(context).Media_URL(
                            url: model.uploadedForm!,
                            isFile: true,
                          ));
                        } else {
                          My_Toast_Message(
                            msg: "Error",
                            isError: true,
                          );
                        }
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 12.5,
            ),
            Row(
              children: [
                Expanded(
                    child: Approve_Reje_Button(
                  context: context,
                  isApprove: false,
                  onTap: () {
                    Scaffold_key.currentState!
                        .showBottomSheet((context) => Reject_Buttom_Sheet(
                              context: context,
                              id: model.id!,
                            ));
                  },
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Approve_Reje_Button(
                    context: context,
                    isApprove: true,
                    onTap: () {
                      cubit(context).Approve_Or_Reject_Student(
                        UserId: model.id!,
                        isApprove: true,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BlocConsumer Reject_Buttom_Sheet({
    required BuildContext context,
    required int id,
  }) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {},
      builder: (context, state) => Container(
        height: height(context) / 1.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: Form(
          key: Form_Key,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(
                  start: 15,
                ),
                height: height(context) / 13,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(20),
                    topStart: Radius.circular(20),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: My_Text(
                    context: context,
                    text: 'Reason of Rejection',
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Image.asset(
                          'assets/images/reject.png',
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: Reject_Message_Controller,
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return My_Toast_Message(
                                msg: 'What\'s the reason of rejection?',
                                isError: true,
                              );
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write your message here......',
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (Form_Key.currentState!.validate()) {
                    cubit(context).Approve_Or_Reject_Student(
                      isApprove: false,
                      UserId: id,
                      Rejected_Message: Reject_Message_Controller.text,
                    );
                  }
                },
                child: Container(
                  height: height(context) / 14,
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                  ),
                  child: ConditionalBuilder(
                    condition: state
                        is! Coordinator_Approve_Or_Reject_Student_Request_Loding_State,
                    builder: (context) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          My_Text(
                            context: context,
                            text: 'Send message',
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            'assets/images/send.png',
                          ),
                        ]),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
