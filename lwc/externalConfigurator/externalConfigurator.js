import { LightningElement, api } from 'lwc';
import getProductInfo from '@salesforce/apex/ExternalConfigController.getProductInfo';

export default class ExternalProductConfig extends LightningElement {
    invalidCombination=true;
    productConfigData;
    productInfoWrapper;
    selectedAttributes = {};
    attributeMap = {};
    productValueMap = new Map();
    chosenProduct = {}
    showPill = false;
    
    set productConfigJson(value) {
        this.handleProductDataJson(JSON.parse(value));
    }

    @api get productConfigJson() {
        return this.productConfigData ;
    }

    handleChange(event) {
        this.productConfigData.redirect.auto = true;
        this.productConfigData.redirect.save = true;
        var productData = JSON.stringify(this.productConfigData);
        this.dispatchEvent(new CustomEvent("saveappevent", {
        detail: { productData }
        }));
    }

    handleSelectedValue(event) {
        this.invalidCombination = false;
        this.selectedKey = event.detail.key;
        this.selectedValue = event.detail.value;
        this.selectedAttributes[this.selectedKey] = this.selectedValue;
        this.selectedAttributes = this.handleLockerService(this.selectedAttributes);
        this.validProductCheck();
    }

    async handleProductDataJson(value) {
        console.log('test?>>>>>>>>>>>>>',value);
        this.productConfigData = value;
        this.productInfoWrapper = await getProductInfo (
            { configuredProductId : value.product.configuredProductId }
        ).then((response) => response);
        this.productInfoWrapper.relatedProductList.forEach((element) => {
            for (const [key, value] of Object.entries(element.attributes)) {
                Object.keys(this.attributeMap).includes(key) ?
                this.attributeMap[key].includes(value) ? '' :
                this.attributeMap[key].push({ label: value, value: value }) :
                this.attributeMap[key] = [{ label: value, value: value }]
            }}
        );
        this.generateHashValueMap(this.productInfoWrapper.relatedProductList);
    }

    async generateHashValueMap(relatedProductList) {
        await relatedProductList.forEach((element) => {
            this.productValueMap.set(element.attributes, element);
        })
    }

    get attributeKeyValueMap() {
        return Object.entries(this.attributeMap).map(([key, value,score]) => ({ key, value,score }));    
    }

    handleLockerService(value) {
        return JSON.parse(JSON.stringify(value));
    }

    validProductCheck() {
        let chosenAttributesString = Object.values(this.selectedAttributes).sort().toString();
        for (let [key, value] of this.productValueMap) {
            if (chosenAttributesString === Object.values(key).sort().toString()) {
                this.invalidCombination = false;
                this.showPill=false;
                this.chosenProduct = value;
                break;
            } else {
                this.invalidCombination = true;
                this.showPill=true;
                this.chosenProduct = {};
            }     
        }
        this.invalidCombination ?
            this.refs.footer.classList.add('slds-theme_alert-texture'):
            this.refs.footer.classList.remove('slds-theme_alert-texture')
    }

    handleRemoveOnly(event) {
        event.preventDefault();
        this.showPill = !this.showPill;
    }

}