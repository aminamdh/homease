import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/models/post_model.dart';
import 'package:homease/views/pages/home.dart';
import 'package:homease/views/pages/login.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/auth_controller.dart';
import 'package:homease/views/widgets/text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MarketplacePage extends StatelessWidget {
  final AuthController? authController = Get.find<AuthController>();

  final List<Post> posts = [
    Post(
      images: ['assets/images/pic4.jpg'],
      title: 'House 1',
      subtitle: 'Beautiful house in the city center.',
      email: 'contact@house1.com',
      phoneNumber: '123-456-7890',
      price: '\$300,000',
    ),
    Post(
      images: ['assets/images/pic5.jpg'],
      title: 'House 2',
      subtitle: 'Cozy house in the suburbs.',
      email: 'contact@house2.com',
      phoneNumber: '098-765-4321',
      price: '\$250,000',
    ),
    Post(
      images: ['assets/images/pic7.jpg', 'assets/images/pic6.jpg'],
      title: 'House 3',
      subtitle: 'Luxurious house with a garden.',
      email: 'contact@house3.com',
      phoneNumber: '111-222-3333',
      price: '\$500,000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'Marketplace', clr: AppTheme.primaryColor),
        
        
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
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (post.images.isNotEmpty)
                          Container(
                            height: 200,
                            child: PageView.builder(
                              itemCount: post.images.length,
                              itemBuilder: (context, imageIndex) {
                                return Image.asset(
                                  post.images[imageIndex],
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        if (post.images.length > 1)
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 10),
                            child: SmoothPageIndicator(
                              controller: PageController(),
                              count: post.images.length,
                              effect: WormEffect(
                                dotHeight: 8.0,
                                dotWidth: 8.0,
                                activeDotColor: AppTheme.primaryColor,
                                dotColor: AppTheme.primaryColor.withOpacity(0.5),
                              ),
                            ),
                          ),
                        SizedBox(height: 10),
                        Header4(
                          txt: post.title,
                          clr: AppTheme.black,
                        ),
                        SizedBox(height: 5),
                        Header4(
                          txt: post.subtitle,
                          clr: AppTheme.black,
                        ),
                        SizedBox(height: 10),
                        Header4(
                          txt: 'Contact Us:',
                          clr: AppTheme.black,
                        ),
                        Header4(
                          txt: 'Email: ${post.email}',
                          clr: AppTheme.black,
                        ),
                        Header4(
                          txt: 'Phone: ${post.phoneNumber}',
                          clr: AppTheme.black,
                        ),
                        SizedBox(height: 10),
                        Header4(
                          txt: 'Price: ${post.price}',
                          clr: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (authController?.isLoggedIn ?? false) {
            Get.to(() => HomePage());
          } else {
            Get.to(() => Login());
          }
        },
        child: Icon(Icons.home, color: AppTheme.primaryColor),
      ),
    );
  }
}
