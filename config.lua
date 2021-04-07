popsJobConfig = {

    Tenue = {
        homme = {
            ['tshirt_1'] = 0,   ['tshirt_2'] = 0,
            ['torso_1'] = 4,    ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 6,
            ['pants_1'] = 10,   ['pants_2'] = 0,
            ['shoes_1'] = 42,    ['shoes_2'] = 2,
            ['chain_1'] = 0,    ['chain_2'] = 0
        },
        femme = {
            ['tshirt_1'] = 0,   ['tshirt_2'] = 0,
            ['torso_1'] = 6,    ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 6,   ['pants_2'] = 2,
            ['shoes_1'] = 42,    ['shoes_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0
        }
    },

    blips = {
        {title = "Pop's Diner", colour = 8, id = 267, x = 1583.402, y = 6450.087, z = 25.18775}
    },
    blips2 = {
        {title = "Achat aliments", colour = 8, id = 267, x = 161.7799, y = 6636.611, z = 31.56113}
    },

    popsJobVeh = {
        Veh = {
            {Label = "Voiture parton", Name = "revolter"},
            {Label = "Camion", Name = "mule4"},
        },
    },
 
    popsJobShops = {
        bouffe = {
            {name = "Pain à burger", label = "painburger", price = 5},
            {name = "Tomate", label = "tomate", price = 5},
            {name = "Mozzarella", label = "mozzarella", price = 5},
            {name = "Steak", label = "steak", price = 5},
            {name = "Oignon", label = "oignon", price = 5},
            {name = "Salade", label = "salade", price = 5},
        },
        boisson = {
            {name = "Ice-Tea", label = "icetea", price = 2},
            {name = "Eau", label = "water", price = 2},
            {name = "Limonade", label = "limonade", price = 2},
        },
    },

    popsJobCuisine = {
        preparation = {
            {name = "Couper des tomates", removeitem = "tomate", additem = "tomatecouper", nombre = 5},
            {name = "Couper la mozzarella", removeitem = "mozzarella", additem = "mozzarellacouper", nombre = 5},
            {name = "Couper la salade", removeitem = "salade", additem = "saladecouper", nombre = 5},
        },
        cuisine = {
            {name = "Cuire le steak", removeitem = "steak", additem = "steakcuit", nombre = 1},
            {name = "Frire les oignons", removeitem = "oignon", additem = "oignonfrit", nombre = 5},
        },
        assemblage = {
           {name = "Cuisinez un burger", additem = "burger", nombre = 1}
        }
    },

    PosSpawn = {
        {SpawnVeh = vector3(1586.778, 6446.921, 25.15148)},
    },

    PosGarage = {
        {Garage = vector3(1583.453, 6450.191, 25.00)},
    },

    PosVestiaire = {
        {Vestiaire = vector3(1582.921, 6460.284, 25.70)},
    },

    PosShops = {
        {Shops = vector3(161.7799, 6636.611, 31.56113)},
    },

    PosCuisine = {
        {Cuisine = vector3(1593.757, 6455.328, 26.01398)},
    },

    PosBoss = {
        {Boss = vector3(1595.767, 6454.17, 26.01399)},
    },
}