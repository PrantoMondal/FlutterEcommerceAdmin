const String purchaseId = 'id';
const String purchaseProduct = 'productId';
const String purchaseDate = 'date';
const String purchasePrice = 'price';
const String purchaseQuantity = 'quantity';

class PurchaseModel {
  String? id, productId, date;
  num price, quantity;

  PurchaseModel(
      {this.id,
      this.productId,
      this.date,
      required this.price,
      required this.quantity});
}
