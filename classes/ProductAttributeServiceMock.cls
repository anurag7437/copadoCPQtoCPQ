public with sharing class ProductAttributeServiceMock implements IProductAttributeService {
    private Id configuredProductId;

    public ProductAttributeServiceMock(Id configuredProductId) {
        this.configuredProductId=configuredProductId;
    }

    public Map<String, Object> getConfiguredProduct(){
        return new Map<String, Object> {
            'id' => this.configuredProductId
        };
    }
    public List<Map<String, Object>> getRelatedProducts() {
        List<Map<String, Object>> relatedProductList = new List<Map<String, Object>>();
        Map<String, Object> relatedProductMap = new Map<String, Object> {
            'name' => 'TestRelatedProduct'
        };
        relatedProductList.add(relatedProductMap);   
        return relatedProductList;
    }


}