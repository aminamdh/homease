import 'package:flutter/material.dart';
import 'package:homease/core/models/post_model.dart';

class PostSearchDelegate extends SearchDelegate<Post?> {
  final List<Post> posts;

  PostSearchDelegate(this.posts);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = posts.where((post) => post.title.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final post = results[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.description),
          onTap: () {
            close(context, post);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = posts.where((post) => post.title.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final post = suggestions[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.description),
          onTap: () {
            query = post.title;
            showResults(context);
          },
        );
      },
    );
  }
}
