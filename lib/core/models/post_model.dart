class Post {
  final int id;
  final String title;
  final String slug;
  final int price;
  final int featured;
  final String purpose;
  final String type;
  final String image;
  final int bedroom;
  final int bathroom;
  final String city;
  final String citySlug;
  final String address;
  final int area;
  final int agentId;
  final String description;
  final String video;
  final String floorPlan;
  final String locationLatitude;
  final String locationLongitude;
  final String nearby;
  final String createdAt;
  final String updatedAt;
  final String imageUrl;
  final String floorPlanUrl;
  final double averageRating;
  final List<Gallery> gallery;
  final List<Feature> features;
  final List<Comment> comments;
  final List<Rating> rating;

  Post({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.featured,
    required this.purpose,
    required this.type,
    required this.image,
    required this.bedroom,
    required this.bathroom,
    required this.city,
    required this.citySlug,
    required this.address,
    required this.area,
    required this.agentId,
    required this.description,
    required this.video,
    required this.floorPlan,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.nearby,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.floorPlanUrl,
    required this.averageRating,
    required this.gallery,
    required this.features,
    required this.comments,
    required this.rating,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    double? avgRating = json['average_rating'] is int
        ? (json['average_rating'] as int).toDouble()
        : json['average_rating'] is double
            ? json['average_rating']
            : null;

    return Post(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      price: json['price'],
      featured: json['featured'],
      purpose: json['purpose'],
      type: json['type'],
      image: json['image'],
      bedroom: json['bedroom'],
      bathroom: json['bathroom'],
      city: json['city'],
      citySlug: json['city_slug'],
      address: json['address'],
      area: json['area'],
      agentId: json['agent_id'],
      description: json['description'],
      video: json['video'],
      floorPlan: json['floor_plan'],
      locationLatitude: json['location_latitude'],
      locationLongitude: json['location_longitude'],
      nearby: json['nearby'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageUrl: json['image_url'],
      floorPlanUrl: json['floor_plan_url'],
      averageRating: avgRating ?? 0.0,
      gallery: (json['gallery'] as List)
          .map((item) => Gallery.fromJson(item))
          .toList(),
      features: (json['features'] as List)
          .map((item) => Feature.fromJson(item))
          .toList(),
      comments: (json['comments'] as List)
          .map((item) => Comment.fromJson(item))
          .toList(),
      rating: (json['rating'] as List)
          .map((item) => Rating.fromJson(item))
          .toList(),
    );
  }
}

class Gallery {
  final int id;
  final int propertyId;
  final String name;
  final String size;
  final String createdAt;
  final String updatedAt;
  final String imageUrl;

  Gallery({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'],
      propertyId: json['property_id'],
      name: json['name'],
      size: json['size'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageUrl: json['image_url'],
    );
  }
}

class Feature {
  final int id;
  final String name;
  final String slug;

  Feature({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class Comment {
  final int id;
  final String body;
  final int commentableId;
  final String commentableType;
  final int userId;
  final int parent;
  final int? parentId;
  final int approved;
  final String createdAt;
  final String updatedAt;
  final String userName;
  final User user;

  Comment({
    required this.id,
    required this.body,
    required this.commentableId,
    required this.commentableType,
    required this.userId,
    required this.parent,
    this.parentId,
    required this.approved,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      body: json['body'],
      commentableId: json['commentable_id'],
      commentableType: json['commentable_type'],
      userId: json['user_id'],
      parent: json['parent'],
      parentId: json['parent_id'],
      approved: json['approved'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userName: json['user_name'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final int roleId;
  final String name;
  final String username;
  final String email;
  final String image;
  final String about;
  final String? lastname;
  final String? dateOfBirth;
  final String? position;
  final String? salary;
  final String? startDate;
  final String? phone;
  final String? address;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.roleId,
    required this.name,
    required this.username,
    required this.email,
    required this.image,
    required this.about,
    this.lastname,
    this.dateOfBirth,
    this.position,
    this.salary,
    this.startDate,
    this.phone,
    this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      roleId: json['role_id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      image: json['image'],
      about: json['about'],
      lastname: json['lastname'],
      dateOfBirth: json['date_of_birth'],
      position: json['position'],
      salary: json['salary'],
      startDate: json['start_date'],
      phone: json['phone'],
      address: json['address'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Rating {
  final int id;
  final int userId;
  final int propertyId;
  final double rating;
  final String type;
  final String createdAt;
  final String updatedAt;

  Rating({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.rating,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'],
      userId: json['user_id'],
      propertyId: json['property_id'],
      rating: json['rating'].toDouble(),
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
