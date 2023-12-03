import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../shared/components/components.dart';
import '../menu_screen.dart';

class New_Messages_Screen extends StatelessWidget {
  var Message_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          My_TopStack(context: context, isMenu: true),
          backgroundBottom(context),
        ],
      ),
    );
  }

  Align backgroundTop(context) => Align(
        alignment: AlignmentDirectional.topCenter,
        child: Container(
          height: height(context) / 3,
          decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(25),
              bottomStart: Radius.circular(25),
            ),
            gradient: GradientColor(),
            boxShadow: const [
              BoxShadow(
                blurRadius: 12.5,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      );

  Widget backgroundBottom(context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 10,
          end: 10,
          top: 215,
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(30),
              topEnd: Radius.circular(30),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black26,
              ),
            ],
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' New Message',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      'Contacts',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColor,
                        )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          // TODO: Contacts
                          //value: 'Dr.',
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          iconSize: 32,
                          iconEnabledColor: Colors.black,
                          items: const [
                            DropdownMenuItem(
                                value: '1', child: Text('Dr.Kris')),
                            DropdownMenuItem(value: '1', child: Text('Dr.Bel')),
                            DropdownMenuItem(
                                value: '1', child: Text('Dr.Turk')),
                            DropdownMenuItem(
                                value: '1', child: Text('Dr.Ahme')),
                          ],
                          onChanged: (value) {}),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 20,
                      bottom: 10,
                    ),
                    child: Text(
                      'Message',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  // TODO: Messsage
                  Container(
                    height: 200,
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColor,
                        )),
                    child: TextFormField(
                      controller: Message_Controller,
                      keyboardType: TextInputType.text,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Write your message here............',
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black38),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          // TODO: Upload a form
                        },
                        child: Container(
                          height: 50,
                          width: width(context) / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: HexColor('#09B3AD'),
                                width: 2,
                              )),
                          child: const Center(
                              child: Text(
                            'Upload a form',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          // TODO: Send
                        },
                        child: Container(
                          height: 50,
                          width: width(context) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: GradientColor(),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Send',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.send_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding MessageItem(
      {required BuildContext context,
      IconData icon = Icons.mail_outlined,
      required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 7.5,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 35,
          width: width(context),
          child: Row(
            children: [
              Icon(
                icon,
                color: HexColor('#1C1B1F').withOpacity(.5),
                size: 26,
              ),
              const SizedBox(
                width: 7.5,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14,
                      color: HexColor('#1C1B1F').withOpacity(.5),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
