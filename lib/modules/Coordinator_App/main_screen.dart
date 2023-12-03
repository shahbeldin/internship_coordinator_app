import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/modules/Coordinator_App/menu_screen.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/Coordinator_All_Data_Model.dart';
import '../../shared/remote/network/end_points.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {},
      builder: (context, state) => Stack(
        children: [
          Scaffold(
            drawer: menu(context),
            appBar: AppBar(
              actions: [
                const Spacer(),
                My_NotificationButton(
                  context: context,
                ),
                My_ProfileButton(
                  context: context,
                ),
              ],
              leading: My_Drawer(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(7.5),
                        child: Image.asset('assets/images/Frame 25.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            'Requests',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        if (state
                            is! Coordinator_Get_Coordinator_All_Data_Loding_State)
                          ConditionalBuilder(
                            condition: true,
                            builder: (context) => Expanded(
                              child: Column(
                                children: [
                                  if (cubit(context)
                                          .coordinator_all_data_model !=
                                      null)
                                    Offical_Letter_Item(context: context),
                                  if (cubit(context).practises.isNotEmpty)
                                    internshipItem(
                                      context: context,
                                      model: cubit(context).practises[0],
                                      index: 0,
                                    ),
                                  if (cubit(context).practises.length > 1)
                                    internshipItem(
                                      context: context,
                                      model: cubit(context).practises[1],
                                      index: 1,
                                    ),
                                ],
                              ),
                            ),
                            fallback: (context) => cubit(context)
                                    .practises
                                    .isEmpty
                                ? My_Emptytitle(text: 'There are no practices')
                                : Expanded(
                                    child: My_Circular_Loading(),
                                  ),
                          ),
                        if (state
                            is Coordinator_Get_Coordinator_All_Data_Loding_State)
                          Expanded(
                            child: My_Circular_Loading(),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (cubit(context).coordinator_all_data_model == null)
            My_Loading_Shape(),
        ],
      ),
    );
  }
}



// ListView.builder(
//                                   itemBuilder: (context, index) =>
//                                       internshipItem(
//                                     context: context,
//                                     model: cubit(context).practises[index],
//                                     index: index,
//                                   ),
//                                   itemCount: cubit(context).practises.length,
//                                 ),