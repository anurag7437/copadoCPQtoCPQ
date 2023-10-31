@IsTest
public with sharing class ExternalConfigControllerTest {
    @IsTest static void getProductInfo_getAllRelatedProductInfo() {
        Id productId = fflib_IDGenerator.generate(Product2.getSObjectType());
        Test.startTest();
        Map<String,Object> resultMap = ExternalConfigController.getProductInfo(productId);
        Test.stopTest();

        system.assertEquals(string.valueOf(productId), resultMap.get('configuredProductId'));
    }
}