({
    doInit: function (component, event, helper) {
        let buttons = ['Мобильные телефоны', 'Ноутбуки', 'Автомобильные шины', 'Велосипеды', 'Планшеты',
            'Наушники и гарнитуры', 'Дроны', 'Видеокарты', 'Моторные масла', 'Фотоаппараты', 'Видеокамеры',
            'Умные часы и браслеты', 'Процессоры', 'Мониторы', 'Холодильники', 'Стиральные машины'];
        component.set("v.buttons", buttons);

        let action = component.get("c.getCourses");
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log(JSON.stringify(response.getReturnValue()))
                component.set("v.courses", response.getReturnValue());
            } else {
                console.log('Failed with state: ' + state);
            }
        });
        $A.enqueueAction(action);

    }
})