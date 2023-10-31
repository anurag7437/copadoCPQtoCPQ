({
	getValueFromLwc: function (component, event, helper) {
		console.log('event.getParam()' + event.getParam('value'));
		component.set("v.inputValue",event.getParam('value'));
	}
})