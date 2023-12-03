import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../../shared/styels/colors.dart';

class New_Announcement_Screen extends StatelessWidget {
  var title_controller = TextEditingController();
  var description_controller = TextEditingController();
  var Form_Key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {
        if (state is Coordinator_Add_Announcement_Success_State) {
          cubit(context).isLoading_();
          Navigator.pop(context);
          cubit(context).Selected_departments.clear();
          cubit(context).Selected_Years.clear();
          My_Toast_Message(msg: 'Announcement Added Successfully');
        } else if (state is Coordinator_Add_Announcement_Error_State) {
          My_Toast_Message(msg: state.error);
          cubit(context).isLoading_();
        }
      },
      builder: (context, state) => Scaffold(
        body: Stack(
          children: [
            Form(
              key: Form_Key,
              child: Stack(
                children: [
                  My_TopStack(
                    context: context,
                    isMenu: false,
                  ),
                  My_UnderPage(context: context, column: [
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: My_Text(
                              context: context,
                              text: 'New Announcement',
                              fontSize: 20,
                            ),
                          ),
                          Image.asset('assets/images/Vector.png'),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                      ),
                      child: Divider(),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // Card(
                        //   elevation: 5,
                        //   color: Colors.white,
                        //   child: Container(
                        //     padding: const EdgeInsetsDirectional.symmetric(
                        //       horizontal: 10,
                        //       vertical: 2,
                        //     ),
                        //     child: DropdownButtonHideUnderline(
                        //       child: DropdownButton(
                        //           hint: const Text('Choose The Department'),
                        //           isExpanded: true,
                        //           value: cubit(context).department,
                        //           dropdownColor: Colors.white,
                        //           iconSize: 32,
                        //           iconEnabledColor: Colors.black,
                        //           items: cubit(context).departments,
                        //           onChanged: (value) {
                        //             cubit(context).Choose_department(value);
                        //           }),
                        //     ),
                        //   ),
                        // ),
                        MultiSelectDialogField(
                          title: const Text('Departments'),
                          buttonText: const Text(
                            'Choose the departments',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 25,
                          ),
                          items: cubit(context).departments,
                          listType: MultiSelectListType.CHIP,
                          backgroundColor: Colors.white,
                          unselectedColor: Colors.white,
                          selectedColor: AppColor,
                          selectedItemsTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          onConfirm: (values) {
                            cubit(context).Choose_department(values);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MultiSelectDialogField(
                          title: const Text('Years'),
                          buttonText: const Text(
                            'Choose the years',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 25,
                          ),
                          items: cubit(context).years,
                          listType: MultiSelectListType.CHIP,
                          backgroundColor: Colors.white,
                          unselectedColor: Colors.white,
                          selectedColor: AppColor,
                          selectedItemsTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          onConfirm: (values) {
                            cubit(context).Choose_year(values);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Card(
                        //   elevation: 5,
                        //   color: Colors.white,
                        //   child: Container(
                        //     padding: const EdgeInsetsDirectional.symmetric(
                        //       horizontal: 10,
                        //       vertical: 2,
                        //     ),
                        //     decoration: const BoxDecoration(
                        //       boxShadow: [],
                        //     ),
                        //     child: DropdownButtonHideUnderline(
                        //       child: DropdownButton(
                        //           hint: const Text('Choose The Year'),
                        //           value: cubit(context).year,
                        //           isExpanded: true,
                        //           dropdownColor: Colors.white,
                        //           iconSize: 32,
                        //           iconEnabledColor: Colors.black,
                        //           items: cubit(context).years,
                        //           onChanged: (value) {
                        //             cubit(context).Choose_year(value);
                        //           }),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: AppColor,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            //        color: Colors.red,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Title:  ',
                                style: TextStyle(
                                  fontSize: 22.5,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: title_controller,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return My_Toast_Message(
                                          msg: 'Title must not be empty');
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '............................',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: height(context) / 2.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColor,
                              width: 1,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/Rectangle 86.png',
                              ),
                              Column(
                                children: [
                                  Container(
                                    color: Colors.red,
                                  ),
                                  TextFormField(
                                    controller: description_controller,
                                    keyboardType: TextInputType.text,
                                    maxLines: null,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return My_Toast_Message(
                                            msg:
                                                'Announcement content must not be empty');
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Announcement\'s content',
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        if (Form_Key.currentState!.validate() &&
                            cubit(context).Selected_departments.isNotEmpty &&
                            cubit(context).Selected_Years.isNotEmpty) {
                          cubit(context).Add_Announcement(
                            title: title_controller.text,
                            description: description_controller.text,
                          );
                        }
                      },
                      child: Container(
                        height: height(context) / 15.5,
                        decoration: BoxDecoration(
                          gradient: GradientColor(),
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(20),
                            bottomStart: Radius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            if (cubit(context).isLoading) My_Loading_Shape(),
          ],
        ),
      ),
    );
  }
}
