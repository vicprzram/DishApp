import 'package:dishapp/pages/main_menu/Home.dart';
import 'package:dishapp/pages/main_menu/HomeFlow.dart';
import 'package:flutter/material.dart';

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
                activeIcon: Icon(Icons.favorite),
                icon: Icon(Icons.favorite_outline),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.shopping_cart),
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),

        /// User page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'User page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}

