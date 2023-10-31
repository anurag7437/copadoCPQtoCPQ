public with sharing class ProductAttributeService implements IProductAttributeService {
    private Id configuredProductId;
    private productModel configuredProduct;
    private List<productModel> relatedProductList;


    public ProductAttributeService(Id configuredProductId) {
        this(configuredProductId,null,null);
    }

    private ProductAttributeService(Id configuredProductId,
                                  productModel configuredProduct,
                                  List<productModel> relatedProductList){
        this.configuredProductId = configuredProductId;
        this.configuredProduct = configuredProduct!=null? configuredProduct : new productModel(configuredProductId);
        this.relatedProductList = relatedProductList!=null? relatedProductList: new List<productModel>();
    }

    public Map<String, Object> getConfiguredProduct() {
        return this.configuredProduct.toExternalModel();
    }


    public List<Map<String, Object>> getRelatedProducts() {
        List<Map<String, Object>> relatedProductsViewList = new List<Map<String, Object>>();
        for(product2 productVar:[SELECT Id, Name,productCode,ExtendedAttribute1__c,ExtendedAttribute2__c FROM product2 where sourceProductId=:this.configuredProductId]) {
            ProductModel modelVar =new ProductModel(productVar);
            this.relatedProductList.add(modelVar);
            relatedProductsViewList.add(modelVar.toExternalModel());
        }
        return relatedProductsViewList;
    }

}