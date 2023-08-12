import 'dart:convert';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var userApi =
        DefaultAssetBundle.of(context).loadString('assets/api/my_api.json');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu)),
            ),
            title: const Text(
              'Telegram',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 280,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 56, 56, 56),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(
                                  'https://tejedd76pluu.merlincdn.net//Programlar/EGO/Haberler/EGO-haber-resim-4212a5cf-1789-42e8-8d7a-609815ca0ae8.jpg'),
                            ),
                            const SizedBox(
                              width: 140.0,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.sunny)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: const Text(
                            "Melisa",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          subtitle: const Text(
                            "+994 554356798",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_drop_down)),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.verified_user,
                  ),
                  title: const Text('New Group'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.verified_user_sharp,
                  ),
                  title: const Text('Contacts'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.call,
                  ),
                  title: const Text('Calls'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.people,
                  ),
                  title: const Text('People Nearby'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.save,
                  ),
                  title: const Text('Save Messages'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                  ),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help_center,
                  ),
                  title: const Text('Telegram Features'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: FutureBuilder(
              future: userApi,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('Data not found');
                }

                var users = jsonDecode(snapshot.data.toString());

                List userList = users['users'];
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 2,
                  ),
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            NetworkImage('${users['users'][index]['profile']}'),
                      ),
                      title: Text(users['users'][index]['name']),
                      subtitle: Text(userList[index]['message']),
                      trailing: Text(userList[index]['date'].toString()),
                    );
                  },
                );
              })),
    );
  }
}
