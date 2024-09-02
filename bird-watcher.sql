CREATE TABLE Species(
    Id INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(35) UNIQUE NOT NULL,
    Description TEXT,
    PRIMARY KEY (Id)
);

CREATE TABLE Observers(
    Id INT NOT NULL AUTO_INCREMENT,
    Fname VARCHAR(100) NOT NULL,
    Lname VARCHAR(100) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Birds(
    Id INT NOT NULL AUTO_INCREMENT,
    Specie_id INT NOT NULL,
    Observer_id INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Specie_id) REFERENCES Species(Id),
    FOREIGN KEY (Observer_id) REFERENCES Observers(Id)
);

CREATE TABLE Observations (
    Id SERIAL PRIMARY KEY,
    Observer_id INT NOT NULL,
    Bird_id INT NOT NULL,
    Location VARCHAR(100),
    Observation_date TIMESTAMP NOT NULL,
    Notes TEXT,
    FOREIGN KEY (Observer_id) REFERENCES Observers(Id),
    FOREIGN KEY (Bird_id) REFERENCES Birds(Id)
);

INSERT INTO Species (Name, Description)
VALUES ('Eagles', 'The King of the Sky'),
('Sparrow', 'A small, often brownish or grayish bird.');


INSERT INTO Observers (Fname, Lname)
VALUES
('Chike', 'Uzoechina'),
('Jane', 'Smith');


INSERT INTO Birds (Specie_id, Observer_id)
VALUES
(1, 1),
(2, 2);


INSERT INTO Observations (Observer_id, Bird_id, Location, Observation_date, Notes)
VALUES
(1, 1, 'Mountain Range', '2024-09-02 06:30PM', 'Observed the eagle soaring high.'),
(2, 2, 'City Park', '2024-09-01 06:15PM', 'The sparrow was hopping between trees.');

SELECT 
    Birds.Id AS BirdID,
    Species.Name AS SpeciesName,
    Observations.Location,
    Observations.Observation_date,
    Observations.Notes
FROM 
    Birds
LEFT JOIN 
    Observations ON Birds.Id = Observations.Bird_id
JOIN 
    Species ON Birds.Specie_id = Species.Id;