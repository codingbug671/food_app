class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";
  static const PRICE = "price";

  String _id;
  String _name;
  String _image;
  String _productId;
  int _quantity;

  int _price;

  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  int get quantity => _quantity;

  int get price => _price;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _image = data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
  }
  Map toMap() => {
        ID: _id,
        NAME: _name,
        IMAGE: _image,
        PRODUCT_ID: _productId,
        PRICE: _price,
        QUANTITY: _quantity,
      };
}
