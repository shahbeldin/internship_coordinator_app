import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

Color AppColor = HexColor('#09B3AD');

LinearGradient GradientColor() => LinearGradient(
      colors: [
        HexColor('#37ECBA'),
        HexColor('#72AFD3'),
      ],
    );

Color RedColor = HexColor('#CB1717').withOpacity(.76);

Color GreyColor = HexColor('#D9D9D9').withOpacity(.35);
