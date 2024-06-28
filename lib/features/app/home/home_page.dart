

import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de navegación
      // Navigation bar
      appBar: AppBar(
        title: const Text("Passport",
                            style:TextStyle(
                              fontSize: 20,
                              color: greyColor,
                              fontWeight: FontWeight.w600,
                          ),
                        ),
        actions: const [
          Row(
            children: [
              Icon(
                Icons.filter_list,
                color: greyColor,
                size: 28,
              ),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:538705617.
              SizedBox(width: 25),

              Icon(
                Icons.search,
                color: greyColor,
                size: 28,
              ),
              SizedBox(width: 25),
              Icon(
                Icons.more_vert,
                color: greyColor,
                size: 28,
              ),
            ],
          ),
        ],
      ),
      
      body: <Widget>[
        /// Home page
        const Card(
          shadowColor: Colors.transparent,
          margin: EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                
              ),
            ),
          ),
        ),

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
                     borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Hello',
                    
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
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'Hi!',
                  
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.grey,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.sensor_occupied),
            icon: Icon(Icons.home_outlined),
            label: 'Autorized',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.location_city)),
            label: 'Cluster',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp),),
            label: 'Messages',
          ),
        ],
      ),
      
    );
  }
}