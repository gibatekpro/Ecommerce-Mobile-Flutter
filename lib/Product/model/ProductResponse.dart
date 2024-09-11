

import 'embedded/embedded.dart';
import 'page/page.dart';

class ProductResponse {
  Embedded embedded;
  Page page;

  ProductResponse({required this.embedded, required this.page});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
        embedded: Embedded.fromJson(json['_embedded']),
        page: Page.fromJson(json['page']));
  }

  Map<String, dynamic> toJson() {
    return {
      //We are not using Json Serializable because
      // _embedded will not be well defined
      '_embedded': embedded,
      'page': page
    };
  }
}
