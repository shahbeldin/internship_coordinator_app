import 'package:coordinator_app/layout/cubit/coordinator_cubit.dart';
import 'package:coordinator_app/modules/Coordinator_App/main_screen.dart';
import 'package:coordinator_app/shared/components/constants.dart';
import 'package:coordinator_app/shared/remote/local/cacheHelper.dart';
import 'package:coordinator_app/shared/remote/network/DioHelper.dart';
import 'package:coordinator_app/shared/styels/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/BlocObserver.dart';
import 'modules/Coordinator_App/Login_Screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.intial();
  await CacheHelper.intial();

  TOKEN = CacheHelper.GetData(key: 'token');
  Widget startScreen = Login_Screen();
  if (TOKEN != null) {
    startScreen = MainScreen();
  }
  runApp(MyApp(startScreen));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget startScreen;
  MyApp(this.startScreen, {super.key});
  @override
  Widget build(BuildContext context) {
    print('-------------------  Your App Starting  ---------------------');
    return BlocProvider(
      create: (context) => Coordinator_Cubit()..getAllData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startScreen,
        //home: Login_Screen(),
      ),
    );
  }
}
