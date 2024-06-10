import 'package:dishapp/pages/LoginFlow.dart';
import 'package:dishapp/pages/main_menu/HomeFlow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dishapp/pages/main_menu/Favourites.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<HomePage> {

  void _onItemTapped(int index){
    setState(() {
      currentPageIndex = index;
    });
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xfffeeddd)),
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            backgroundColor: Color(0xfffeeddd),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite, color: Colors.red),
                icon: Icon(Icons.favorite_outline),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outline),
                label: 'User',
              ),
            ],
        currentIndex: currentPageIndex,
        onTap: _onItemTapped,
      )),
      body: <Widget>[
        /// Home page
        HomeWidget(),

        /// Notifications page

        FavouritesWidget(),


        /// User page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: FloatingActionButton.extended(onPressed: () { FirebaseAuth.instance.signOut(); Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginWidget())); }, label: Text("Logout"))
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}

