import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homease/core/config/design/theme.dart';
import 'package:homease/core/controllers/auth_controller.dart';
import 'package:homease/core/models/post_model.dart';
import 'package:homease/core/services/api_service.dart';
import 'package:homease/views/pages/home.dart';
import 'package:homease/views/pages/login.dart';
import 'package:homease/views/pages/post_details_page.dart';
import 'package:homease/views/pages/post_search_delegate.dart';
import 'package:homease/views/widgets/text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final AuthController? authController = Get.find<AuthController>();
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
  List<Post> posts = [];
  List<Post> filteredPosts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _searchController.addListener(_filterPosts);
  }

  Future<void> _fetchPosts() async {
    try {
      ApiService apiService = ApiService();
      List<Post> fetchedPosts = await apiService.fetchPosts();
      print('Fetched Posts: $fetchedPosts'); // Debug print
      setState(() {
        posts = fetchedPosts;
        filteredPosts = fetchedPosts;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching posts: $e'); // Debug print
      setState(() {
        isLoading = false;
      });
      // Show an error message to the user
      Get.snackbar('Error', 'Failed to load posts: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _filterPosts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredPosts = posts.where((post) {
        final titleLower = post.title.toLowerCase();
        final descriptionLower = post.description.toLowerCase();
        return titleLower.contains(query) || descriptionLower.contains(query);
      }).toList();
    });
  }

  void _navigateToPost(Post post) {
    Get.to(() => PostDetailScreen(post: post));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header2(txt: 'marketplace'.tr, clr: AppTheme.primaryColor),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppTheme.primaryColor),
            onPressed: () async {
              final selectedPost = await showSearch<Post?>(
                context: context,
                delegate: PostSearchDelegate(posts),
              );
              if (selectedPost != null) {
                _navigateToPost(selectedPost);
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : posts.isEmpty
              ? Center(child: Text('No posts available')) // Display message if no posts
              : Column(
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredPosts.length,
                        itemBuilder: (context, index) {
                          final post = filteredPosts[index];
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (post.gallery.isNotEmpty)
                                    Container(
                                      height: 200,
                                      child: PageView.builder(
                                        controller: _pageController,
                                        itemCount: post.gallery.length,
                                        itemBuilder: (context, imageIndex) {
                                          return Image.network(
                                            post.gallery[imageIndex].imageUrl,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  if (post.gallery.length > 1)
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(top: 10),
                                      child: SmoothPageIndicator(
                                        controller: _pageController,
                                        count: post.gallery.length,
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
                                    txt: post.description,
                                    clr: AppTheme.black,
                                  ),
                                  SizedBox(height: 10),
                                  Header4(
                                    txt: 'contact_us'.tr,
                                    clr: AppTheme.black,
                                  ),
                                  Header4(
                                    txt: '${'email'.tr} ${post.comments.isNotEmpty ? post.comments.first.user.email : 'N/A'}',
                                    clr: AppTheme.black,
                                  ),
                                  Header4(
                                    txt: '${'phone'.tr} ${post.comments.isNotEmpty ? post.comments.first.user.phone : 'N/A'}',
                                    clr: AppTheme.black,
                                  ),
                                  SizedBox(height: 10),
                                  Header4(
                                    txt: '${'price'.tr} \$${post.price}',
                                    clr: AppTheme.primaryColor,
                                  ),
                                  SizedBox(height: 10),
                                  Header4(
                                    txt: '${'city'.tr} ${post.city}',
                                    clr: AppTheme.black,
                                  ),
                                  Header4(
                                    txt: '${'address'.tr} ${post.address}',
                                    clr: AppTheme.black,
                                  ),
                                  Header4(
                                    txt: '${'bedroom'.tr} ${post.bedroom}',
                                    clr: AppTheme.black,
                                  ),
                                  Header4(
                                    txt: '${'bathroom'.tr} ${post.bathroom}',
                                    clr: AppTheme.black,
                                  ),
                                  if (post.features.isNotEmpty)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: post.features.map((feature) {
                                        return Header4(
                                          txt: '${'feature'.tr} ${feature.name}',
                                          clr: AppTheme.black,
                                        );
                                      }).toList(),
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
