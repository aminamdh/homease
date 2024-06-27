import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:homease/views/pages/account.dart';
import 'package:homease/views/pages/complaints.dart';
import 'package:homease/views/pages/messages.dart';
import 'package:homease/views/pages/reminder.dart';
import 'package:homease/views/pages/market.dart';
import 'package:homease/core/models/news_model.dart'; // Updated import
import 'package:homease/views/widgets/text.dart';
import 'package:homease/core/services/api_service.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<News>> _newsFuture; // Updated variable name
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _newsFuture = ApiService().fetchNews(); // Updated method call
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      //'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      'Notification Body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> carouselImages = [
      'assets/images/pic1.jpg',
      'assets/images/pic2.jpg',
      'assets/images/pic3.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'home'.tr, clr: AppTheme.primaryColor),
        actions: [
          IconButton(
            icon: Icon(Icons.storefront, color: AppTheme.primaryColor),
            onPressed: () {
              Get.to(() => MarketplacePage());
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: AppTheme.primaryColor),
            onPressed: _showNotification,
          ),
        ],
      ),
      body: Column(
        children: [
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
            txt: 'latest_news'.tr,
            clr: AppTheme.primaryColor,
          ),
          Expanded(
            child: FutureBuilder<List<News>>( // Updated generic type
              future: _newsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No news available.'));
                } else {
                  final newsList = snapshot.data!;
                  return ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      final news = newsList[index];
                      return Card(
                        margin: EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(news.imageUrl),
                          ),
                          title: Header3(txt: news.title.tr),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person, size: 16, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Header4(txt: news.user.name),
                                  SizedBox(width: 10),
                                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Header4(txt: timeago.format(news.createdAt)),
                                  SizedBox(width: 10),
                                  Icon(Icons.visibility, size: 16, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Header4(txt: '${news.viewCount}'),
                                ],
                              ),
                              SizedBox(height: 10),
                              Header4(txt: news.body.tr),
                            ],
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Header3(txt: news.title.tr),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(news.imageUrl),
                                      SizedBox(height: 10),
                                      Html(data: news.body),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(Icons.person, size: 16, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Header4(txt: news.user.name),
                                          SizedBox(width: 10),
                                          Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Header4(txt: timeago.format(news.createdAt)),
                                          SizedBox(width: 10),
                                          Icon(Icons.visibility, size: 16, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Header4(txt: '${news.viewCount}'),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Header4(txt: news.user.about),
                                      TextField(
                                        controller: _commentController,
                                        decoration: InputDecoration(
                                          labelText: 'Add a comment',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Header4(
                                      txt: 'close'.tr,
                                      clr: AppTheme.primaryColor,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      if (_commentController.text.isNotEmpty) {
                                        await ApiService().addComment(news.id, _commentController.text); // Updated method call
                                        _commentController.clear();
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Header4(
                                      txt: 'post'.tr,
                                      clr: AppTheme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
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
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'complaints'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'messages'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'reminders'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'account'.tr,
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
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
          }
        },
      ),
    );
  }
}
