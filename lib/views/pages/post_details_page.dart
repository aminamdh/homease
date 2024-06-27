import 'package:flutter/material.dart';
import 'package:homease/core/models/news_model.dart';
import 'package:homease/core/models/post_model.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(post.imageUrl, fit: BoxFit.cover),
              SizedBox(height: 16),
              Text(post.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(post.description),
              SizedBox(height: 16),
              Text('Price: ${post.price}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('City: ${post.city}'),
              SizedBox(height: 8),
              Text('Address: ${post.address}'),
              SizedBox(height: 8),
              Text('Bedrooms: ${post.bedroom}'),
              SizedBox(height: 8),
              Text('Bathrooms: ${post.bathroom}'),
              SizedBox(height: 16),
              Text('Features:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...post.features.map((feature) => Text('- ${feature.name}')).toList(),
              SizedBox(height: 16),
              Text('Gallery:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: post.gallery.map((image) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Image.network(image.imageUrl, width: 100, height: 100, fit: BoxFit.cover),
                  )).toList(),
                ),
              ),
              SizedBox(height: 16),
              Text('Comments:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...post.comments.map((comment) => ListTile(
                title: Text(comment.userName),
                subtitle: Text(comment.body),
              )).toList(),
              SizedBox(height: 16),
              Text('Ratings:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...post.rating.map((rating) => ListTile(
                title: Text('Rating: ${rating.rating}'),
                subtitle: Text('By User ID: ${rating.userId}'),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
