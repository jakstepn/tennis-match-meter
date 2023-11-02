import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_result.dart';
import 'package:tennis_match_meter/pages/database/user_list/selected_tile.dart';
import 'package:tennis_match_meter/account/app_user.dart';
import 'package:tennis_match_meter/pages/templates/page_template.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/styles/text_styles.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_text.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageStyle style = Provider.of<PageStyle>(context);
    return PageTemplate(child: BlocBuilder<SelectedTileBloc<AppUser>, AppUser?>(
        builder: (context, state) {
      return Provider(
        create: (context) => PageStyle(
          textStyle: TextStyles.from(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              errorTextStyle: style.textStyle.errorTextStyle),
          buttonStyle: style.buttonStyle,
          textFieldStyle: style.textFieldStyle,
          backgroundStyle: style.backgroundStyle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            CustomText(text: "Details of ${state?.name}:"),
            const SizedBox(
              height: 15,
            ),
            CustomText(text: "Height : ${state?.height}"),
            const SizedBox(
              height: 15,
            ),
            CustomText(text: "Weight : ${state?.weight}"),
            const SizedBox(
              height: 15,
            ),
            CustomText(text: "Gender : ${state?.gender}"),
            const SizedBox(
              height: 15,
            ),
            CustomText(text: "Skill : ${state?.level}"),
            const SizedBox(
              height: 15,
            ),
            CustomText(text: "Age : ${state?.age}"),
          ],
        ),
      );
    }));
  }
}

class MatchDetailsPage extends StatelessWidget {
  const MatchDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageStyle style = Provider.of<PageStyle>(context);
    return PageTemplate(child:
        BlocBuilder<SelectedTileBloc<MatchResult>, MatchResult?>(
            builder: (context, state) {
      return Provider(
        create: (context) => PageStyle(
          textStyle: TextStyles.from(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              errorTextStyle: style.textStyle.errorTextStyle),
          buttonStyle: style.buttonStyle,
          textFieldStyle: style.textFieldStyle,
          backgroundStyle: style.backgroundStyle,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            CustomText(text: "Player 1 name : ${state?.firstPlayerName}"),
            const SizedBox(
              height: 10,
            ),
            CustomText(text: "Player 2 name : ${state?.secondPlayerName}"),
            const SizedBox(
              height: 10,
            ),
            CustomText(
                text: "First player has won ${state?.setsFirstPlayer} sets"),
            const SizedBox(
              height: 10,
            ),
            CustomText(
                text: "Second player has won ${state?.setsSecondPlayer} sets"),
            const SizedBox(
              height: 10,
            ),
            CustomText(
                text: "Frirst player has won ${state?.gemsFirstPlayer} gems"),
            const SizedBox(
              height: 10,
            ),
            CustomText(
                text: "Second player has won ${state?.gemsSecondPlayer} gems"),
            const SizedBox(
              height: 10,
            ),
            CustomText(
                text: "Outs by the first player : ${state?.outsFirstPlayer}"),
            const SizedBox(
              height: 10,
            ),
            CustomText(
                text: "Outs by the second player : ${state?.outsSecondPlayer}"),
            const SizedBox(
              height: 10,
            ),
            CustomText(
                text:
                    "Service faults by the first player : ${state?.servFaultsFirstPlayer}"),
            const SizedBox(
              height: 10,
            ),
            CustomText(
                text:
                    "Service faults by the first player : ${state?.servFaultsSecondPlayer}"),
          ],
        ),
      );
    }));
  }
}
