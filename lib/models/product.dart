class ProductModel {
  String pName;
  String pPrice;
  String pLocation;
  String pDescription;
  String pCategory;
  String pId;
  int pQuantity;
  ProductModel(
      {this.pQuantity,
      this.pId,
      this.pName,
      this.pCategory,
      this.pDescription,
      this.pLocation,
      this.pPrice});
}