INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_popsdinerjob', 'popsdiner', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_popsdinerjob', 'popsdiner', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_popsdinerjob', 'popsdiner', 1)
;

INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('popsdiner', 0, 'recruit', 'Recrue', 20, '{}', '{}'),
    ('popsdiner', 1, 'serveur', 'Serveur',40, '{}', '{}'),
    ('popsdiner', 2, 'coboss', 'Co-Gérant',60, '{}', '{}'),
    ('popsdiner', 3, 'boss', 'Patron', 80, '{}', '{}')
;

INSERT INTO `jobs` (name, label) VALUES
	('popsdiner', 'popsdiner')
;

INSERT INTO `items` (name, label) VALUES
	('painburger', 'Pain à burger'),
	('tomate', 'Tomate'),
	('mozzarella', 'Mozzarella'),
	('steak', 'Steak'),
	('oignon', 'Oignon'),
	('salade', 'Salade'),
	('icetea', 'Ice-Tea'),
	('water', 'Eau'),
	('limonade', 'Limonade'),
	('tomatecouper', 'Tranches de tomates'),
	('mozzarellacouper', 'Tranches de mozzarella'),
	('saladecouper', 'Pignon de salade'),
	('steakcuit', 'Steak cuit'),
	('oignonfrit', 'Oignon frit'),
	('burger', 'Burger')
;
