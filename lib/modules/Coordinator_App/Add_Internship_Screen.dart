import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../../shared/styels/colors.dart';

class AddInternship_Screen extends StatelessWidget {
  var title_controller = TextEditingController();
  var description_controller = TextEditingController();
  var Form_Key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
        listener: (context, state) {
          if (state is Coordinator_Add_Internship_Success_State) {
            title_controller.text = "";
            description_controller.text = "";
            cubit(context).Selected_departments.clear();
            cubit(context).Selected_Years.clear();
            cubit(context).isLoading_();
            My_Toast_Message(msg: 'A new internship added successfully');
          } else if (state is Coordinator_Add_Internship_Error_State) {
            My_Toast_Message(
              msg: state.error,
              isError: true,
            );
          }
        },
        builder: (context, state) => Scaffold(
              body: Stack(
                children: [
                  Form(
                    key: Form_Key,
                    child: Column(
                      children: [
                        appBar(context: context, text: 'Add Internship'),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 20,
                                horizontal: 12.5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'The title of the internship',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                      vertical: 0,
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColor,
                                        )),
                                    child: TextFormField(
                                      controller: title_controller,
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return My_Toast_Message(
                                            msg: 'Title must not be empty',
                                            isError: true,
                                          );
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'The Description of the internship',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    //  height: 200,
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                      vertical: 0,
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColor,
                                        )),
                                    child: TextFormField(
                                      controller: description_controller,
                                      keyboardType: TextInputType.text,
                                      maxLines: null,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return My_Toast_Message(
                                              msg:
                                                  'Internship description must not be empty');
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        //   hintText: '......',
                                        //   hintText: 'Write the description.....',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MultiSelectDialogField(
                                    title: const Text('Departments'),
                                    buttonText: const Text(
                                      'Departments',
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
                                      'Years',
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
                                    height: 25,
                                  ),
                                  My_Button(
                                      context: context,
                                      onPressed: () {
                                        if (Form_Key.currentState!.validate() &&
                                            cubit(context)
                                                .Selected_departments
                                                .isNotEmpty &&
                                            cubit(context)
                                                .Selected_Years
                                                .isNotEmpty) {
                                          cubit(context).Add_Internship(
                                            title: title_controller.text,
                                            description:
                                                description_controller.text,
                                          );
                                        }
                                      },
                                      text: 'Add Internship'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (cubit(context).isLoading) My_Loading_Shape(),
                ],
              ),
            ));
  }
}
