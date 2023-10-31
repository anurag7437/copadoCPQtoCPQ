import { LightningElement,api } from 'lwc';

export default class SelectListComponent extends LightningElement {
    @api key;
    @api options;
    @api value;
    @api name;
    @api label;
    @api placeholder = "Choose a value";
    _status = "down";
    _isSelected = "play";

    handleSelect(event) {
        this.selectedKey = event.target.label;
        this.selectedValue = event.detail.value;
        this.status = "Up";
        this.isSelected = "stop";
        this.dispatchEvent(new CustomEvent("valueselected", {
        detail: { key:this.selectedKey,value:this.selectedValue }
        }));
    }

    @api
    get status() {
        return this._status;
    }

    set status(value) {
        this._status = value;
    }

    @api
    get isSelected() {
        return this._isSelected;
    }
    set isSelected(value) {
        this._isSelected = value;
    }
}