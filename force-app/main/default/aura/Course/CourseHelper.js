({
    showTable: function (component) {
        component.set('v.columns', [
            {label: 'Abbreviation', fieldName: 'Cur_Abbreviation', type: 'text'},
            {label: 'You give', fieldName: 'Cur_Scale', type: 'number'},
            {label: 'Currency', fieldName: 'Cur_Name', type: 'text'},
            {label: 'You get (BYN)', fieldName: 'Cur_OfficialRate', type: 'number'}
        ]);
    }
})