import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_result.dart';
import 'package:tennis_match_meter/pages/game/court/court_page_bloc.dart';
import 'package:tennis_match_meter/pages/database/user_list/selected_tile.dart';
import 'package:tennis_match_meter/account/app_user.dart';
import 'package:tennis_match_meter/animations/load_animation.dart';
import 'package:tennis_match_meter/authentication/auth_service.dart';
import 'package:tennis_match_meter/data_containers/match/player.dart';
import 'package:tennis_match_meter/database/data_source.dart';
import 'package:tennis_match_meter/navigation/route_generator.dart';
import 'package:tennis_match_meter/styles/page_style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return MultiProvider(
              providers: [
                Provider<AuthService>(
                  create: (_) => AuthService(
                    firebaseAuth: FirebaseAuth.instance,
                  ),
                ),
                Provider<DataSource>(
                  create: (_) => DataSource(
                    firestore: FirebaseFirestore.instance,
                  ),
                ),
                BlocProvider(
                  create: (context) => SelectedTileBloc<AppUser>(),
                ),
                BlocProvider(
                  create: (context) => SelectedTileBloc<MatchResult>(),
                ),
                BlocProvider<CourtPageBloc>(
                  create: (_) => CourtPageBloc(
                    Player(
                      name: "",
                      playerID: "",
                    ),
                    Player(
                      name: "",
                      playerID: "",
                    ),
                    Player(
                      name: "",
                      playerID: "",
                    ),
                  ),
                ),
                Provider(
                  create: (_) => PageStyle.defaultStyle(),
                ),
              ],
              child: MaterialApp(
                onGenerateRoute: (settings) =>
                    RouteGenerator.generateRoute(settings),
                title: 'Tennis match meter',
                theme: ThemeData(
                  primarySwatch: Colors.green,
                  brightness: Brightness.light,
                  textTheme: Typography.blackRedmond,
                ),
                initialRoute: '/',
              ),
            );
          default:
            return const MaterialApp(
              home: Scaffold(
                body: ColoredBox(
                  color: Colors.white,
                  child: Center(
                    child: LoadAnimation(),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
