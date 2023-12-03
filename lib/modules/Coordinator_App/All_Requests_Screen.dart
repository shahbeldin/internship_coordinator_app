import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';

class All_Requests_Screen extends StatelessWidget {
  const All_Requests_Screen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child:
                      My_Title(context: context, text: 'Internships Requests'),
                ),
                if (state is Coordinator_Get_Coordinator_All_Data_Loding_State)
                  Expanded(
                    child: My_Circular_Loading(),
                  ),
                if (state is! Coordinator_Get_Coordinator_All_Data_Loding_State)
                  ConditionalBuilder(
                      condition: cubit(context).practises.isNotEmpty,
                      builder: (context) => Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => internshipItem(
                                context: context,
                                model: cubit(context).practises[index],
                                index: index,
                              ),
                              itemCount: cubit(context).practises.length,
                            ),
                          ),
                      fallback: (context) =>
                          My_Emptytitle(text: 'There are No Practices')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
