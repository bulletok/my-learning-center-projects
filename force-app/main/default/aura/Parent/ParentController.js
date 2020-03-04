({
    doInit : function (component, event, helper) {
        let child = component.find("childCmp");

        child.sampleMethod(function (response) {
            console.log(response);
        });
    }
})