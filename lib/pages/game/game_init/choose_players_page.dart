import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_data.dart';
import 'package:tennis_match_meter/pages/database/friends/friends_page.dart';
import 'package:tennis_match_meter/pages/game/court/court_page_bloc.dart';
import 'package:tennis_match_meter/BLoC/events/add_point_event.dart';
import 'package:tennis_match_meter/pages/database/user_list/user_list_bloc.dart';
import 'package:tennis_match_meter/BLoC/game_stats/game_limits.dart';
import 'package:tennis_match_meter/account/app_user.dart';
import 'package:tennis_match_meter/animations/load_animation.dart';
import 'package:tennis_match_meter/pages/authentication/auth_cubit.dart';
import 'package:tennis_match_meter/authentication/auth_service.dart';
import 'package:tennis_match_meter/data_containers/match/player.dart';
import 'package:tennis_match_meter/pages/database/friends/friends_cubit.dart';
import 'package:tennis_match_meter/pages/templates/page_template.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_action_button.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_text.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_textfield.dart';

enum FriendsOrAnon {
  friends,
  anonymous,
}

class ChoosePlayersPage extends StatelessWidget {
  const ChoosePlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(authService: context.read()),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Provider(
            create: (context) => PageStyle.blackText(),
            child: PageTemplate(
              child: state is SignedInState
                  ? const ChooseIfToPlayWithFriends()
                  : const ProvidePlayersBox(),
            ),
          );
        },
      ),
    );
  }
}

class ChooseIfToPlayWithFriends extends StatefulWidget {
  const ChooseIfToPlayWithFriends({Key? key}) : super(key: key);

  @override
  _ChooseIfToPlayWithFriendsState createState() =>
      _ChooseIfToPlayWithFriendsState();
}

class _ChooseIfToPlayWithFriendsState extends State<ChooseIfToPlayWithFriends> {
  FriendsOrAnon foa = FriendsOrAnon.friends;
  bool clickedButton = false;

  @override
  Widget build(BuildContext context) {
    return clickedButton
        ? (foa == FriendsOrAnon.friends
            ? const ChoosePlayers()
            : const ProvidePlayersBox())
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const CustomText(
                  text:
                      "Select whether you want to add your friends to the game",
                ),
                const CustomText(
                  text: "or create anonymous players:",
                ),
                DropdownButton<FriendsOrAnon>(
                  value: foa,
                  onChanged: (value) => setState(() {
                    foa = value ?? FriendsOrAnon.anonymous;
                  }),
                  items: FriendsOrAnon.values.map(
                    (FriendsOrAnon foa) {
                      return DropdownMenuItem(
                        value: foa,
                        child: Text(foa.toString().split('.').last),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(
                  height: 5,
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
          );
  }
}

class ChoosePlayers extends StatelessWidget {
  const ChoosePlayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendsCubit(
        shoutboxDataSource: context.read(),
      ),
      child: BlocProvider(
        create: (context) => UserListTileBloc(),
        child: BlocProvider(
          create: (context) => UserListBloc(
            initialState: UserListSelectState(),
          ),
          child: const ChoosePlayersBox(),
        ),
      ),
    );
  }
}

class ChoosePlayersBox extends StatefulWidget {
  const ChoosePlayersBox({Key? key}) : super(key: key);

  @override
  _ChoosePlayersBoxState createState() => _ChoosePlayersBoxState();
}

class _ChoosePlayersBoxState extends State<ChoosePlayersBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FriendsList(),
        const SizedBox(
          height: 5,
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            authService: context.read(),
          ),
          child: BlocProvider(
            create: (context) => FriendsCubit(
              shoutboxDataSource: context.read(),
            )..getAllUsers(),
            child: BlocBuilder<AuthCubit, AuthState>(
                builder: (contextAuth, stateAuth) {
              return BlocBuilder<FriendsCubit, FriendsState>(
                  builder: (context, state) {
                return state is AllUsersLoadedState
                    ? CustomActionButton(
                        text: "Start game",
                        action: () {
                          List<AppUser> selectedUsers =
                              BlocProvider.of<UserListTileBloc>(context,
                                      listen: false)
                                  .state;
                          AuthService auth =
                              BlocProvider.of<AuthCubit>(context, listen: false)
                                  .authService;
                          GameLimits limits =
                              Provider.of<GameLimits>(context, listen: false);
                          BlocProvider.of<CourtPageBloc>(context, listen: false)
                              .add(
                            NewGameEvent(
                              matchData: MatchData(
                                firstPlayer:
                                    Player.fromUser(selectedUsers.first),
                                referee: Player(
                                  name: state.allUsers
                                      .firstWhere((element) =>
                                          element.user.uid == auth.getUserUID())
                                      .user
                                      .name,
                                  playerID: auth.getUserUID(),
                                ),
                                secondPlayer:
                                    Player.fromUser(selectedUsers.last),
                                setsToPlay: limits.sets,
                              ),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, "/court");
                        },
                      )
                    : const LoadAnimation();
              });
            }),
          ),
        ),
      ],
    );
  }
}

class ProvidePlayersBox extends StatefulWidget {
  const ProvidePlayersBox({Key? key}) : super(key: key);

  @override
  _ProvidePlayersBoxState createState() => _ProvidePlayersBoxState();
}

class _ProvidePlayersBoxState extends State<ProvidePlayersBox> {
  var player1Name = TextEditingController(),
      player2Name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    return BlocProvider(
      create: (context) => AuthCubit(
        authService: context.read(),
      ),
      child: BlocProvider(
        create: (context) => FriendsCubit(
          shoutboxDataSource: context.read(),
        )..getUsers(
            auth.getUserUID(),
          ),
        child: Column(
          children: [
            CustomTextField(
              controller: player1Name,
              hintText: "Left player name",
            ),
            CustomTextField(
              controller: player2Name,
              hintText: "Right player name",
            ),
            BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              return BlocBuilder<FriendsCubit, FriendsState>(
                  builder: (context, state) {
                return CustomActionButton(
                  text: "Next",
                  action: () {
                    GameLimits limits =
                        Provider.of<GameLimits>(context, listen: false);
                    AuthService auth =
                        BlocProvider.of<AuthCubit>(context).authService;
                    auth.isSignedIn
                        ? (state is FriendsLoadedState
                            ? BlocProvider.of<CourtPageBloc>(context).add(
                                NewGameEvent(
                                    matchData: MatchData(
                                  firstPlayer: Player(
                                    name: player1Name.text,
                                    playerID: "none",
                                  ),
                                  referee: Player(
                                    name: state.friends
                                        .firstWhere((element) =>
                                            element.user.uid ==
                                            auth.getUserUID())
                                        .user
                                        .name,
                                    playerID: auth.getUserUID(),
                                  ),
                                  secondPlayer: Player(
                                    name: player2Name.text,
                                    playerID: "none",
                                  ),
                                  setsToPlay: limits.sets,
                                )),
                              )
                            : const LoadAnimation())
                        : BlocProvider.of<CourtPageBloc>(context).add(
                            NewGameEvent(
                                matchData: MatchData(
                              firstPlayer: Player(
                                name: player1Name.text,
                                playerID: "none",
                              ),
                              referee: Player(
                                name: "none",
                                playerID: "none",
                              ),
                              secondPlayer: Player(
                                name: player2Name.text,
                                playerID: "none",
                              ),
                              setsToPlay: limits.sets,
                            )),
                          );
                    Navigator.pushReplacementNamed(context, "/court");
                  },
                );
              });
            }),
          ],
        ),
      ),
    );
  }
}
