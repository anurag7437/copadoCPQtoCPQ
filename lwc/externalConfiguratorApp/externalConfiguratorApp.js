import { LightningElement,api } from 'lwc';
export default class ExternalConfiguratorApp extends LightningElement {
@api productConfigData;

    previousHandler() {
        this.dispatchEvent(new CustomEvent("previous"));
    }

    nextHandler() {
        this.dispatchEvent(new CustomEvent("next"));
    }
    handleChange(event) {
        const value = event.target.value;
        const valueChangeEvent = new CustomEvent("valuechange", {
        detail: { value }
        });
        // Fire the custom event
        this.dispatchEvent(valueChangeEvent);
    }
}