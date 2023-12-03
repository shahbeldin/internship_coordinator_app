//import 'dart:wasm';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/models/Coordinator_All_Data_Model.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:coordinator_app/shared/remote/network/end_points.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class Officical_Letter_Approvement_Screen extends StatelessWidget {
  var Scaffold_key = GlobalKey<ScaffoldState>();
  var Reject_Message_Controller = TextEditingController();
  var Form_Key = GlobalKey<FormState>();
  int id;
  dynamic companyName;
  dynamic internshipName;
  dynamic transcript_file;
  Officical_Letter_Approvement_Screen({
    required this.id,
    required this.companyName,
    required this.internshipName,
    required this.transcript_file,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {
        if (state
            is Coordinator_Approve_Official_Letter_Request_Success_State) {
          Navigator.pop(context);
          Navigator.pop(context);
          cubit(context).isLoading_();
          cubit(context).Picked_File = null;
          My_Toast_Message(
              msg: state.isApprove ? 'Request Approved' : 'Request Rejected');
        }
        if (state is Coordinator_Approve_Official_Letter_Request_Error_State) {
          cubit(context).isLoading_();
          My_Toast_Message(msg: state.error);
        }
        if (state is Coordinator_Download_File_Success_State) {
          cubit(context).isLoading_();
        } else if (state is Coordinator_Download_File_Error_State) {
          cubit(context).isLoading_();
          My_Toast_Message(
            msg: "Error",
            isError: true,
          );
        }
      },
      builder: (context, state) => Stack(
        children: [
          Scaffold(
            key: Scaffold_key,
            appBar: AppBar(
              leading: My_BackButton(context: context),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/company.png',
                    height: 100,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    // '${model.studentLastName} ${model.studentLastName}',
                    "${companyName}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "${internshipName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GrandiantButton(
                    context: context,
                    text: "Transcript File",
                    onTap: () {
                      if (transcript_file != null) {
                        cubit(context).DownloadFile(
                          url: "${transcript_file}",
                        );
                      } else {
                        My_Toast_Message(
                          msg: "Error",
                          isError: true,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () => {cubit(context).GetFile()},
                    child: Container(
                      height: 56,
                      width: width(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: cubit(context).Picked_File == null
                              ? Colors.grey
                              : Colors.green.shade500,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_upload_outlined,
                            color: cubit(context).Picked_File == null
                                ? Colors.grey
                                : Colors.green.shade500,
                            size: 25,
                          ),
                          Text(
                            cubit(context).Picked_File == null
                                ? 'Upload the official letter'
                                : 'Official Letter Uploaded',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: cubit(context).Picked_File == null
                                      ? Colors.grey
                                      : Colors.green.shade500,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Approve_Reje_Button(
                            context: context,
                            isApprove: false,
                            onTap: () {
                              cubit(context).Approve_Rej_Official_Letter(
                                  isApprove: false, Req_Id: id);
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Approve_Reje_Button(
                            context: context,
                            isApprove: true,
                            onTap: () {
                              if (cubit(context).Picked_File != null) {
                                cubit(context).Approve_Rej_Official_Letter(
                                    isApprove: true, Req_Id: id);
                              } else {
                                My_Toast_Message(
                                  msg: 'Upload the offical letter',
                                  isError: true,
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (cubit(context).isLoading) My_Loading_Shape(),
        ],
      ),
    );
  }
}
