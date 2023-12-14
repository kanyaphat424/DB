import 'package:carecare/min/control.dart';
import 'package:carecare/min/detail.dart';
import 'package:carecare/min/work.dart';
import 'package:carecare/mind/loginscreen.dart';
import 'package:flutter/material.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      drawer: NavigationDrawer(),
       
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                /*decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
*/
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(27),
                      bottomRight: Radius.circular(27),
                    ),
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Admin CareClean",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                     
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        
                        ),
                      
                    ],
                  ),
                ),
              ),
              
             
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryCard1(
                    image: 'assets/schedule.png',
                    title: 'ตารางงาน',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryCard2(
                    image: 'assets/review.png',
                    title: 'การจัดการลูกค้า',
                  ),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryCard3(
                    image: 'assets/id.png',
                    title: 'รายละเอียดลูกค้า',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
 floatingActionButtonLocation:
  FloatingActionButtonLocation.startTop, // ตำแหน่งของ FAB
 floatingActionButton: Align(
  alignment: Alignment(0.85, -0.96),// ตำแหน่งด้านขวาบน
  child: FloatingActionButton(
    onPressed: () {
      _scaffoldKey.currentState!.openDrawer();
    },
    child: Icon(Icons.menu),
    backgroundColor: Color.fromARGB(255, 115, 188, 237),
            elevation: 0.0, 
    ),
  ),
   /* FloatingActionButtonLocation.startTop, // ตำแหน่งของ FAB
        floatingActionButton: Align(
          alignment: Alignment(0.85, -0.96), // ตำแหน่งด้านขวาบน
          child: FloatingActionButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Icon(Icons.menu),
            backgroundColor: Color.fromARGB(255, 115, 188, 237),
            elevation: 0.0, 
          ),
        ), */
     
    );
  }
}

class NavigationDrawer extends StatelessWidget {
 const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItem(context),
            ],
          ),
        ),
      );

 Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );
  Widget buildMenuItem(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: Colors.blue,
                size: 35,
              ),
              title: const Text('Home',style: TextStyle(fontSize: 20, color: Colors.black),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AdminPage();
        }));
              },
            ),
            const Divider(
              height: 5,
              thickness: 1,
            ),
          
            const SizedBox(height: 30),
     ListTile(
              leading: const Icon(
                Icons.door_front_door_outlined,
                color: Colors.redAccent,
                size: 35,
              ),
              title: const Text(
                'ออกจากระบบ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
             onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
          return loginscreen();
        }));
              },
            ),
            const Divider(
              height: 5,
              thickness: 1,
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
}

class CategoryCard1 extends StatefulWidget {
  final String image;
  final String title;

  CategoryCard1({required this.image, required this.title});

  @override
  _CategoryCard1State createState() => _CategoryCard1State();
}

class _CategoryCard1State extends State<CategoryCard1> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => workpage(), // ส่งค่า title ไปยัง AdminPage1
            ),
          );
        },
        child: Column(
          children: [
            Container(
              color: Colors.white, // Set background color to white
              width: 350, // Set the width to the desired width
              height: 150,
              child: Image.asset(
                widget.image,
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard2 extends StatefulWidget {
  final String image;
  final String title;

  CategoryCard2({required this.image, required this.title});

  @override
  _CategoryCard2State createState() => _CategoryCard2State();
}

class _CategoryCard2State extends State<CategoryCard2> {
   @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => controlpage(), // ส่งค่า title ไปยัง AdminPage1
            ),
          );
        },
        child: Column(
          children: [
            Container(
              color: Colors.white, // Set background color to white
              width: 350, // Set the width to the desired width
              height: 150,
              child: Image.asset(
                widget.image,
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/* @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // Set elevation to 0 to remove the shadow
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => trollpage(),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set background color to white
                borderRadius: BorderRadius.circular(10.0), // Set border radius as needed
                border: Border.all(
                  color: Color.fromARGB(255, 175, 180, 183),// Set the border color
                  width: 1.0, // Set the border width
                ),
              ),
              width: 350, // Set the width to the desired width
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  widget.image,
                  width: 150,
                  height: 130,
                ),
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  } 
  */


class CategoryCard3 extends StatefulWidget {
  final String image;
  final String title;

  CategoryCard3({required this.image, required this.title});

  @override
  _CategoryCard3State createState() => _CategoryCard3State();
}

class _CategoryCard3State extends State<CategoryCard3> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => detailpage(), // ส่งค่า title ไปยัง AdminPage1
            ),
          );
        },
        child: Column(
          children: [
            Container(
              color: Colors.white, // Set background color to white
              width: 350, // Set the width to the desired width
              height: 150,
              child: Image.asset(
                widget.image,
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}