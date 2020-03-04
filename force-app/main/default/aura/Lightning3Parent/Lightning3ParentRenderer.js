({
    render : function (component, event, helper) {
        component.set("v.onRender", true);
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "Render was successful!"
        });
        toastEvent.fire();
        return this.superRender();
    }


})