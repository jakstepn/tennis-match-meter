import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_data.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_result.dart';
import 'package:tennis_match_meter/pages/game/court/court_page_bloc.dart';
import 'package:tennis_match_meter/authentication/auth_service.dart';
import 'package:tennis_match_meter/database/data_source.dart';
import 'package:tennis_match_meter/pages/database/game_history/history_cubit.dart';
import 'package:tennis_match_meter/icons/court/two_separated_rectangles.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/widgets/background/default_background.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_action_button.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_button.dart';
import 'package:tennis_match_meter/widgets/slidable_widget/slidable_court.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_text.dart';
import 'package:tennis_match_meter/widgets/text_widgets/score_container.dart';
import '../../../icons/court/court.dart';

class CourtPage extends StatefulWidget {
  const CourtPage({
    Key? key,
  }) : super(key: key);

  @override
  _CourtPageState createState() => _CourtPageState();
}

class _CourtPageState extends State<CourtPage> {
  @override
  Widget build(BuildContext context) {
    _landscapeMode();
    return Provider(
      create: (context) => PageStyle.courtPageStyle(),
      child: Scaffold(
        body: DefaultBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 8.0,
                top: 0,
              ),
              child: BlocBuilder<CourtPageBloc, MatchData>(
                builder: (context, state) {
                  return state.finished
                      ? BlocProvider(
                          create: (context) =>
                              HistoryCubit(shoutboxDataSource: context.read()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomText(
                                  text: "The game has been finished!"),
                              state.firstPlayer.sets == state.secondPlayer.sets
                                  ? const CustomText(text: "It is a draw!")
                                  : CustomText(
                                      text:
                                          "${state.firstPlayer.sets > state.secondPlayer.sets ? state.firstPlayer.name : state.secondPlayer.name} has won!",
                                    ),
                              CustomActionButton(
                                text: "Menu",
                                action: () {
                                  bool isSignedIn = Provider.of<AuthService>(
                                          context,
                                          listen: false)
                                      .isSignedIn;
                                  if (isSignedIn) {
                                    Provider.of<DataSource>(context,
                                            listen: false)
                                        .saveResult(
                                            MatchResult.fromData(state));
                                    Navigator.pushReplacementNamed(
                                        context, "/login");
                                  } else {
                                    Navigator.pushReplacementNamed(
                                        context, "/menu");
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                      text: state.leftPlayer.sets.toString()),
                                  const CustomText(text: ":"),
                                  CustomText(
                                      text: state.rightPlayer.sets.toString()),
                                  CustomText(text: "(${state.setsToPlay})"),
                                ],
                              ),
                            ),
                            ServiceRow(
                              leftScore: state.leftPlayer.gemsInSet.toString(),
                              rightScore:
                                  state.rightPlayer.gemsInSet.toString(),
                              leftServFaults: state.leftPlayer.servFaultsInSet,
                              rightServFaults:
                                  state.rightPlayer.servFaultsInSet,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CourtIcon(
                              leftName: state.leftPlayer.name,
                              rightName: state.rightPlayer.name,
                              isLeftServing: state.isLeftServing,
                              servingSide: state.currentServingSide,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ScoreRow(
                              leftScore: state.leftPlayer.symbol,
                              rightScore: state.rightPlayer.symbol,
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _anyMode();
  }

  void _landscapeMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _anyMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
}

class ServiceRow extends StatelessWidget {
  const ServiceRow({
    this.leftScore = "",
    this.rightScore = "",
    this.leftServFaults = 0,
    this.rightServFaults = 0,
    Key? key,
  }) : super(key: key);

  final String leftScore;
  final String rightScore;
  final int leftServFaults;
  final int rightServFaults;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ServLeft(
                      val: leftServFaults,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: leftScore,
                          style: const TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const CustomText(
                          text: ":",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        CustomText(
                          text: rightScore,
                          style: const TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ServRight(
                      val: rightServFaults,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreRow extends StatelessWidget {
  const ScoreRow({
    Key? key,
    this.leftScore = "0",
    this.rightScore = "0",
  }) : super(key: key);

  final String leftScore, rightScore;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: ScoreContainer(
              text: leftScore,
            ),
          ),
          const Expanded(
            flex: 1,
            child: CustomNavigatorButton(
              navigateToName: "/menu",
              text: "Menu",
            ),
          ),
          Expanded(
            flex: 5,
            child: ScoreContainer(
              text: rightScore,
            ),
          ),
        ],
      ),
    );
  }
}

class CourtIcon extends StatelessWidget {
  const CourtIcon({
    Key? key,
    required this.leftName,
    required this.rightName,
    required this.isLeftServing,
    required this.servingSide,
  }) : super(key: key);

  final String leftName, rightName;
  final bool isLeftServing, servingSide;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 50,
      child: Row(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: SlidableCourt(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          RotatedBox(
                            quarterTurns: 3,
                            child: CustomText(text: leftName),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: TwoStatefulSeparatedRectangles(
                              isActive: isLeftServing,
                              activeSide: servingSide,
                              reversed: true,
                            ),
                          ),
                          const Expanded(
                            flex: 40,
                            child: Court(),
                          ),
                          Expanded(
                            flex: 1,
                            child: TwoStatefulSeparatedRectangles(
                              isActive: !isLeftServing,
                              activeSide: !servingSide,
                              reversed: false,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: CustomText(text: rightName),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServLeft extends StatelessWidget {
  const ServLeft({
    Key? key,
    required this.val,
  }) : super(key: key);

  final int val;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PauxCircle(color: 2 - val >= 1 ? Colors.green : Colors.grey),
        const SizedBox(
          width: 5,
        ),
        PauxCircle(color: 2 - val == 2 ? Colors.green : Colors.grey),
      ],
    );
  }
}

class ServRight extends StatelessWidget {
  const ServRight({
    Key? key,
    required this.val,
  }) : super(key: key);

  final int val;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PauxCircle(color: 2 - val == 2 ? Colors.green : Colors.grey),
        const SizedBox(
          width: 5,
        ),
        PauxCircle(color: 2 - val >= 1 ? Colors.green : Colors.grey),
      ],
    );
  }
}

class PauxCircle extends StatelessWidget {
  const PauxCircle({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(
        const Size(30, 30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
