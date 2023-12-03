import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/models/Coordinator_All_Data_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styels/colors.dart';

class Practice_Requestes_Screen extends StatelessWidget {
  String internshipTitle;
  List<PractiseSubmissions> Students_Requests;
  int practiceID;

  Practice_Requestes_Screen({
    required this.Students_Requests,
    required this.internshipTitle,
    required this.practiceID,
  });

  @override
  Widget build(BuildContext context) {
    cubit(context).Under_Review_Reqs = [];
    Students_Requests.forEach((element) {
      if (element.status == 0) {
        cubit(context).Under_Review_Reqs.add(element);
      }
    });
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                My_SliverAppBar(
                  context: context,
                  HomeButton: false,
                ),
              ],
              body: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 10,
                  end: 10,
                ),
                child: Column(
                  children: [
                    SafeArea(
                      child: My_Title(context: context, text: internshipTitle),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //! maybe
                    // Align(
                    //   alignment: AlignmentDirectional.topEnd,
                    //   child: InkWell(
                    //     onTap: () {
                    //       // TODO: See All
                    //     },
                    //     child: Container(
                    //       height: 27,
                    //       width: 90,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: [
                    //           Text(
                    //             'See All',
                    //             style: TextStyle(
                    //               color: AppColor,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //           Icon(
                    //             Icons.arrow_forward,
                    //             color: AppColor,
                    //             size: 23,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    ConditionalBuilder(
                      condition: Students_Requests.isNotEmpty,
                      builder: (context) => Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => My_StudentBuilder(
                            context: context,
                            model: cubit(context).Under_Review_Reqs[index],
                            pracitceTitle: internshipTitle,
                          ),
                          itemCount: cubit(context).Under_Review_Reqs.length,
                        ),
                      ),
                      fallback: (context) => const Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            'There are no requests',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
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
        });
  }
}
