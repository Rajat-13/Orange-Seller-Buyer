import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:orange/utils/routes/route.dart';
import 'package:orange/utils/routes/routeNames.dart';
import 'package:orange/viewmodels/authViewModel.dart';
import 'package:orange/viewmodels/profileViewModel.dart';
import 'package:orange/viewmodels/sellercrudViewModel.dart';
import 'package:orange/viewmodels/userViewModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('localStorage');
  runApp(OrangeApp());
}
class OrangeApp extends StatefulWidget {
  OrangeAppState createState() => OrangeAppState();
}

class OrangeAppState extends State<OrangeApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthViewModel()),
          ChangeNotifierProvider(create: (context) => UserViewModel()),
          ChangeNotifierProvider(create: (context) => SellercrudViewModel()),
          ChangeNotifierProvider(create: (context) => ProfileViewModel()),

        ],
      child: MaterialApp(
          theme: ThemeData(
            textTheme: ThemeData.light().textTheme.copyWith(
              caption: const TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 25,
                color: Colors.white,),
              bodyText1: const TextStyle(
                  fontFamily: 'Gilroy', color: Colors.white, fontSize: 14),
              bodyText2: const TextStyle(
                  fontFamily: 'Gilroy',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          initialRoute: RouteNames.splash,
          onGenerateRoute: Routes.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
    );
  }
}
