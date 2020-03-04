({
    myAction : function (component, event) {
        let data = event.getParam("amount");
        component.set("v.items", data);
    },

    changeItems :function (component) {

        let rendEvent = component.getEvent("reRender");
        rendEvent.setParams({
            "value" : null
        }).fire();
    },
})