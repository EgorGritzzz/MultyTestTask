const shops = {
    moscow: {
        shops: [ 
            { name: 'Цех 1', employees: ['Петя', 'Вася'] }, 
            { name: 'Цех 2', employees: ['Дима', 'Олег'] } 
        ]
    },
    spb: {
        shops: [ 
            { name: 'Цех 3', employees: ['Кирилл', 'Андрей'] }, 
            { name: 'Цех 4', employees: ['Семен', 'Борис'] } 
        ]
    }
};

function updateShops() {
    const citySelect = document.getElementById('city');
    const shopSelect = document.getElementById('shop');
    const employeeSelect = document.getElementById('employee');

    
    shopSelect.innerHTML = '<option value="">Сначала выберите город</option>';
    employeeSelect.innerHTML = '<option value="">Сначала выберите цех</option>';

    const selectedCity = citySelect.value;

    if (selectedCity) {
        const availableShops = shops[selectedCity].shops;
        
        availableShops.forEach(shop => {
            const option = document.createElement('option');
            option.value = shop.name;
            option.text = shop.name;
            shopSelect.appendChild(option);
        });
    }
}

function updateEmployees() {
    const shopSelect = document.getElementById('shop');
    const employeeSelect = document.getElementById('employee');

    
    employeeSelect.innerHTML = '<option value="">Выберите сотрудника</option>';

    const selectedShop = shopSelect.value;
    const citySelect = document.getElementById('city');
    const selectedCity = citySelect.value;

    if (selectedCity && selectedShop) {
        const shopsInfo = shops[selectedCity].shops;
        const shopInfo = shopsInfo.find(shop => shop.name === selectedShop);

        if (shopInfo) {
            shopInfo.employees.forEach(employee => {
                const option = document.createElement('option');
                option.value = employee;
                option.text = employee;
                employeeSelect.appendChild(option);
            });
        }
    }
};

function saveData() {
    let citySelect = document.getElementById('city').value;
    let shopSelect = document.getElementById('shop').value;
    let employeeSelect = document.getElementById('employee').value;
    let teamSelect = document.getElementById('team').value;
    let timeSelect = document.getElementById('time').value;
    

    let dataObj = {
      city: citySelect,
      shop: shopSelect,
      employee: employeeSelect,
      team: teamSelect,
      work: timeSelect,
      
    };

    let jsonData = JSON.stringify(dataObj);
    
    const daysToExpire = 7;
    const date = new Date();
   date.setTime(date.getTime() + (daysToExpire * 24 * 60 * 60 * 1000));
const expires = "expires=" + date.toUTCString();

document.cookie = "userData=" + jsonData + ";" + expires + ";path=/";

alert('Сохранено в куки:' + jsonData);

  
}

