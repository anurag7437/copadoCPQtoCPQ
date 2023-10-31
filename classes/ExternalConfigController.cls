public with sharing class ExternalConfigController {

    @TestVisible 
    private static IProductAttributeService productAttributeService;

    @AuraEnabled(cacheable=true)
    public static  Map<String,Object> getProductInfo(Id configuredProductId) {
        productAttributeService =  service(configuredProductId);
        return new Map<String, Object> {
            'configuredProductId'=> configuredProductId,
            'configuredProduct'=> productAttributeService.getConfiguredProduct(),
            'relatedProductList' => productAttributeService.getRelatedProducts()
        };
    }

    @TestVisible // Factory creation of service implementation
    private static IProductAttributeService service(Id configuredProductId) {
        //ideally needs to be mocked but since no mocking framework currently exists using the test run hack 
        if(Test.isRunningTest()){
            return (IProductAttributeService) new FakeProductAttributeService(configuredProductId);
        }
        return (IProductAttributeService) new productAttributeService(configuredProductId);
    }

}