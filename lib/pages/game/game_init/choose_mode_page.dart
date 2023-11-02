// Online mode with choosing players from a friends list
// Online mode with anonymous players (saved result to the database)
// Offline mode with anonymous players (not saved in the database)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/BLoC/game_stats/game_limits.dart';
import 'package:tennis_match_meter/pages/game/game_init/choose_players_page.dart';
import 'package:tennis_match_meter/pages/templates/page_template.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_action_button.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_textfield.dart';

class ChooseModePage extends StatefulWidget {
  const ChooseModePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChooseModePageState();
}

class _ChooseModePageState extends State<ChooseModePage> {
  var text = TextEditingController();
  bool clickedButton = false;

  @override
  Widget build(BuildContext context) {
    return clickedButton
        ? Provider(
            create: (context) => GameLimits(
                  sets: int.parse(text.text),
                ),
            child: const ChoosePlayersPage())
        : PageTemplate(
            child: Center(
              child: Provider(
                create: (context) => PageStyle.blackTextSmallTextfieldStyle(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Sets to play:"),
                    CustomTextField(
                      hintText: "Enter number here",
                      controller: text,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomActionButton(
                      text: "Next",
                      action: () {
                        setState(() {
                          clickedButton = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
