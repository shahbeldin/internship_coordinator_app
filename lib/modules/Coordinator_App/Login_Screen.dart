import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/layout/cubit/coordinator_states.dart';
import 'package:coordinator_app/models/Coordinator_All_Data_Model.dart';
import 'package:coordinator_app/modules/Coordinator_App/main_screen.dart';
import 'package:coordinator_app/shared/components/components.dart';
import 'package:coordinator_app/shared/remote/local/cacheHelper.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Login_Screen extends StatelessWidget {
  var userName_Controller = TextEditingController();
  var password_Controller = TextEditingController();
  var email_Controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var formKey_ = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Coordinator_Cubit, Coordinator_States>(
      listener: (context, state) {
        if (state is Coordinator_Login_Success_State) {
          if (cubit(context).rememberMe) {
            CacheHelper.SaveData(
                key: 'token', value: cubit(context).login_model!.authToken);
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
          );
          cubit(context).isLoading_();
          My_Toast_Message(msg: 'Login Successfully');
        } else if (state is Coordinator_Login_Error_State) {
          My_Toast_Message(
            msg: 'Wrong Username or password',
            isError: true,
          );
          cubit(context).isLoading_();
        }
      },
      builder: (context, state) => Scaffold(
        key: scaffoldKey,
        body: Form(
          key: formKey,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/login.png',
                    ),
                  ),
                ),
                child: Container(
                  color: HexColor('#D9D9D9').withOpacity(.6),
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Frame 25.png',
                        height: height(context) / 3.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Container(
                          height: 370,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: HexColor('#FBCD05').withOpacity(.5),
                              borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(20),
                                  topEnd: Radius.circular(300),
                                  bottomStart: Radius.circular(20),
                                  bottomEnd: Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 130,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            color: AppColor,
                                            fontSize: 40,
                                            fontFamily: 'Bellefair',
                                          ),
                                        ),
                                      ),
                                      Image.asset('assets/images/p.png'),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  height: 55,
                                  width: 285,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(colors: [
                                        HexColor('#37ECBA'),
                                        HexColor('#72AFD3'),
                                      ], stops: const [
                                        0,
                                        2,
                                      ])),
                                  child: TextFormField(
                                    controller: userName_Controller,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return My_Toast_Message(
                                          msg: 'Write your Username',
                                          isError: true,
                                        );
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.email_outlined),
                                      prefixIconColor: Colors.black,
                                      hintText: 'Username',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 55,
                                  width: 285,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(colors: [
                                        HexColor('#37ECBA'),
                                        HexColor('#72AFD3'),
                                      ], stops: const [
                                        0,
                                        2,
                                      ])),
                                  child: TextFormField(
                                    controller: password_Controller,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return My_Toast_Message(
                                          msg: 'Write your password',
                                          isError: true,
                                        );
                                      }
                                      return null;
                                    },
                                    obscureText: cubit(context).isSecure,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon:
                                          const Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          cubit(context).Change_isSecure();
                                        },
                                        icon: Icon(
                                          cubit(context).isSecure
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                      prefixIconColor: Colors.black,
                                      hintText: 'Password',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: cubit(context).rememberMe,
                                        activeColor: AppColor,
                                        onChanged: (value) {
                                          cubit(context)
                                              .Change_rememberMe(value!);
                                        }),
                                    const Expanded(
                                      child: Text(
                                        'Remember me',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          //                                          fontFamily: 'Bellefair',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit(context).login(
                                  userName: userName_Controller.text,
                                  password: password_Controller.text);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: width(context) / 2.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              gradient: GradientColor(),
                            ),
                            child: const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                          onPressed: () {
                            scaffoldKey.currentState!
                                .showBottomSheet((context) => Register());
                          },
                          child: const Center(
                            child: Text(
                              'Don\'t have an account? Register Now',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              if (cubit(context).isLoading) My_Loading_Shape(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Register() => BlocConsumer<Coordinator_Cubit, Coordinator_States>(
        listener: (context, state) {
          if (state is Coordinator_Register_Success_State) {
            if (state.statusCode == 400) {
              My_Toast_Message(
                msg: 'Email already exists',
                isError: true,
              );
            } else {
              My_Toast_Message(
                msg: 'You have recived the password in your email',
              );
            }
            Navigator.pop(context);
            cubit(context).isLoading_();
          } else if (state is Coordinator_Register_Error_State) {
            cubit(context).isLoading_();
            My_Toast_Message(
              msg: state.error,
              isError: true,
            );
          }
        },
        builder: (context, state) => Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: HexColor('F5F5F5'),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(20),
              topEnd: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey_,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Registration',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'Bellefair',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(colors: [
                            HexColor('#37ECBA'),
                            HexColor('#72AFD3'),
                          ], stops: const [
                            0,
                            2,
                          ])),
                      child: Center(
                        child: TextFormField(
                          controller: email_Controller,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return My_Toast_Message(
                                msg: 'Write your email',
                                isError: true,
                              );
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock_outline),
                            prefixIconColor: Colors.black,
                            hintText: 'Write your mail',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                        onPressed: () {
                          if (formKey_.currentState!.validate()) {
                            cubit(context)
                                .register(email: email_Controller.text);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: width(context) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            gradient: GradientColor(),
                          ),
                          child: const Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
