import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../layout/cubit/coordinator_cubit.dart';

class Profile_Screen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
              key: scaffoldKey,
              body: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              children: [
                                Container(
                                  width: width(context),
                                  height: height(context) / 3.5,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                      bottomStart: Radius.circular(60),
                                      bottomEnd: Radius.circular(60),
                                    ),
                                    gradient: GradientColor(),
                                  ),
                                ),
                                SafeArea(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                          top: 7.5,
                                          start: 7.5,
                                          end: 7.5,
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                              size: 32.5,
                                            )),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                          top: 7.5,
                                          start: 7.5,
                                          end: 7.5,
                                        ),
                                        child: My_NotificationButton(
                                          context: context,
                                          isAppColor: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      top: height(context) / 40,
                                    ),
                                    child: Image.asset(
                                      'assets/images/Frame 25.png',
                                      height: 150,
                                      width: 150,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                            width: double.infinity,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          cubit(context)
                                      .coordinator_all_data_model!
                                      .profilePic! !=
                                  ""
                              ? cubit(context).Media_URL(
                                  url: cubit(context)
                                      .coordinator_all_data_model!
                                      .profilePic!,
                                )
                              : 'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg',
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 7.5,
                      ),
                      child: Column(
                        children: [
                          Text(
                            cubit(context).coordinator_all_data_model!.name! !=
                                    ''
                                ? 'Dr.${cubit(context).coordinator_all_data_model!.name!}'
                                : 'Coordinator name',
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 24,
                                    ),
                          ),
                          Text(
                            cubit(context).coordinator_all_data_model!.email! !=
                                    ''
                                ? cubit(context)
                                    .coordinator_all_data_model!
                                    .email!
                                : 'coordinatormail@uskudar.edu.tr',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: GreyColor,
                                  borderRadius:
                                      const BorderRadiusDirectional.only(
                                    topStart: Radius.circular(10),
                                    topEnd: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Profile_Builder(
                                      iconName: 'mail',
                                      title: 'Email',
                                      contenct: cubit(context)
                                          .coordinator_all_data_model!
                                          .email!,
                                    ),
                                    Profile_Builder(
                                      iconName: 'cellphone',
                                      title: 'Phone',
                                      contenct: '+9055330000000',
                                    ),
                                    Profile_Builder(
                                      iconName: 'location',
                                      title: 'Address',
                                      contenct: 'Istanbul/Uskudar',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  Padding Profile_Builder({
    required String iconName,
    required String title,
    required String contenct,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 5,
      ),
      child: SizedBox(
        height: 65,
        width: double.infinity,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset('assets/images/$iconName.png'),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    contenct,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  BuildContext context;
  CustomClip(
    this.context,
  );
  @override
  Path getClip(Size size) {
    double radius = 100;

    Path path = Path();
    path
      ..moveTo(size.width / 2, 0)
      ..arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(radius))
      ..lineTo(0, size.height)
      ..arcToPoint(
        Offset(size.width / 2, 0),
        radius: Radius.circular(radius),
      )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
