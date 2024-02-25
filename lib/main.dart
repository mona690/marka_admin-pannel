import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mac_store_web/views/screens/inner_screens/buyers_screen.dart';
import 'package:mac_store_web/views/screens/inner_screens/category_screen.dart';
import 'package:mac_store_web/views/screens/inner_screens/order_scree.dart';
import 'package:mac_store_web/views/screens/inner_screens/upload_banner_screen.dart';
import 'package:mac_store_web/views/screens/upload_product_screen.dart';
import 'package:mac_store_web/views/screens/vendors_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              apiKey: "AIzaSyAnZ4je3pxS_dkYnRCP9HNzcjbtcVEoEj4",
              appId: "1:187122969395:web:372743cdcbc696c8256c46",
              messagingSenderId: "187122969395",
              projectId: "marka-multistore",
              storageBucket: "gs://marka-multistore.appspot.com",
            )
          : null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SideMenu(),
      builder: EasyLoading.init(),
    );
  }
}

class SideMenu extends StatefulWidget {
  static const String id = '\sideMenu';

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Widget _selectedScreen = CategoryScreen();

  screnSelectore(item) {
    switch (item.route) {
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });

      case VendorsScreen.routeName:
        setState(() {
          _selectedScreen = VendorsScreen();
        });

        break;

      case BuyersScreen.routeName:
        setState(() {
          _selectedScreen = BuyersScreen();
        });

        break;

      case OrderScreen.routeName:
        setState(() {
          _selectedScreen = OrderScreen();
        });

        break;

      case UploadBanners.id:
        setState(() {
          _selectedScreen = UploadBanners();
        });

        break;

      case ProductUploadPage.id:
        setState(() {
          _selectedScreen = ProductUploadPage();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
    backgroundColor: Color.fromARGB(255, 232, 153, 6),
    flexibleSpace: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            // Add spacing between text and image
          Image.asset(
            'assets/marka_in.png', // Replace with the path to your image asset
            fit: BoxFit.cover,
            width: 65, // Adjust width as needed
          ),
        ],
      ),
    ),
  ),
      sideBar: SideBar(
         backgroundColor: Colors.white,
        items: const [
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.routeName,
            icon: CupertinoIcons.person_3,
             
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: BuyersScreen.routeName,
            icon: CupertinoIcons.person,
          ),
          // AdminMenuItem(
          //   title: 'Withdrawal',
          //   route: WithrawalScreen.id,
          //   icon: CupertinoIcons.money_dollar,
          // ),
          AdminMenuItem(
            title: 'Orders',
            route: OrderScreen.routeName,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category_rounded,
            route: CategoryScreen.id,
          ),

          AdminMenuItem(
            title: 'Upload Banner',
            icon: CupertinoIcons.add,
            route: UploadBanners.id,
          ),
          AdminMenuItem(
            title: 'Products',
            icon: CupertinoIcons.shopping_cart,
            route: ProductUploadPage.id,
          ),
        ],
        selectedRoute: CategoryScreen.id,
        onSelected: (item) {
          screnSelectore(item);

          // if (item.route != null) {
          //   Navigator.of(context).pushNamed(item.route!);
          // }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black,
          child: const Center(
            child: Text(
              'Marka Store Admin ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
         
     /* footer: Container(
  height: 50,
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.transparent, // Add this line to set the background color
    image: DecorationImage(
      image: AssetImage('assets/marka_in.png'),
      fit: BoxFit.cover,
    ),
  ),
),*/
      ),
      body: _selectedScreen,
    );
  }
}
