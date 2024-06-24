import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vrit_task/view_model/utils/export_utils.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(
                MyImages.logo,
                height: 40,
                width: 40,
              )),
          const SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 1,
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
