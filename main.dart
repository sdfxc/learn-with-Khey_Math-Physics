import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn with Khey',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isNotRobotChecked = false;
  bool _isPasswordVisible = false;
  bool _useEmail = false;

  void _login() {
    String usernameOrEmail =
    _useEmail ? _emailController.text : _usernameController.text;
    String password = _passwordController.text;

    if (!_isNotRobotChecked) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verification Failed'),
            content: Text('Please confirm you are not a robot.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if ((usernameOrEmail == 'kheng khey' ||
        usernameOrEmail == 'khengkhey835@gmail.com') &&
        password == '1234') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username/email or password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://raw.githubusercontent.com/sdfxc/learn-with-Khey_Math-Physics/main/IMG_1.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  if (_useEmail)
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    )
                  else
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isNotRobotChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isNotRobotChecked = value ?? false;
                              });
                            },
                          ),
                          Text("I'm not a robot"),
                        ],
                      ),
                      Row(
                        children: [
                          Text(_useEmail ? 'Use Username' : 'Use Email'),
                          Switch(
                            value: _useEmail,
                            onChanged: (bool value) {
                              setState(() {
                                _useEmail = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    BookScreen(),
    ExerciseScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Book'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Exercise'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  Widget _buildCategoryCard(String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Widget nextScreen;

        // Determine the next screen based on the category title
        switch (title) {
          case 'អំណាន': // "Reading"
            nextScreen = SubjectScreen(
              subjects: [
                {'id': 1, 'name': 'English', 'color': Colors.pinkAccent},
                {'id': 2, 'name': 'Ph Khmer', 'color': Colors.greenAccent},
                {'id': 3, 'name': 'Chemistry Khmer', 'color': Colors.amber},
                {'id': 4, 'name': 'English', 'color': Colors.lightBlueAccent},
                {'id': 5, 'name': 'Khmer - English', 'color': Colors.deepPurpleAccent},
                {'id': 6, 'name': 'Geo Khmer', 'color': Colors.purpleAccent},
                {'id': 7, 'name': 'Text Khmer', 'color': Colors.redAccent},
              ],
            );
            break;
          case 'តែងសេចក្ដី': // "Composition"
            nextScreen = CategoryDetailScreen(categoryName: title);
            break;
          case 'រឿងនិទាន': // "Storytelling"
            nextScreen = SubjectScreen(
              subjects: [
                {'id': 1, 'name': 'Math', 'color': Colors.pinkAccent},
                {'id': 2, 'name': 'Physics', 'color': Colors.greenAccent},
                {'id': 3, 'name': 'Chemistry', 'color': Colors.amber},
                {'id': 4, 'name': 'Biology', 'color': Colors.lightBlueAccent},
                {'id': 5, 'name': 'Khmer', 'color': Colors.deepPurpleAccent},
                {'id': 6, 'name': 'Geography', 'color': Colors.purpleAccent},
                {'id': 7, 'name': 'History', 'color': Colors.redAccent},
              ],
            );
            break;
          default:
            nextScreen = Scaffold(
              body: Center(
                child: Text('No screen available for this category.'),
              ),
            );
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          _buildCategoryCard('អំណាន', context),
          _buildCategoryCard('តែងសេចក្ដី', context),
          _buildCategoryCard('រឿងនិទាន', context),
        ],
      ),
    );
  }
}

class SubjectScreen extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;

  const SubjectScreen({required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        title: const Text(
          'Subjects',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: subjects
              .map(
                (subject) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TextInputScreen(
                            subjectName: subject['name'],
                            color: subject['color'],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: subject['color'],
                          child: Text(
                            '${subject['id']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: subject['color'],
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.black54),
                            ),
                            child: Text(
                              subject['name'],
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class TextInputScreen extends StatelessWidget {
  final String subjectName;
  final Color color;

  const TextInputScreen({required this.subjectName, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          subjectName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your notes for $subjectName:',
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            TextField(
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Write here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notes saved!')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryDetailScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Center(
        child: Text(
          'Details about $categoryName',
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}



// (Add other screens like BookScreen, ExerciseScreen, and AccountScreen here)


class BookScreen extends StatelessWidget {
  Widget _buildCategoryCard(String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailScreen(categoryName: title),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Screen'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          _buildCategoryCard('ភាសាខ្មែរ', context),
          _buildCategoryCard('គណិតវិទ្យា', context),
          _buildCategoryCard('រូបវិទ្យា', context),
          _buildCategoryCard('គីមីវិទ្យា', context),
          _buildCategoryCard('ជីវវិទ្យា', context),
          _buildCategoryCard('ដំណើរវិទ្យា', context),
          _buildCategoryCard('ភូមិវិទ្យា', context),
          _buildCategoryCard('ប្រវត្តិវិទ្យា', context),
          _buildCategoryCard('ភាសាអង់គ្លេស', context),
          _buildCategoryCard('កិច្ចការខ្មែរ', context),
        ],
      ),
    );
  }
}

class ExerciseScreen extends StatelessWidget {
  Widget _buildCategoryCard(String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailScreen(categoryName: title),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Screen'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          _buildCategoryCard('ភាសាខ្មែរ', context),
          _buildCategoryCard('គណិតវិទ្យា', context),
          _buildCategoryCard('រូបវិទ្យា', context),
          _buildCategoryCard('គីមីវិទ្យា', context),
          _buildCategoryCard('ជីវវិទ្យា', context),
          _buildCategoryCard('ដំណើរវិទ្យា', context),
          _buildCategoryCard('ភូមិវិទ្យា', context),
          _buildCategoryCard('ប្រវត្តិវិទ្យា', context),
          _buildCategoryCard('ភាសាអង់គ្លេស', context),
          _buildCategoryCard('កិច្ចការខ្មែរ', context),
        ],
      ),
    );
  }
}

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _userName = 'Kheng Khey'; // Example user name
  String _profileImageUrl = 'https://raw.githubusercontent.com/aakrfja/learn-with-Khey_Math-Physics/main/IMG_6058.PNG'; // Raw profile image URL
  bool _isNotificationsEnabled = true;
  String _selectedLanguage = 'English';

  // List of available languages for the dropdown
  final List<String> _languages = ['English', 'Khmer'];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: [
          // Notification Icon
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon click (you can add your notification logic here)
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Notifications'),
                    content: Text('Here are your notifications!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          // More Options Icon (e.g., settings)
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options icon click (you can add more menu items here)
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('More Options'),
                    content: Text('Settings, Help, Logout... etc'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // Enable scrolling
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(_profileImageUrl),
                ),
                SizedBox(width: 16),
                Text(
                  _userName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Language Selection
            ListTile(
              title: Text('Language'),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
                items: _languages.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            // Notification Toggle
            ListTile(
              title: Text('Notifications'),
              trailing: Switch(
                value: _isNotificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isNotificationsEnabled = value;
                  });
                },
              ),
            ),



            // Other Settings (e.g., logout)
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Show logout dialog with options
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Are you sure you want to log out?'),
                      actions: [
                        // Cancel button (stay on the current screen)
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog and stay on the current screen
                          },
                          child: Text('Cancel'),
                        ),
                        // Logout button
                        TextButton(
                          onPressed: () {
                            // Implement logout logic here
                            Navigator.of(context).pop(); // Close the dialog
                            // You can replace the current screen with the login screen, for example:
                            // Navigate back to the login screen after logging out
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                                  (route) => false,
                            );
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
