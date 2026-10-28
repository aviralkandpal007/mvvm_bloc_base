import 'dart:convert';

/// Converts the listing response body into typed items.
List<DemoListingItem> demoListingItemsFromJson(String str) =>
    (json.decode(str) as List<dynamic>)
        .map((item) => DemoListingItem.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);

/// Encodes listing items as a JSON array.
String demoListingItemsToJson(List<DemoListingItem> data) =>
    json.encode(List<dynamic>.from(data.map((item) => item.toJson())));

/// A single post shown in the demo listing.
class DemoListingItem {
  const DemoListingItem({
    required this.id,
    required this.title,
    required this.body,
  });

  final int id;
  final String title;
  final String body;

  /// Creates an item from a JSON object.
  factory DemoListingItem.fromJson(Map<String, dynamic> json) =>
      DemoListingItem(
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );

  /// Converts this item to a JSON-compatible map.
  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'body': body};
}
