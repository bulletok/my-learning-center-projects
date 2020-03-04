({
	doInit : function(component, event, helper) {
		var action = component.get('c.getProducts');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                component.set('v.products', response.getRerurnValue());
            } else {
                console.log('Failed with state: ' + state);
            }
        });
	}
})