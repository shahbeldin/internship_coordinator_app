import 'dart:math';

import 'package:coordinator_app/shared/components/components.dart';
import 'package:coordinator_app/shared/styels/colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Privacy_Policy_Screen extends StatelessWidget {
  const Privacy_Policy_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          My_TopStack(
            context: context,
            isMenu: true,
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
                        'Privacy Policy',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                            ),
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        '''
Türkiye’ de kurulu, Saray Mahallesi Site Yolu Sokak Anel İş Merkezi No: 5 Kat: 3, 34768 Ümraniye/İstanbul adresinde mukim, ticaret sicil gazetesine 424015 no ile kayıtlı, 0524016374100063 mersis no’ lu, Anadolu Kurumlar Vergi Dairesi, 5240163741 no’ lu vergi mükellefi, Kariyer.Net Elektronik Yayıncılık ve İletişim Hizmetleri A.Ş. (“Şirket” veya “Platform”) olarak; veri sorumlusu sıfatıyla, ticari ilişkilerimiz kapsamında veya sizlerle olan iş ilişkimiz dahilinde, kişisel verilerinizin, işlenmelerini gerektiren amaç çerçevesinde ve bu amaç ile bağlantılı, sınırlı ve ölçülü şekilde, tarafımıza bildirdiğiniz şekliyle kişisel verilerin doğruluğunu ve en güncel halini koruyarak, kaydedileceğini, depolanacağını, muhafaza edileceğini, yeniden düzenleneceğini, kanunen bu kişisel verileri talep etmeye yetkili olan kurumlar ile paylaşılacağını, yurtiçi veya yurtdışı üçüncü kişilere aktarılacağını, devredileceğini, sınıflandırılabileceğini ve Kişisel Verileri Koruma Kanunu’nda (Bundan sonra “KVKK” olarak anılacaktır) sayılan sair şekillerde işlenebileceğini bildiririz;
Aşağıda belirttiğimiz ve tarafımıza sağladığınız kişisel verilerinizin her koşulda; duruma göre aşağıda belirtilen şekillerde elde ettiğimiz kişisel verilerinizin hukuki ilişkilerimiz kapsamında,
                              ''',
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 17,
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
