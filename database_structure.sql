CREATE TABLE IF NOT EXISTS plants (
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  name TEXT NOT NULL, 
  soil TEXT NOT NULL, 
  position TEXT NOT NULL, 
  ph DOUBLE NOT NULL,
  familyId INT NOT NULL
)

CREATE TABLE IF NOT EXISTS plantsJoin (
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  plantId INTEGER NOT NULL, 
  name TEXT NOT NULL, 
  type TEXT CHECK( type IN ('Compainion','Avoid','Family') )   NOT NULL 
);


CREATE TABLE IF NOT EXISTS plants (
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  name TEXT, 
  lifeSpan INTEGER NOT NULL
)

INSERT INTO plants (name, soil, position, type) VALUES ("Kale", )

