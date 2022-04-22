class CartItem {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.price,
  });
}
