import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/pages/database/user_list/user_list_event.dart';
import 'package:tennis_match_meter/pages/database/user_list/user_tile_click_event.dart';
import 'package:tennis_match_meter/pages/database/user_list/selected_user_event.dart';
import 'package:tennis_match_meter/pages/database/user_list/user_list_bloc.dart';
import 'package:tennis_match_meter/pages/database/user_list/selected_tile.dart';
import 'package:tennis_match_meter/account/app_user.dart';
import 'package:tennis_match_meter/animations/load_animation.dart';
import 'package:tennis_match_meter/pages/authentication/auth_cubit.dart';
import 'package:tennis_match_meter/data_containers/database/friend.dart';
import 'package:tennis_match_meter/pages/database/friends/friends_cubit.dart';
import 'package:tennis_match_meter/pages/templates/page_template.dart';
import 'package:tennis_match_meter/pages/user/details_page.dart';
import 'package:tennis_match_meter/styles/button_styles.dart';
import 'package:tennis_match_meter/styles/colors.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/styles/text_styles.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_action_button.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_text.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        authService: context.read(),
      ),
      child: BlocProvider(
        create: (context) => UserListBloc(),
        child: BlocProvider(
          create: (context) => UserListTileBloc(),
          child: PageTemplate(
            child: BlocProvider(
              create: (context) => FriendsCubit(
                shoutboxDataSource: context.read(),
              ),
              child: const FriendsBox(),
            ),
          ),
        ),
      ),
    );
  }
}

class FriendsBox extends StatefulWidget {
  const FriendsBox({Key? key}) : super(key: key);

  @override
  _FriendsBoxState createState() => _FriendsBoxState();
}

class _FriendsBoxState extends State<FriendsBox> {
  @override
  Widget build(BuildContext context) {
    PageStyle style = Provider.of<PageStyle>(context);
    return Column(
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (contextAuth, stateAuth) => stateAuth is SignedInState
              ? Provider(
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
                  child: BlocBuilder<UserListBloc, UserListState>(
                      builder: (context, state) {
                    return Column(
                      children: [
                        Container(
                          color: AppColors.getColor(
                            Place.buttonBackgroundColor,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Center(
                                      child: CustomText(
                                        text: "Friends",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  state is UserListAddFriendState
                                      ? const _AddUserButon()
                                      : const _PlusButton(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  state is UserListDeleteFriendState
                                      ? const _DeleteUserButton()
                                      : const _MinusButton(),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        const FriendsList(),
                      ],
                    );
                  }),
                )
              : CustomActionButton(
                  text: "Back",
                  action: () {
                    Navigator.pop(context);
                  },
                ),
        ),
      ],
    );
  }
}

class _MinusButton extends StatelessWidget {
  const _MinusButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomActionButton(
      text: "-",
      action: () {
        BlocProvider.of<UserListBloc>(context)
            .add(UserListStartDeletingFriendsEvent());
      },
    );
  }
}

class _DeleteUserButton extends StatelessWidget {
  const _DeleteUserButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomActionButton(
      text: "delete",
      action: () {
        BlocProvider.of<UserListBloc>(context)
            .add(UserListStopSelectingEvent());
        List<AppUser> selected =
            BlocProvider.of<UserListTileBloc>(context).tiles;
        String uid =
            BlocProvider.of<AuthCubit>(context).authService.getUserUID();
        for (var i = 0; i < selected.length; i++) {
          BlocProvider.of<FriendsCubit>(context).deleteFriend(selected[i], uid);
        }
        BlocProvider.of<UserListTileBloc>(context).add(UserListTileReset());
      },
    );
  }
}

class _PlusButton extends StatelessWidget {
  const _PlusButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomActionButton(
      text: "+",
      action: () {
        BlocProvider.of<UserListBloc>(context)
            .add(UserListStartAddingFriendsEvent());
      },
    );
  }
}

class _AddUserButon extends StatelessWidget {
  const _AddUserButon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomActionButton(
      text: "add",
      action: () {
        BlocProvider.of<UserListBloc>(context)
            .add(UserListStopSelectingEvent());
        List<AppUser> selected =
            BlocProvider.of<UserListTileBloc>(context).tiles;
        String uid =
            BlocProvider.of<AuthCubit>(context).authService.getUserUID();
        for (var i = 0; i < selected.length; i++) {
          BlocProvider.of<FriendsCubit>(context).addFriend(selected[i], uid);
        }
        BlocProvider.of<UserListTileBloc>(context).add(UserListTileReset());
      },
    );
  }
}

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    AuthCubit auth = Provider.of<AuthCubit>(context, listen: false);
    return BlocBuilder<UserListBloc, UserListState>(builder: (context, state) {
      state is UserListAddFriendState
          ? BlocProvider.of<FriendsCubit>(context).getUsers(
              auth.authService.getUserUID(),
            )
          : BlocProvider.of<FriendsCubit>(context).getFriends(context);
      return const _PlayerFriendsList();
    });
  }
}

class _PlayerFriendsList extends StatefulWidget {
  const _PlayerFriendsList({Key? key}) : super(key: key);

  @override
  State<_PlayerFriendsList> createState() => _PlayerFriendsListState();
}

class _PlayerFriendsListState extends State<_PlayerFriendsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsCubit, FriendsState>(
      builder: (contextFriends, stateFriends) {
        if (stateFriends is FriendsLoadedState ||
            stateFriends is AllUsersLoadedState) {
          return BlocBuilder<UserListTileBloc, List<AppUser>>(
            bloc: UserListTileBloc(),
            builder: (contextListTile, stateListTile) {
              return BlocBuilder<UserListBloc, UserListState>(
                builder: (contextList, stateList) {
                  List<Friend> userList = List.empty(growable: true);
                  if (stateFriends is FriendsLoadedState) {
                    userList = stateFriends.friends;
                  } else if (stateFriends is AllUsersLoadedState) {
                    userList = stateFriends.allUsers;
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: userList.length,
                    itemBuilder: (contextList, i) => _Tile(
                      notlimited: true,
                      friend: userList[i],
                    ),
                    reverse: true,
                  );
                },
              );
            },
          );
        } else {
          return const Center(child: LoadAnimation());
        }
      },
    );
  }
}

class _Tile extends StatefulWidget {
  const _Tile({
    Key? key,
    required this.friend,
    this.notlimited = false,
  }) : super(key: key);
  final Friend friend;
  final bool notlimited;
  @override
  __TileState createState() => __TileState();
}

class __TileState extends State<_Tile> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = BlocProvider.of<UserListTileBloc>(context)
        .tiles
        .contains(widget.friend.user);
    UserListState flst = BlocProvider.of<UserListBloc>(context).state;
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 8.0, left: 2.0, right: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected
            ? AppColors.getColor(Place.selectedTileColor)
            : AppColors.getColor(Place.unselectedTileColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
          ),
        ],
      ),
      child: (flst is UserListSelectState ||
              flst is UserListAddFriendState ||
              flst is UserListDeleteFriendState)
          ? GestureDetector(
              child: CustomText(text: widget.friend.user.name),
              onTap: () {
                setState(() {
                  BlocProvider.of<UserListTileBloc>(context)
                      .add(UserListTileClick(
                    user: widget.friend.user,
                    notlimited: widget.notlimited,
                  ));
                });
              })
          : GestureDetector(
              onTap: () {
                Provider.of<SelectedTileBloc<AppUser>>(context, listen: false)
                    .add(
                  SelectedNewEvent<AppUser>(element: widget.friend.user),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserDetailsPage(),
                  ),
                );
              },
              child: Center(
                child: CustomText(
                  text: widget.friend.user.name,
                ),
              ),
            ),
    );
  }
}
