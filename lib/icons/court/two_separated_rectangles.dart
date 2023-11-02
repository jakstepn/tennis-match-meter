import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_data.dart';
import 'package:tennis_match_meter/data_containers/two_separated_rec_data.dart';
import 'package:tennis_match_meter/data_containers/two_separated_rec_dimensions.dart';
import 'package:tennis_match_meter/pages/game/court/court_page_bloc.dart';

class TwoStatefulSeparatedRectangles extends StatefulWidget {
  @override
  const TwoStatefulSeparatedRectangles({
    Key? key,
    this.rectanglesData = const SeparatedRectanglesDimensinos(),
    this.activeSide = false,
    this.isActive = false,
    this.reversed = false,
  }) : super(key: key);

  final SeparatedRectanglesDimensinos rectanglesData;
  final bool isActive, activeSide;
  final bool reversed;

  @override
  State<StatefulWidget> createState() => _TwoStatefulSeparatedRectangles();
}

class _TwoStatefulSeparatedRectangles
    extends State<TwoStatefulSeparatedRectangles> {
  late bool reversed = widget.reversed;
  late SeparatedRectanglesDimensinos rectanglesData = widget.rectanglesData;

  final Color currentSideColor = Colors.red;
  final Color otherSideColor = Colors.yellow;

  Color getColor(bool isPlayerSide) {
    return isPlayerSide ? currentSideColor : otherSideColor;
  }

  @override
  Widget build(BuildContext context) {
    MatchData matchData =
        Provider.of<CourtPageBloc>(context, listen: false).state;

    return TwoSeparatedRectangles(
        data: SeparatedRectanglesData(
      dimenstions: rectanglesData,
      firstRectangleColor: !widget.isActive
          ? Colors.transparent
          : matchData.currentServingSide
              ? Colors.transparent
              : Colors.red,
      secondRectangleColor: !widget.isActive
          ? Colors.transparent
          : matchData.currentServingSide
              ? Colors.red
              : Colors.transparent,
      reversed: reversed,
    ));
  }
}

class TwoSeparatedRectangles extends StatelessWidget {
  const TwoSeparatedRectangles({
    Key? key,
    this.data = const SeparatedRectanglesData(),
  }) : super(key: key);

  final SeparatedRectanglesData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection:
          data.reversed ? VerticalDirection.up : VerticalDirection.down,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                flex: data.dimenstions.borderFlex,
                child: Container(
                  color: data.borderColor,
                ),
              ),
              Expanded(
                flex: data.dimenstions.rectangleFlex,
                child: Container(
                  color: data.firstRectangleColor,
                ),
              ),
              Expanded(
                flex: data.dimenstions.separatorFlex,
                child: Container(
                  color: data.separatorColor,
                ),
              ),
              Expanded(
                flex: data.dimenstions.rectangleFlex,
                child: Container(
                  color: data.secondRectangleColor,
                ),
              ),
              Expanded(
                flex: data.dimenstions.borderFlex,
                child: Container(
                  color: data.borderColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
