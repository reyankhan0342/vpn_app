import 'package:flutter/widgets.dart';
import 'package:vpn_basic_project/main.dart';

class CustomRoundShap extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final Widget iconFile;
  const CustomRoundShap(
      {super.key,
      required this.iconFile,
      required this.titleText,
      required this.subTitleText});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * .46,
      child: Column(
        children: [
          iconFile,
          SizedBox(
            height: 7,
          ),
          Text(
            ' ${titleText}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            ' ${subTitleText}',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
