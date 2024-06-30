import 'package:cluster_passport/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/features/user/presentation/pages/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(child: Text(S.of(context).WtoCP, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tabColor),),),
            Image.asset("assets/bg_image.png"),
            Column(
              children: [
                Text(S.of(context).ROPP, textAlign: TextAlign.center,style: const TextStyle(fontSize: 15),),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginPage()));
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tabColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(S.of(context).AC, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

