import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
    Products({
        this.data,
        this.nextPaging,
    });

    List<Datum>? data;
    int? nextPaging;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        nextPaging: json["next_paging"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_paging": nextPaging,
    };
}

class Datum {
    Datum({
        this.id,
        this.category,
        this.title,
        this.description,
        this.price,
        this.texture,
        this.wash,
        this.place,
        this.note,
        this.story,
        this.colors,
        this.sizes,
        this.variants,
        this.mainImage,
        this.images,
    });

    int? id;
    String? category;
    String? title;
    String? description;
    int? price;
    String? texture;
    String? wash;
    String? place;
    String? note;
    String? story;
    List<Color>? colors;
    List<String>? sizes;
    List<Variant>? variants;
    String? mainImage;
    List<String>? images;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        category: json["category"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        texture: json["texture"],
        wash: json["wash"],
        place: json["place"],
        note: json["note"],
        story: json["story"],
        colors: json["colors"] == null ? [] : List<Color>.from(json["colors"]!.map((x) => Color.fromJson(x))),
        sizes: json["sizes"] == null ? [] : List<String>.from(json["sizes"]!.map((x) => x)),
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        mainImage: json["main_image"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "title": title,
        "description": description,
        "price": price,
        "texture": texture,
        "wash": wash,
        "place": place,
        "note": note,
        "story": story,
        "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x.toJson())),
        "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x)),
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "main_image": mainImage,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    };
}

class Color {
    Color({
        this.code,
        this.name,
    });

    String? code;
    String? name;

    factory Color.fromJson(Map<String, dynamic> json) => Color(
        code: json["code"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
    };
}

class Variant {
    Variant({
        this.colorCode,
        this.size,
        this.stock,
    });

    String? colorCode;
    String? size;
    int? stock;

    factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        colorCode: json["color_code"],
        size: json["size"],
        stock: json["stock"],
    );

    Map<String, dynamic> toJson() => {
        "color_code": colorCode,
        "size": size,
        "stock": stock,
    };
}
