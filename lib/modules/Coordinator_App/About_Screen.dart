import 'dart:math';

import 'package:coordinator_app/shared/components/components.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class About_Screen extends StatelessWidget {
  const About_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          My_TopStack(
            context: context,
            isMenu: false,
            logo: false,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 10,
              end: 10,
              top: height(context) / 1.7 / 4,
            ),
            child: Container(
              height: height(context) / 1.15,
              width: width(context),
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
                    vertical: 20,
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'About Program',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                            ),
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      Text(
                        '''
                              
About Our Internship Program:                         
                        ''',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.black54,
                                  fontSize: 18,
                                ),
                      ),
                      const Text(
                        '''
Our internship program is designed to provide students with hands-on experience in the field of marketing. 
Our program offers interns the opportunity to work with a team of experienced professionals and gain practical skills in marketing strategy, content creation, and social media management. We are committed to providing a supportive and engaging learning environment for our interns.
If you have any questions about our program,   


please contact us at: 
                              ''',
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16,
                        ),
                      ),
                      // TODO: Send Email.
                      SelectableText(
                        'internship@marketingcompany.com',
                        style: TextStyle(
                          color: HexColor('#0049B1'),
                          decoration: TextDecoration.underline,
                          decorationColor: HexColor('#0049B1'),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'We look forward to hearing from you!',
                        style: TextStyle(
                          color: AppColor,
                          fontSize: 16,
                          //color: HexColor('#000000').withOpacity(.6)
                          //
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   width: width(context),
          //   height: height(context) / 15 / 4,
          //   //color: Colors.red,
          // ),
        ],
      ),
    );
  }
}
