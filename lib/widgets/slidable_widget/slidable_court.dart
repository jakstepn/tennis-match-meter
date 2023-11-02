import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_data.dart';
import 'package:tennis_match_meter/pages/game/court/court_page_bloc.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_text.dart';

class SlidableCourt extends StatelessWidget {
  const SlidableCourt({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    MatchData state = BlocProvider.of<CourtPageBloc>(context).state;
    return Slidable(
      direction: Axis.horizontal,
      startActionPane: ActionPane(
        extentRatio: 1,
        motion: const ScrollMotion(),
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: CustomText(text: state.leftPlayer.name),
          ),
          const SizedBox(
            width: 5,
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<CourtPageBloc>().onAddPoint(true);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: "Point",
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<CourtPageBloc>().onOut(true);
            },
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            label: "Out",
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<CourtPageBloc>().onServFault(true);
            },
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: "Service Fault",
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 1,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              context.read<CourtPageBloc>().onServFault(false);
            },
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: "Serv Fault",
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<CourtPageBloc>().onOut(false);
            },
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            label: "Out",
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<CourtPageBloc>().onAddPoint(false);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: "Point",
          ),
          const SizedBox(
            width: 5,
          ),
          RotatedBox(
            quarterTurns: 1,
            child: CustomText(text: state.rightPlayer.name),
          ),
        ],
      ),
      child: child,
    );
  }
}
