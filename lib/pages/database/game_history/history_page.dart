import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_result.dart';
import 'package:tennis_match_meter/pages/database/user_list/selected_user_event.dart';
import 'package:tennis_match_meter/pages/database/user_list/selected_tile.dart';
import 'package:tennis_match_meter/animations/load_animation.dart';
import 'package:tennis_match_meter/pages/authentication/auth_cubit.dart';
import 'package:tennis_match_meter/pages/database/game_history/history_cubit.dart';
import 'package:tennis_match_meter/pages/templates/page_template.dart';
import 'package:tennis_match_meter/pages/user/details_page.dart';
import 'package:tennis_match_meter/styles/button_styles.dart';
import 'package:tennis_match_meter/styles/colors.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/styles/text_styles.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_action_button.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_text.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        authService: context.read(),
      ),
      child: BlocProvider(
        create: (context) => HistoryCubit(
          shoutboxDataSource: context.read(),
        )..getHistory(context.read<AuthCubit>().authService.getUserUID()),
        child: const PageTemplate(
          child: HistoryBox(),
        ),
      ),
    );
  }
}

class HistoryBox extends StatefulWidget {
  const HistoryBox({Key? key}) : super(key: key);

  @override
  _HistoryBoxState createState() => _HistoryBoxState();
}

class _HistoryBoxState extends State<HistoryBox> {
  @override
  Widget build(BuildContext context) {
    PageStyle style = Provider.of<PageStyle>(context);
    return Provider(
      create: (context) => PageStyle(
        textStyle: TextStyles.from(
            textStyle: TextStyle(
              color: AppColors.getColor(
                Place.appTitleColor,
              ),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            errorTextStyle: style.textStyle.errorTextStyle),
        buttonStyle: CustomButtonStyle.from(
          textStyle: TextStyle(
            color: AppColors.getColor(
              Place.appTitleColor,
            ),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          size: const Size(100, 50),
          backgroundColor: Colors.transparent,
          boxDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColors.getColor(
                Place.appTitleColor,
              ),
              width: 5,
            ),
          ),
        ),
        textFieldStyle: style.textFieldStyle,
        backgroundStyle: style.backgroundStyle,
      ),
      child: Column(
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => state is SignedInState
                ? const _List()
                : CustomActionButton(
                    text: "Back",
                    action: () {
                      Navigator.pop(context);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _List extends StatefulWidget {
  const _List({Key? key}) : super(key: key);

  @override
  State<_List> createState() => __ListState();
}

class __ListState extends State<_List> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoadedState) {
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.history.length,
            itemBuilder: (_, i) => Dismissible(
              key: Key(state.history[i].toString()),
              onDismissed: (direction) {
                setState(() {
                  String uid =
                      BlocProvider.of<AuthCubit>(context, listen: false)
                          .authService
                          .getUserUID();
                  BlocProvider.of<HistoryCubit>(context, listen: false)
                      .deleteMatch(
                    uid,
                    state.history[i].uid,
                  );
                  state.history.removeAt(i);
                });
              },
              child: _Tile(
                result: state.history[i],
              ),
            ),
          );
        } else {
          return const LoadAnimation();
        }
      },
    );
  }
}

class _Tile extends StatefulWidget {
  const _Tile({
    Key? key,
    required this.result,
  }) : super(key: key);

  final MatchResult result;
  @override
  State<_Tile> createState() => __TileState();
}

class __TileState extends State<_Tile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 8.0, left: 2.0, right: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.getColor(Place.unselectedTileColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Provider.of<SelectedTileBloc<MatchResult>>(context, listen: false)
              .add(
            SelectedNewEvent<MatchResult>(element: widget.result),
          );
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ListenableProvider(
                create: (_) => animation,
                child: const MatchDetailsPage(),
              ),
            ),
          );
        },
        child: Center(
          child: CustomText(
            text:
                '${widget.result.firstPlayerName} : ${widget.result.secondPlayerName}',
          ),
        ),
      ),
    );
  }
}
