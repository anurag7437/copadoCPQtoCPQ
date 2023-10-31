({
  sendConfigData: function(component, event) {
    // Get the configuration data string
     var productData = event.getParam("productData");

    // Log it to the console
    console.log("Configuration Data in Lightning Component: ");
    console.log('aaaa',productData);

    // get the update configuration event,
    // set the config data and fire the event.
    var updateEvent = $A.get("e.c:ConfigEvent");
    updateEvent.setParams({ configData: productData }).fire();
  }
});