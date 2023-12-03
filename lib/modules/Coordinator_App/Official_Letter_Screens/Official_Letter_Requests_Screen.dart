import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/models/Coordinator_All_Data_Model.dart';
import 'package:coordinator_app/models/Official_Letter_Model.dart';
import 'package:coordinator_app/modules/Coordinator_App/Official_Letter_Screens/Official_Letter_Approvement_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styels/colors.dart';

class Official_Letter_Requestes_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cubit(context).Under_Review_Reqs = [];
    cubit(context).Offical_Letter_Reqs.forEach((element) {
      if (element.status == 0) {
        cubit(context).Under_Review_Reqs.add(element);
      }
    });
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
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
                  child: My_Title(
                    context: context,
                    text: 'Official Letters',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ConditionalBuilder(
                  condition: true,
                  builder: (context) => Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          Official_Letter_Student_Request(
                        context: context,
                        model: cubit(context).Under_Review_Reqs[index],
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
      ),
    );
  }

  Padding Official_Letter_Student_Request({
    required BuildContext context,
    required Official_Letter_Model model,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 10,
      ),
      child: InkWell(
        onTap: () {
          My_NavigatTo(
            context: context,
            nextPage: Officical_Letter_Approvement_Screen(
              companyName: model.companyName!,
              internshipName: model.internshipName!,
              id: model.id!,
              transcript_file: model.transcriptFile,
            ),
            type: PageTransitionType.rightToLeft,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12.5),
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColor,
              width: 1.3,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/company.png',
                  height: 100,
                ),
              ),
              const SizedBox(
                width: 7.5,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.companyName!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    Text(
                      "${model.internshipName!}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
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
}
