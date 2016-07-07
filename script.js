// JavaScript for DrugWars (script.js)


// Generates random integer between min and max (inclusive)
var getRandom = function(min, max) {
    return (Math.floor(Math.random() * (max - min) +min));
}

// Create Player class
class Player {
    constructor(cash, debt, health) {
        this.cash = cash;
        this.debt = debt;
        this.health = health;
    }

    // Add income to money total
    addIncome(amount) {
        return this.money += amount;
    }

    // Subtract expenditure/loss from money total
    subtractLoss(amount) {
        if (this.money > amount) {
            return this.money -= amount;
        } else {
            return this.money = 0;
        }
    }
}


// Create Station class
class Station {
    constructor(stationName) {
        this.stationName = stationName;
    }

    // Announce subway Station
    announceStation() {
        $("#location").append(this.stationName);
    }

    /* Random event function:
        - Officer Hardass
        - Drug price outlier
        - Mugging
        - Purchase offer (guns, coats)
    */
}


function getStation() {
    // Create instances of the subway Station class
    var stationList = [
        bronx = new Station("the Bronx"),
        ghetto = new Station("the Ghetto"),
        centralPark = new Station("Central Park"),
        manhattan = new Station("Manhattan"),
        coneyIsland = new Station("Coney Island"),
        brooklyn = new Station("Brooklyn")
    ];
    
    // Randomly call station
    var i = getRandom(0, stationList.length);
    stationList[i].announceStation();
}



// Create Drug class (see bottom comment about Scarcity)
class Drug {
    constructor(name, min, max) {
        this.name = name;
        this.min = min;
        this.max = max;
    }

    // Call these 2 functions at each Subway stop
    calculatePrice() {
        return getRandom(this.min, this.max);
    };

    calculateQuantity() {
        return getRandom(0, 51);
    };
}

// Create instances of the Drug class
var drugList = [
    cocaine = new Drug("Cocaine", 15000, 28000),
    weed = new Drug("Weed", 200, 850),
    heroin = new Drug("Heroin", 5000, 15000),
    acid = new Drug("Acid", 1000, 3000),
    speed = new Drug("Speed", 80, 250),
    opium = new Drug("Opium", 500, 10000)
];


var drugMenu = drugList.map(function(drug) {
    return menu = {
        name: drug.name,
        price: drug.calculatePrice(),
        quantity: drug.calculateQuantity()
    }}).filter(function(drug) {
        return drug.quantity >= 5;
        }).map(function(drug) {
                $("#menuTable").append(
                "<tr><td>"+drug.name+
                "</td><td>$ "+drug.price+
                "</td><td>"+drug.quantity+"</td></tr>");
            });



// Number of days in game
var counter = 10;

// Start game and reset stats
startGame = $('#start').click(function() {
    $('#counter').empty().append(counter);      
    player = new Player(2000, 2000, 100);
    $('#cash').empty().append(player.cash);
    $('#debt').empty().append(player.debt);
    $('#health').empty().append(player.health);
});


// Navigate between stations
navigate = $('.station').click(function() {
    $(this).toggleClass('clicked').siblings().removeClass('clicked');
    if (counter > 0) {
        counter -= 1;
        $('#counter').empty().append(counter);
    } else {
        $('#counter').empty().append("GAME OVER");
    }
});

