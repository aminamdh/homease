import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:homease/views/pages/account.dart';
import 'package:homease/views/pages/complaints.dart';
import 'package:homease/views/pages/messages.dart';
import 'package:homease/views/pages/reminder.dart';
import 'package:homease/views/pages/market.dart';  // Importez votre page de marché ici
import 'package:homease/core/models/news_model.dart';
import 'package:homease/views/widgets/text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearchActive = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = [
      Post(
        title: 'News Title 1',
        content: 'News Content 1',
        imageUrl: 'assets/images/news_0.jpg',
      ),
      Post(
        title: 'News Title 2',
        content: 'News Content 2',
        imageUrl: 'assets/images/news_1.jpg',
      ),
      Post(
        title: 'News Title 3',
        content: 'News Content 3',
        imageUrl: 'assets/images/news_2.jpg',
      ),
      Post(
        title: 'News Title 4',
        content: 'News Content 4',
        imageUrl: 'assets/images/news_3.jpg',
      ),
      Post(
        title: 'News Title 5',
        content: 'News Content 5',
        imageUrl: 'assets/images/news_4.jpg',
      ),
    ];

    final List<String> carouselImages = [
      'assets/images/pic1.jpg',
      'assets/images/pic2.jpg',
      'assets/images/pic3.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: _isSearchActive
            ? TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _isSearchActive = false;
                        _searchController.clear();
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  // Implement search functionality
                },
              )
            : Header2(txt: 'Home', clr: AppTheme.primaryColor),
        actions: [
          if (!_isSearchActive)
            IconButton(
              icon: Icon(Icons.search, color: AppTheme.primaryColor),
              onPressed: () {
                setState(() {
                  _isSearchActive = true;
                });
              },
            ),
          IconButton(
            icon: Icon(Icons.notifications, color: AppTheme.primaryColor),
            onPressed: () {
              // Add your notification action here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Faded line between AppBar and body
          Container(
            height: 1.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.0),
                  AppTheme.primaryColor.withOpacity(0.5),
                  AppTheme.primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          CarouselSlider(
            items: carouselImages.map((image) {
              return Image.asset(image, fit: BoxFit.cover);
            }).toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: MediaQuery.of(context).size.width / 100,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 20),
          Header3(
            txt: 'Latest News',
            clr: AppTheme.primaryColor,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(post.imageUrl),
                  ),
                  title: Header3(txt: post.title),
                  subtitle: Header4(txt: post.content),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Header3(txt: post.title),
                        content: Header4(txt: post.content),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Header4(
                              txt: 'Close',
                              clr: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(  // Ajoutez ce nouvel item
            icon: ImageIcon(
              AssetImage('assets/icons/market.png'),
            ),
            label: 'Market',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Handle Home page
              break;
            case 1:
              Get.to(() => ComplaintPage());
              break;
            case 2:
              Get.to(() => MessagesPage());
              break;
            case 3:
              Get.to(() => ReminderPage());
              break;
            case 4:
              Get.to(() => AccountSettingsPage());
              break;
            case 5:  // Nouveau cas pour la page du marché
              Get.to(() => MarketplacePage());
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
