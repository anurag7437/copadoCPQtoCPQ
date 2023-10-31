public with sharing class ProductModel {
    protected transient product2 product;

    public ProductModel(Id productId) {
        this([SELECT Id,name,productCode,
            ExtendedAttribute1__c,ExtendedAttribute2__c 
            FROM product2 where Id=:productId
        ]); 
    }

    public ProductModel(product2 product) {
        this.product=product;     
    }

    public Id id { get { return this.product.Id; } }
    public String name { get { return this.product.name; } }
    public String code { get { return this.product.productCode; } }

    public list<ProductAttributeModel> getAttributeList() { 
        list<ProductAttributeModel>attributeModelList = new list<ProductAttributeModel>();
        for(string field: ProductConstants.attributeFields) {
            if(this.product.get(field)!=null) {
                attributeModelList.add(
                    (ProductAttributeModel)JSON.deserializeStrict(
                    (string)this.product.get(field), ProductAttributeModel.class)
                );
            }
        }
        return attributeModelList;
    }

    public Map<String,String> getAttributeExternalModel() { 
        Map<String,String> attributeValueMap = new Map<String,String>();
        for(ProductAttributeModel var :getAttributeList()) {
            attributeValueMap.put(var.key, var.value);
        }
        return attributeValueMap;
    }

    /**
     * Create an external model from this product model that can consistently be exposed to both LWC and Aura components.
     * @return   A consistent external data model as a serializeable Key-Value map
    **/
    public Map<String, Object> toExternalModel() {
        return new Map<String, Object> {
            'id' => id,
            'name' => name,
            'code' => code,
            'attributes' => getAttributeExternalModel()
        };
    }
}