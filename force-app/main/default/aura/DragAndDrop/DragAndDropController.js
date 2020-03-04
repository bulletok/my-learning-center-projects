({
    doInit: function (component, event, helper) {
        let action = component.get("c.getChains");
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.chains", response.getReturnValue());
            } else {
                console.log('Failed with state: ' + state)
            }
        });
        $A.enqueueAction(action);
    },

    allowDrop: function (component, event, helper) {
        event.preventDefault();
    },

    handlerDragStart: function (component, event, helper) {
        component.set("v.dragIndex", event.target.dataset.dragId);
    },

    handlerDrop: function (component, event, helper) {
        let dropIndex = +event.target.dataset.dropId;
        let dragIndex = +component.get("v.dragIndex");
        let chains = component.get("v.chains");
        component.set("v.dropIndex", dropIndex);

        if (dragIndex !== dropIndex && dropIndex !== dragIndex -1) {
            helper.changeLookups(component, event, helper);
            let chain = chains.splice(dragIndex, 1);

            if (dragIndex > dropIndex) {
                dropIndex++;
            }

            chains.splice(dropIndex, 0, chain[0]);
            component.set("v.chains", chains);
        }
    }
})