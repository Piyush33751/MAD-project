import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/infocard.dart';
import 'package:hello_world/model/rive_asset.dart';
import 'package:hello_world/widget/sidemenutile.dart';
import 'package:hello_world/utilities/rive_utils.dart';
import 'package:rive/rive.dart';

class Sidemenu extends StatefulWidget {
  const Sidemenu({super.key});

  @override
  State<Sidemenu> createState() => _SidemenuState();
}

class _SidemenuState extends State<Sidemenu> {
  RiveAsset selectedMenu = sidemenus.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      height: double.infinity,
      color: Colors.blueGrey,
      child: SafeArea(
        child: Column(
          children: [
            const infocard(
              name: "Guest",
              blocknumber: "1",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
              child: Text(
                "Browse".toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white70),
              ),
            ),
            ...sidemenus.map(
              (menu) => sidemenutile(
                menu: menu,
                riveonInit: (artboard) {
                  StateMachineController controller =
                      RiveUtils.getRiveController(artboard,
                          stateMachineName: menu.stateMachineName);
                  menu.input = controller.findSMI("active") as SMIBool;
                },
                press: () {
                  menu.input!.change(true);
                  Future.delayed(const Duration(seconds: 1), () {
                    menu.input!.change(false);
                  });
                  setState(() {
                    selectedMenu = menu;
                  });
                },
                isActive: selectedMenu == menu,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
