({
    doAction: function (component, event, helper) {
        let action = component.get("c.getLogin");
        let args = event.getParam("arguments");
        let ourFunction;
        if (args) {
            ourFunction = args.func;
        }

        action.setCallback(this, function (response) {
            let state = response.getState();
            let respond = '';
            if (state === 'SUCCESS') {
                ourFunction(response.getReturnValue());
            } else {
                ourFunction('ERROR: ' + response.getError());
            }
        });
        $A.enqueueAction(action);
    }
})