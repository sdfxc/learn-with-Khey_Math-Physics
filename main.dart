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
            case 'ដំណើរផ្សងព្រេង': // "Reading"
            nextScreen = SubjectScreen(
              subjects: [
                {'id': 1, 'name': 'English', 'color': Colors.pinkAccent},
                {'id': 2, 'name': 'Phhmer', 'color': Colors.greenAccent},
                {'id': 3, 'name': 'Chestry Khmer', 'color': Colors.amber},
                {'id': 4, 'name': 'Enlish', 'color': Colors.lightBlueAccent},
                {'id': 5, 'name': 'Khmer - English', 'color': Colors.deepPurpleAccent},
                {'id': 6, 'name': 'Gehmer', 'color': Colors.purpleAccent},
                {'id': 7, 'name': 'Text Khmer', 'color': Colors.redAccent},
              ],
            );
            break;
            case 'រឿងនិទាន': // "Reading"
            nextScreen = SubjectScreen(
              subjects: [
                {'id': 1, 'name': 'Eish', 'color': Colors.pinkAccent},
                {'id': 2, 'name': 'Ph Khmer', 'color': Colors.greenAccent},
                {'id': 3, 'name': 'istry Khmer', 'color': Colors.amber},
                {'id': 4, 'name': 'Enlish', 'color': Colors.lightBlueAccent},
                {'id': 5, 'name': 'Khmer - English', 'color': Colors.deepPurpleAccent},
                {'id': 6, 'name': 'Geomer', 'color': Colors.purpleAccent},
                {'id': 7, 'name': 'Text Khmer', 'color': Colors.redAccent},
              ],
            );
            break;
            case 'Free time': // "Reading"
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
            case 'Challenge': // "Reading"
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
            case 'Music': // "Reading"
            nextScreen = SubjectScreen(
              subjects: [
                {'id': 1, 'name': 'កំពង់ធំជំរុំចិត្ត', 'color': Colors.pinkAccent},
                {'id': 2, 'name': 'បាត់ដំបងបណ្ដូលចិត្ត', 'color': Colors.greenAccent},
                {'id': 3, 'name': 'កំពង់ចាម កំពង់ចិត្ត', 'color': Colors.amber},
                {'id': 4, 'name': 'ដងស្ទឹងសង្កែ', 'color': Colors.lightBlueAccent},
                {'id': 5, 'name': 'ស្ទឹងសែនប៉ារីស', 'color': Colors.deepPurpleAccent},
                {'id': 6, 'name': 'មនុស្សស្រីកម្រ', 'color': Colors.purpleAccent},
                {'id': 7, 'name': 'Time to Rise', 'color': Colors.redAccent},
              ],
            );
            break;
            case 'Relax': // "Reading"
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
            case 'ការស្ដាប់': // "Reading"
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
            case 'ផតខាស': // "Reading"
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
          _buildCategoryCard('ដំណើរផ្សងព្រេង', context),
          _buildCategoryCard('Free time', context),
          _buildCategoryCard('Challenge', context),
          _buildCategoryCard('Music', context),
          _buildCategoryCard('Relax', context),
          _buildCategoryCard('ការស្ដាប់', context),
          _buildCategoryCard('ផតខាស', context),
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
        title: Text('$categoryName Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            categoryName == 'តែងសេចក្ដី'
                ? "តក់ៗពេញបំពង់\n\n""សេចក្ដីអធិប្បាយ\n\n" "កិច្ចការសព្វសារពើទាំងអស់ មិនថាតូចក្តី ធំក្តី ធ្ងន់ឬស្រាល គឺសុទ្ធសឹងតែឈរនៅលើគោលជំហរមួយដ៏ច្បាស់ លាស់ គឺខិតតស៊ូអំណត់ព្យាយាមបន្តិចម្តងៗ ដោយមិនព្រមបោះបង់ចោលនូវរឺរិយាគឺសេចក្តីព្យាយាម និងអ្វីដែលខ្លួនកំពុង ធ្វើនោះឡើយ នូវទីបំផុតក៏គង់តែទទួលបានជោគជ័យដូចសេចក្តីប្រាថ្នាជាក់ជាមិនខាន ។ ដោយមើលឃើញទិដ្ឋភាព បែបនេះ ទើបដូនតាខ្មែរបុរាណលោកលើកជាសុភាសិតមួយឡើងទុកជាការទន្មានប្រៀនប្រដៅដល់កូនចៅខេមរជន ជំនាន់ក្រោយថា «តក់ៗពេញបំពង់» ។\n\n""តើសុភាសិតនេះបង្កប់នូវឧត្តមគតិនិងសារប្រយោជន៍ដូចម្តេចខ្លះ?\n\n""ដើម្បីងាយស្រួលឱ្យកាន់តែច្បាស់បន្ថែមទៀតក្នុងបកស្រាយសុភាសិតខាងលើឱ្យបានកាន់តែក្បោះក្បាយនោះ ជា បឋមខ្ញុំបាទសូមពន្យល់យល់នូវពាក្យគន្លឹះមួយចំនួនជាមុនសិន ដូចជា បំពង់ និង តក់ៗ! ជាដើម ។ពាក្យ បំពង់ នាមសព្ទ វត្ថុមានរាងមូលទ្រវែងមានប្រហោងមានមាត់ មានបាតសម្រាប់ដាក់វត្ថុផ្សេងៗ ឬវត្ថុផង់ក៏ ដាក់បាន ពិសេសគឺ សំដៅលើប្រដាប់សម្រាប់ច្រកទឹក អាចធ្វើអំពីឫស្សី ឬជ័រសម្រាប់ច្រកទឹក ជាពិសេសទឹកត្នោតតែម្តង រីឯ តក់ៗ មាន ន័យថា សួរសំឡេងស្រក់នៃទឹក។តាមរយៈភាសិតទាំងមូល គេអាចមើលន័យត្រង់ចង់សំដៅដល់តំណក់ទឹកត្នោតមួយតក់ៗ បានក្លាយជាទឹក ឆ្នោតមួយបំពង់ដ៏ពេញ ប្រៀបដូចជាការតស៊ូបន្តិចម្តងៗ ទីបំផុតក៏សម្រេចដូចបំណងប្រាថ្នា ។\n\n"" ជាការពិតណាស់ អ្នក ជោគជ័យមិនដែលបោះបង់ អ្នកបោះបង់មិនដែលជោគជ័យ គ្រប់កាងារទាំងអស់តែងតែមានឧបសគ្គជានិច្ច អ្វីដែល សំខាន់នោះគឺ ចេះអត់ទ្រាំ ស៊ូហត់នឿយ ស៊ូលំបាក តែមិនមែនមានន័យថាគេចពីការងារនោះឡើយ គឺត្រូវតែធ្វើជានិច្ចរហូតដល់ដង្ហើមចុងក្រោយនៃក្តីប្រាថ្នាតស៊ូព្យាយាម ។ ជាក់ស្តែង គេឃើញសិស្សនៅក្នុងថ្នាក់រៀន មានចំនួន ២០ ទៅ ៣០ នាក់ ប៉ុន្តែសិស្សដែលទទួលជោគជ័យគឺមានចំនួនតិចតួចបំផុត រឺឯភាគច្រើនគឺបង្គួរ មធ្យម ខ្សោយ ដែលពិបាកក្នុង ការប្រជែងជាមួយដៃគូខ្លាំងៗជុំវិញខ្លួន។ សិស្សដែលពូកែ គឺគេខិតខំតាំងពីដើមទី សន្សំរាល់ចំណេះដឹងដែលខ្លួនបានរៀន ពីគ្រូ ពីមិត្តភក្តិ ពីសាច់ញាតិ និងពីមនុស្សដែលនៅជុំវិញខ្លួន ។ អ្វីទាំងនេះគេបានក្រេបជញ្ជក់ដោយយកចិត្តទុកដាក់បំផុត ដោយមិនភ្លើតភ្លើននឹងល្បែងស្រីស្រានោះឡើយ ។ មនុស្សដែលកើតមកមិនដែលទទួលបានជោគជ័យភ្លាមៗទេ រីឯ សិស្សក៏ដូចគ្នាសុទ្ធសឹងតែពឹងលើការចេះព្យាយាមនេះឯង ចំណែកឯពាណិជ្ជករក៏ដូច្នោះដែរទម្រាំតែទទួលបានជោគជ័យ លើរបរកធ្វើការអ្វីមួយជួបឧបសគ្គនិងបរាជ័យមិនតិចនោះទេ ទើបមានពាក្យដាស់ស្មារតីមួយបានពោលថា «គ្មានកិច្ចការ អ្វីលំបាកនោះទេ ខ្លាចតែចិត្តគ្មានការជម្នះ ។ក្រៅពីនេះ គេសង្កេតឃើញអ្នកមាន ឬមហាសេដ្ឋីជាច្រើនអាចជោគជ័យទៅបានដោយសារតែពួកគេ មិនព្រម ចុះចាញ់ឧបសគ្គដែលនៅចំពោះមុខ គេបានបុកទម្លុះដោយភាពអំណត់ដ៏មុតស្រួចរបស់ខ្លួន ជាក់ស្តែងដូចជា លោក ប៊ីល ហ្គេត, លោក ជែក ម៉ា, លោក ស្ទីវ ចបស៍ អាចសម្រេចនូវសមិទ្ធផលបានដោយពួកគាត់ច្នៃប្រតិដ្ឋ និងធ្លាប់ឆ្លងកាត់នូវ បរាជ័យម្តងហើយម្តងទៀត ទីបំផុតការតស៊ូរបស់គាត់ក៏ទទួលបានលទ្ធផលគួរជាទីពេញចិត្ត និងធ្វើមនុស្សជុំវិញពិភព លោកមានការកើតសរសើររូបអស់លោកមិនដាច់ពីមាត់ និងគួរឱ្យយកតម្រាប់តាមគ្រប់វេលា ។ជាការពិតណាស់ បើគេងាកមើលក្នុងវណ្ណកម្មស្នាដៃអក្សរសិល្ប៍ខ្មែរវិញ គឺរឹតតែច្បាស់ថែមទៀត ។ តួយ៉ាងនៅ ក្នុង កុលាបប៉ៃលិន ដែលជាស្នាដៃនិពន្ធរបស់ ញ៉ុក ថែម បានឆ្លុះតាមរយៈសកម្មភាពរបស់តួអង្គចៅចិត្រ ដែលមានឋានៈ ត្រឹមតែជាកម្មករជីកត្បូង ប៉ុន្តែចៅចិត្រ ពុំដែលស្អប់ការងារឡើយ ទោះនៅក្រោមពន្លឺថ្ងៃដ៏ក្ដៅយ៉ាងណាក្តី ចៅចិត្រ ហ៊ាន លះបង់កម្លាំងពលំដើម្បីធ្វើការងារយ៉ាងអស់ពីចិត្តពីថ្លើមនិងដោយយកចិត្តទុកដាក់បំផុត ។ ជាងនេះទៅទៀត ចៅចិត្តថែមទាំងលួចស្រលាញ់នាង ឃុន នារី ដែលជាកូនចៅហ្វាយរបស់ខ្លួនទៀតផង ក្តីបំណងរបស់ចៅចិត្រពុំបានរលាយទេ ។ ទីបំផុត ចៅចិត្រក៏សម្រេចបានទាំងការងារ និងជោគជ័យទាំងរឿងស្នេហា ។ ទាំងនេះក៏សុទ្ធតែកើតចេញពីការអត់ធ្មត់ និងចេះពីរបៀបធ្វើការសន្លឹមៗតាមដំណាក់ដំបូងរហូតដល់ដំណាក់ចុងក្រោយ ដែលធ្វើឱ្យលោកហ្លួងរតនសម្បត្តិ និងនាង ឃុន នារី ពេញចិត្តយ៉ាងខ្លាំង ។យើងក្រឡេកមើលតួអង្គព្រះពោធិសត្វ កាលទ្រង់យកជាតិជាសុមេធបណ្ឌិត កាលនោះព្រះសម្មាសម្ពុទ្ធទីបង្ករ ទ្រង់ត្រាស់ដឹងក្នុងលោកសម័យកាលជាមួយគ្នានោះដែរ ព្រះពុទ្ធទីបង្ករ ទ្រង់យោនយកកំណើតជាព្រះពោធិសត្វនៅស្ថាន តុសិត ហើយដោយបានអារាធនាដោយពួកទេវតាទាំងឡាយ ក៏បានយាងចុះពីឋានតុសិតមកចាប់បដិសន្ធិក្នុងផ្ទៃ ព្រះនាង សមេធេទេវី ជាមហេសីព្រះបាទសុទេវរាជ ជាស្តេចក្នុងរម្មវតីនគរ ក្នុងថ្ងៃ១៥កើត ខែអាសាឍ។ ព្រះអង្គទ្រង់ស្ថិតក្នុង ផ្ទៃគ្រប់ទសមាស ក៏ប្រសូតិបាកគភ៌ព្រះមាតាតាមនិយាមរបស់ព្រះពោធិសត្វទាំងឡាយ គឺថ្ងៃ១៥កើតពេញបូណ៌មី ខែ ពិសាខ។ ក្រោយមកព្រះពោធិសត្វ នឿយណាយក្នុងភាពជាគ្រហស្ថ ទ្រង់ក៏ចេញសាងផ្នួសរួមជាមួយបុរស១កោដិនាក់ ។ព្រះពោធិសត្វទ្រង់ធ្វើសេចក្តីព្យាយាមអស់ចំនួន១០ខែ ។ ក្នុងថ្ងៃ១៥កើតពេញបូណ៌មី ខែពិសាខ ទ្រង់ចូលទៅ បិណ្ឌបាត ក្នុងនគរ រួមជាមួយបព្វជិតទាំងអស់ដែលចេញបយសតាមព្រះអង្គ ។ ក្នុងពេលរសៀល ទ្រង់ចូលទៅសម្រាកក្នុងសាលវ័ នជាមួយបព្វជិតទាំងអស់ ។ ពេលនោះ ព្រះពោធិសត្វទីបង្ករ គេចខ្លួនពីពួកគណៈធ្វើដំណើរទៅតែមួយព្រះអង្គឯងក៏បាន ទទួលនូវស្បូវស្តាចំនួន៨ក្តាប់ពីសុនន្ទអាជីវក ទ្រង់ក៏យកទៅក្រាលក្រោមដើមបីបួលិពោធិព្រឹក្ស (ដើមដីធ្លី) ត្រង់ផ្ចិតនៃ ផែនដី។ ទ្រង់ផ្ចាញ់នូវពួកមារព្រមទាំងសេនាមារហើយ ក្នុងបឋមយាមនៃរាត្រី ទ្រង់ចាក់ធ្លុះនូវបុព្វេនិវាសានុស្សតិញ្ញាណ ក្នុងមជ្ឈិមយាមនៃរាត្រី ទ្រង់បានចាក់ធ្លុះនូវចុតូបបាតញ្ញាណ ក្នុងបច្ឆិមយាមនៃរាត្រី ទ្រង់បានអស់ទៅនៃអាសវក្កិលេសពី ខន្ធសន្តាន ។ក្នុងពេលនោះឯង សុមេធតាបស កំពុងហោះតាមអាកាស បានឃើញមនុស្សទាំងឡាយ មានចិត្តរីករាយកំពុងចាត់ ចែងការងារ តាក់តែងទីក្រុង ក៏ចុះពីអាកាស ហើយសាកសួរមនុស្សទាំងឡាយនោះថា «ការតាក់តែងទីក្រុងដ៏ប្លែកអស្ចារ្យ នេះ តើដើម្បីប្រយោជន៍ និងកិត្តិសយដល់បុគ្គលណា?មនុស្សទាំងនោះឆ្លើយថា «យើងនាំគ្នារៀបចំលម្អទីក្រុងនេះ ដើម្បីទទួលព្រះពុទ្ធជាម្ចាស់ដែលទ្រង់បានត្រាស់ដឹង ឡើងក្នុងលោក ! ។សុមេធបណ្ឌិតក៏គិតឡើងថា សូម្បីត្រឹមតែឮពាក្យថា ពុទ្ធោ ជាពាក្យដ៏កម្រនៅក្នុងលោក មិនចាំបាច់ពោលទៅថ្មី ដល់កាលមានភាពជាព្រះពុទ្ធ ។ បើដូច្នោះ មានតែអាត្មាអញនឹងចាត់ចែងផ្លូវដើម្បីទទួលព្រះទសពលអង្គនោះដែរ ។ ពេល នោះ សុមេធបណ្ឌិតក៏បាននិយាយសុំផ្លូវមួយចំណែកសម្រាប់ខ្លួនចាត់ចែង មនុស្សទាំងនោះក៏បានទុកឱកាសដល់សុមេធ បណ្ឌិតនូវជង្ហុកដែលមានទឹក ច្រើន ដោយយល់ឃើញថា សមេធតាបសនេះជាអ្នកមានឫទ្ធិច្រើន គួរនឹងអាចធ្វើបាន យ៉ាងងាយដោយឫទ្ធិរបស់លោក ។សុមេធតាបស មានព្រះពុទ្ធជាអារម្មណ៍ បានចាត់ចែងផ្លូវនោះដោយកម្លាំងកាយធម្មតា ដោយគិតថា «ប្រសិនបើ អាត្មាអញធ្វើទីនេះដោយឫទ្ធិ ហាក់បីដូចជាមិនសមគួរសម្រាប់បូចាដល់ព្រះពុទ្ធជាម្ចាស់ឡើយ។កាលនោះ សុមេធបណ្ឌិតនៅមិនទាន់បានធ្វើផ្លូវហើយផង ស្រាប់តែព្រះពុទ្ធទីបង្ករ ព្រះទាំងព្រះអរហន្ត៤សែនអង្គ និមន្តមកដល់ ។ សុមេធបណ្ឌិតសម្លឹងឃើញព្រះពុទ្ធទីបង្ករ ដោយភ្នែកទាំងគូ ដែលមានមហាបុរិសលក្ខណៈ៣២ប្រការ អនុព្យញ្ជនៈ៨០ ពន្លឺ១ព្យាម ផ្សាយចេញពីព្រះវរកាយ មានពុទ្ធរស្មី ឆព្វណ្ណរស្មី (៦ពណ៌) ។ សុមេធបណ្ឌិតមានសេចក្តីជ្រះថ្លា ធ្វើទុកក្នុងចិត្តថា «ថ្ងៃ នេះអាត្មាអញនឹងបរិច្ចាគជីវិតថ្វាយព្រះទសពល សូមព្រះមានព្រះភាគ កុំនិមន្តជាន់ភក់ អត្មាអញ នឹងធ្វើជាស្ពានចម្លងព្រះមានព្រះភាគ និងព្រះសង្ឃគ្រប់ព្រះអង្គឆ្លងកាត់ដើម្បីសេចក្តីចម្រើនដើម្បី សេចក្តីសុខសម្រាប់ អាត្មាអញ !» ។ រ រំពេចនោះសុមេធបណ្ឌិតរំសាយផ្នួងសក់ ហើយក្រាលនូវសំពត់សម្បកឈើ ព្រមទាំងស្បែកសត្វលើភក់ ពណ៌ខ្មៅ ហើយក្រាបចុះលើភក់ធ្វើជាស្ពានថ្វាយព្រះសម្មាសម្ពុទ្ធ ។ កាលសុមេធបណ្ឌិតបានសម្លឹងឃើញនូវពុទ្ធសិរីរបស់ ព្រះពុទ្ធទីបង្ករទសពល លោកក៏ពិចារណគិតក្នុងចិត្តថា បើអាត្មា អញប្រាថ្នាផុតកិលេសរបស់អាត្មាអញក្នុងថ្ងៃនេះ ក៏បានតែថាប្រយោជន៍អ្វី អាត្មាអញធ្វើឱ្យជាក់ច្បាស់នូវធម៌ដោយភេទដែលគេមិនស្គាល់ក្នុង ទីនេះ! អាត្មាអញគប្បីដល់នូវ សព្វញ្ញុតញ្ញាណជាអ្នករួចស្រឡះចាកកិលេស ហើយញ៉ាំងលោកព្រមទាំងទេវលោកឱ្យរួចចាកសង្សារវដ្ត! ប្រយោជន៍អ្វី អាត្មាអញ ជាបុរសសម្តែងកម្លាំងឆ្លងទោះបីតែម្នាក់ឯង អាត្មាអញគួរដល់នូវសព្វញ្ញុតញ្ញាណ ចម្លងមនុស្សលោក ព្រមទាំង ទេវលោក ។ អាត្មាអញនឹងបានដល់នូវសព្វញ្ញុតញ្ញាណ ចម្លងប្រជុំជនច្រើនដោយអធិការនេះដែលអាត្មាអញធ្វើចំពោះព្រះ ពុទ្ធ ជាមហាបុរសដ៏ខ្ពង់ខ្ពស់បំផុត !។ក្នុងកាលនោះ មាននាងយុវតីម្នាក់ជាកូនព្រាហ្មណ៍ឈ្មោះ សុមិត្តា នៅក្នុងទីប្រជុំមហាជន ក៏មានចិត្តជ្រះថ្លាចំពោះ កិរិយាធ្វើរបស់សុមេធបណ្ឌិតក៏បានយកផ្កាឧប្បល៨ក្តាប់ ចូលទៅជិតសុមេធបណ្ឌិត ហើយពោលថា «បពិត្រ ឥសី ខ្ញុំមិន ឃើញវត្ថុដទៃគួរថ្វាយទេ ខ្ញុំសូមថ្វាយផ្កាទាំងលាយដល់លោក។ បពិត្រឥសី ផ្កា៥ក្តាប់ ចូរមានដល់លោក ផ្កា៣ក្តាប់ ចូរ មានដល់ខ្ញុំ សម្រាប់ថ្វាយព្រះសម្មាសម្ពុទ្ធ ។ បពិត្រឥសី ខ្ញុំសូមឱ្យមានអនិសង្សស្មើគ្នាមួយអន្លើ ដើម្បីជាប្រយោជន៍ពោធិ ញ្ញាណដល់លោកចុះ ។ រីឯខ្ញុំវិញ ខ្ញុំសូមស្ម័គ្រចិត្តជួយបំពេញបារមីរបស់លោក ទោះបីជាមានសេចក្តីលំបាកយ៉ាងណានៅ ក្នុងសង្សារវដ្ត ក៏ខ្ញុំសុខចិត្តព្រមដែរ សូមឲ្យនាងខ្ញុំបានជាកន្សៃសារពេជ្ររបស់លោកផង។ពេលនោះ សុមេធតាបសបានទទួលយកផ្កាឧប្បលចំនួន៥ដើម ចូលទៅក្រាបថ្វាយបង្គំព្រះពុទ្ធទីបង្ករ ហើយបូជា ថ្វាយចំពោះព្រះសម្មាសម្ពុទ្ធអង្គនោះ។ ចំណែកនាងសុមិត្តា យកផ្ការបស់ខ្លួនចំនួន៣ដើម ចូលទៅថ្វាយចំពោះព្រះ សម្មាសម្ពុទ្ធអង្គនោះដែរ។ បន្ទាប់ពីការថ្វាយផ្កាហើយ សុមេធបណ្ឌិតលើកដៃប្រណម្យអញ្ជលីបញ្ចេញសំឡេងដ៏ក្រអៅ ក្រអូនប្រាថ្នា នូវភាពជាព្រះពុទ្ធចំពោះព្រះភ័ក្ត្រព្រះពុទ្ធជាម្ចាស់ថា «បពិត្រ ព្រះអង្គដ៏ចម្រើន ដោយអំណាចអធិការដែលខ្ញុំ ព្រះអង្គបំពេញហើយមានប្រមាណប៉ុណ្ណោះ ខ្ញុំព្រះអង្គសូមប្រាថ្នាឱ្យបានត្រាស់ជាព្រះពុទ្ធក្នុងលោកព្ធដ៏ អនាគតកាល ដូច ព្រះអង្គបានត្រាស់ដឹងហើយ នាបច្ចុប្បន្ននេះផងចុះ» ។នៅពេលនោះ ព្រះពុទ្ធទីបង្ករទ្រង់គង់នៅជិតសីលៈរបស់សុមេធបណ្ឌិតទ្រង់ពិចារណា ដោយអនាវរណញ្ញាណ ឃើញថា សេចក្តីប្រាថ្នានេះមិនមានអ្វីជាគ្រឿងរារាំងឡើយ ហើយព្រះអង្គទ្រង់ញាញច្បាស់ថា សុមេធបណ្ឌិតនឹងបាន ត្រាស់ជាព្រះពុទ្ធពិតប្រាកដក្នុងលោក ទើបព្រះអង្គទ្រង់ព្យាករថា «ម្នាលភិក្ខុទាំង ឡាយ អ្នកទាំងឡាយ ចូរមើលតាបសនេះ ជាជដិលមានតបៈដ៏ខ្ពង់ខ្ពស់ តាបសនេះនឹងបានត្រាស់ជាព្រះពុទ្ធក្នុងលោកក្នុងកប្បប្រមាណ មិនបានអំពីកប្បនេះទៅ ។ សត្វនេះនឹងចេញចាកក្រុងឈ្មោះ កបិលវត្ថុ ជាទីរីករាយ តម្កល់ព្យាយាមធ្វើទុក្ករកិរិយា ។ សត្វនេះអង្គុយទៀបគល់អជបា លព្រឹក្ស ទទួលមធុបាយាសដែលនាងសុជាតា ថ្វាយក្នុងទីនោះ នឹងចូលទៅកាន់ស្ទឹងនេរញ្ជរាហើយនឹងត្រលប់មកតាមផ្លូវ ដែលគេតាក់តែងយ៉ាងប្រសើរ ប្រសើរ ។ ។ បន្ទាប់មក បន្ទាបមក សត្វនេះអង្គុយទៀបគល់ពោធិព្រឹក្ស សត្វនេះអង្គុយទេ លំដាប់នោះ តាបសមានយសធំនេះ ធ្វើ ប្រទក្សិណពោធិមណ្ឌល នឹងបានត្រាស់ដឹងនូវអនុត្តរសម្មាសម្ពោធិញ្ញាណ ទៀបគល់អស្សត្ថព្រឹក្ស ។ ព្រះជនិកាមាតារបស់ តាបសនោះនឹងមាននាមថា ព្រះនាងមហាមាយាទេវី ព្រះបិតាព្រះនាម សុទ្ធោទនៈ រីឯតាបសនេះនឹងមានឈ្មោះថា ព្រះ គោតម អគ្គសាវ័កទាំងពីររូបគឺ ឧបតិស្សៈ១ កោលិតៈ១ ជាអ្នកមិនមានអសវៈ ប្រាសចាករាគៈ មានចិត្តស្ងប់រម្ងាប់ មានចិត្តខ្ជាប់ខ្ជួន ។ ភិក្ខុជាឧបដ្ឋាកឈ្មោះ អានន្ទ នឹងបម្រើព្រះជិនស្រីអង្គនេះ។ អគ្គសាវិកាពីររូបគឺ នាងទេមា១ ឧប្បលវណ្ណា១ ជា អ្នកមិនមានអាសវៈ ប្រាសចាករាគៈ មានចិត្តស្ងប់រម្ងាប់ មានចិត្តខ្ជាប់ខ្ជួន។ ដើមឈើជាទីត្រាស់ដឹងរបស់ព្រះដ៏មានព្រះ ភាគនោះហៅថា អស្សត្ថព្រឹក្ស ឯឧបាសកជាឧបដ្ឋាកដ៏ប្រសើរពីររូបគឺ ចិត្តៈ១ ហត្ថឡវកៈ១។ នាងនន្ទមាតា និងឧត្តរា ជា ឧបដ្ឋាយិកាដ៏ប្រសើរនៃព្រះគោតមមានយសនោះ» ។ ពេលទទួលបានពាក្យព្យាករណ៍នេះ សុមេធបណ្ឌិតបានតាំងចិត្ត ព្យាយាម សមាទានធ្វើវិរិយបារមីមិនដាច់ ដោយអំណាចនៃការតស៊ូព្យាយាមនេះហើយសុមេធតាបសបានត្រាស់ជាព្រះ ពុទ្ធនាមគោតមនៅក្នុងអនាគតជាតិពិតប្រាកដ ។\n\n""យោងតាមការបកស្រាយនិងអត្ថាធិប្បាយខាងលើ សរបញ្ជាក់ឱ្យយើងឃើញកាន់តែច្បាស់ថា រាល់កិច្ចការ ឬផែន ការអ្វីក៏ដោយ ត្រូវធ្វើទៅតាមដំណាក់កាល ចាប់ផ្តើមពីដំបូងបំផុត សន្លឹម មិនប្រញាប់ពេក ទើបទទួលផ្លែផ្កាគួរជាទីជាប់ ចិត្ត ។\n\n""តាមរយៈការពន្យល់របស់ខ្ញុំបាទខាងលើនេះ អាចធ្វើសេចក្តីសន្និដ្ឋានបានថា សុភាសិតនេះពិតជាបង្កប់នូវតម្លៃ អប់រំយ៉ាងច្រើន ដែលបណ្តុះគំនិតឱ្យមនុស្សគ្រប់រូបចេះប្រុងប្រយ័ត្ន និងចេះអត់ធ្មត់ក្នុងកិច្ចការទាំងឡាយ ។ ក្នុងនាមជា អ្នកសិក្សា ក៏ដូចជាប្រជាពលដែលកម្ពុជរដ្ឋទាំងមូល គួរគប្បីចេះប្រឹងប្រែងរៀនសូធ្យ និងចេះធ្វើការងារដោយការតាំង ចិត្តខ្ពស់ នោះនឹងមិនមានវិប្បដិសារីក្នុងជីវិតឡើយ ។"
                : 'Details for $categoryName will be displayed here.',
            style: TextStyle(fontSize: 18, height: 1.5), // Adjust height for better readability
            textAlign: TextAlign.justify,
          ),
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
