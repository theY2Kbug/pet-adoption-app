//An abstract pet model. Each instance of this class is a unique pet with a name, id, category, age, price, and the adopted status

class Pet {
  final String id;
  final String name;
  final String category;
  final String age;
  final String price;
  final bool adopted;
  // final List<String> nameSearch;

  Pet({
    required this.id,
    required this.name,
    required this.category,
    required this.age,
    required this.price,
    required this.adopted,
    // required this.nameSearch,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "price": price,
        "age": age,
        "adopted": adopted,
        // "nameSearch": nameSearch,
      };
}
