
class productModelList{
  List<productModel>? data;

  productModelList({this.data});

  productModelList.fromSnapshot(Map<String,dynamic> snap){
    if (snap['data'] != null) {
      data = <productModel>[];
      snap['data'].forEach((v) {
        data!.add(new productModel.fromJson(v));
      });
    }
  }


}

class productModel {
  String? productName;
  String? productPrice;
  String? productMrp;
  String? productDiscount;
  String? productUnitQty;
  String? sellerId;
  String? productId;

  productModel(
      {this.productName,
        this.productPrice,
        this.productMrp,
        this.productDiscount,
        this.productUnitQty,
        this.sellerId,
        this.productId

      });

  productModel.fromJson(snapshot) {
    productName = snapshot['product_name'];
    productPrice = snapshot['product_price'];
    productMrp = snapshot['product_mrp'];
    productDiscount = snapshot['product_discount'];
    productUnitQty = snapshot['product_unit_qty'];
    sellerId = snapshot['seller_id'];
    productId = snapshot['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_mrp'] = this.productMrp;
    data['product_discount'] = this.productDiscount;
    data['product_unit_qty'] = this.productUnitQty;
    data['seller_id'] = this.sellerId;
    data['product_id'] = this.productId;

    return data;
  }
}