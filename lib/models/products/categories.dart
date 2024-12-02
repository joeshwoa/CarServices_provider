// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
    List<Datum>? data;
    Links? links;
    Meta? meta;

    Categories({
        this.data,
        this.links,
        this.meta,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
    };
}

class Datum {
    int? id;
    String? sku;
    String? name;
    String? description;
    String? urlKey;
    Image? baseImage;
    List<Image>? images;
    bool? isNew;
    bool? isFeatured;
    bool? onSale;
    bool? isSaleable;
    bool? isWishlist;
    String? minPrice;
    Prices? prices;
    String? priceHtml;
    int? avgRatings;

    Datum({
        this.id,
        this.sku,
        this.name,
        this.description,
        this.urlKey,
        this.baseImage,
        this.images,
        this.isNew,
        this.isFeatured,
        this.onSale,
        this.isSaleable,
        this.isWishlist,
        this.minPrice,
        this.prices,
        this.priceHtml,
        this.avgRatings,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sku: json["sku"],
        name: json["name"],
        description: json["description"],
        urlKey: json["url_key"],
        baseImage: json["base_image"] == null ? null : Image.fromJson(json["base_image"]),
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        isNew: json["is_new"],
        isFeatured: json["is_featured"],
        onSale: json["on_sale"],
        isSaleable: json["is_saleable"],
        isWishlist: json["is_wishlist"],
        minPrice: json["min_price"],
        prices: json["prices"] == null ? null : Prices.fromJson(json["prices"]),
        priceHtml: json["price_html"],
        avgRatings: json["avg_ratings"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "name": name,
        "description": description,
        "url_key": urlKey,
        "base_image": baseImage?.toJson(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "is_new": isNew,
        "is_featured": isFeatured,
        "on_sale": onSale,
        "is_saleable": isSaleable,
        "is_wishlist": isWishlist,
        "min_price": minPrice,
        "prices": prices?.toJson(),
        "price_html": priceHtml,
        "avg_ratings": avgRatings,
    };
}

class Image {
    String? smallImageUrl;
    String? mediumImageUrl;
    String? largeImageUrl;
    String? originalImageUrl;

    Image({
        this.smallImageUrl,
        this.mediumImageUrl,
        this.largeImageUrl,
        this.originalImageUrl,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        smallImageUrl: json["small_image_url"],
        mediumImageUrl: json["medium_image_url"],
        largeImageUrl: json["large_image_url"],
        originalImageUrl: json["original_image_url"],
    );

    Map<String, dynamic> toJson() => {
        "small_image_url": smallImageUrl,
        "medium_image_url": mediumImageUrl,
        "large_image_url": largeImageUrl,
        "original_image_url": originalImageUrl,
    };
}

class Prices {
    Final? regular;
    Final? pricesFinal;

    Prices({
        this.regular,
        this.pricesFinal,
    });

    factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        regular: json["regular"] == null ? null : Final.fromJson(json["regular"]),
        pricesFinal: json["final"] == null ? null : Final.fromJson(json["final"]),
    );

    Map<String, dynamic> toJson() => {
        "regular": regular?.toJson(),
        "final": pricesFinal?.toJson(),
    };
}

class Final {
    int? price;
    String? formattedPrice;

    Final({
        this.price,
        this.formattedPrice,
    });

    factory Final.fromJson(Map<String, dynamic> json) => Final(
        price: json["price"],
        formattedPrice: json["formatted_price"],
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "formatted_price": formattedPrice,
    };
}

class Links {
    String? first;
    String? last;
    dynamic prev;
    dynamic next;

    Links({
        this.first,
        this.last,
        this.prev,
        this.next,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
    };
}

class Meta {
    int? currentPage;
    int? from;
    int? lastPage;
    List<Link>? links;
    String? path;
    int? perPage;
    int? to;
    int? total;

    Meta({
        this.currentPage,
        this.from,
        this.lastPage,
        this.links,
        this.path,
        this.perPage,
        this.to,
        this.total,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
    };
}

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
