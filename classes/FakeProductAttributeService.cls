@isTest
public with sharing class FakeProductAttributeService implements IProductAttributeService {
    private Id configuredProductId;
    public Map<String, Object> getConfiguredProductResult = new Map<String, Object>();
    public  List<Map<String, Object>> getRelatedProductsResult = new List<Map<String, Object>>();
    public FakeProductAttributeService(Id configuredProductId) {
        this.configuredProductId=configuredProductId;
    }
    public Map<String, Object> getConfiguredProduct() {
        If(getConfiguredProductResult.keySet().isEmpty()) {
            getConfiguredProductResult = new Map<String, Object> {
                'id' => configuredProductId,
                'name' => 'TestConfiguredProductName ',
                'code' => 'TestConfiguredProductCode'
            };
        }
        return getConfiguredProductResult;
    }
    public List<Map<String, Object>> getRelatedProducts() {
        If(getRelatedProductsResult.isEmpty()) {
            getRelatedProductsResult.add (
                new Map<String, Object> {
                    'id' => 'TestRelatedProductId',
                    'name' => 'TestRelatedProductName',
                    'code' => 'TestRelatedProductCode'
                }
            );
        }
        return getRelatedProductsResult;
    }
}