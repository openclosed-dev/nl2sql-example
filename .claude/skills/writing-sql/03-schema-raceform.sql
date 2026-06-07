\encoding utf8

CREATE SCHEMA raceform;

CREATE TABLE raceform.country (
  country_code CHAR(3) NOT NULL,
  iso_country_code CHAR(3) NOT NULL,
  country_name TEXT NOT NULL,

  PRIMARY KEY (country_code),
  UNIQUE (iso_country_code)
);

CREATE TABLE raceform.race_type (
  race_type VARCHAR(8) NOT NULL,
  PRIMARY KEY (race_type)
);

CREATE TABLE raceform.jockey (
  jockey_id UUID NOT NULL DEFAULT gen_random_uuid(),
  jockey_name TEXT NOT NULL,

  PRIMARY KEY (jockey_id),
  UNIQUE (jockey_name)
);

CREATE TABLE raceform.trainer (
  trainer_id UUID NOT NULL DEFAULT gen_random_uuid(),
  trainer_name TEXT NOT NULL,

  PRIMARY KEY (trainer_id),
  UNIQUE (trainer_name)
);

CREATE TABLE raceform.racecourse (
  racecourse_id UUID DEFAULT gen_random_uuid(),
  racecourse_name TEXT NOT NULL,
  country_code CHAR(3) NOT NULL,

  PRIMARY KEY (racecourse_id),
  UNIQUE (racecourse_name, country_code),
  FOREIGN KEY (country_code) REFERENCES raceform.country(country_code)
);

-- Racing horse
CREATE TABLE raceform.horse(
  horse_id UUID DEFAULT gen_random_uuid(),
  horse_name VARCHAR(32) NOT NULL,
  country_code CHAR(3) NOT NULL,
  birth_year INTEGER NOT NULL,
  -- Genetic gender of the horse. Allowed values are 'XX' or 'XY.
  -- NULL for unknown gender.
  gender CHAR(2),

  PRIMARY KEY (horse_id),
  UNIQUE (horse_name, country_code, birth_year),
  FOREIGN KEY (country_code) REFERENCES raceform.country(country_code)
);

CREATE TABLE raceform.race(
  race_id UUID DEFAULT gen_random_uuid(),
  racecourse_id UUID NOT NULL,
  race_date DATE NOT NULL,
  post_time TIME NOT NULL,
  race_name TEXT NOT NULL,
  race_type VARCHAR(8) NOT NULL,
  distance TEXT NOT NULL,
  going TEXT,
  runners INTEGER NOT NULL,

  PRIMARY KEY (race_id),
  FOREIGN KEY (racecourse_id) REFERENCES raceform.racecourse(racecourse_id),
  FOREIGN KEY (race_type) REFERENCES raceform.race_type(race_type)
);

CREATE TABLE raceform.runner(
  race_id UUID NOT NULL,
  horse_id UUID NOT NULL,
  saddle_number INTEGER,
  draw_number INTEGER,
  order_of_finish INTEGER,
  reason TEXT NOT NULL,
  jockey_id UUID,
  trainer_id UUID,
  -- Age of the runner at the time of the race.
  age INTEGER NOT NULL,
  -- Gender of the runner at the time of the race.
  gender CHAR(2) NOT NULL,

  PRIMARY KEY (race_id, horse_id),
  FOREIGN KEY (race_id) REFERENCES raceform.race(race_id),
  FOREIGN KEY (jockey_id) REFERENCES raceform.jockey(jockey_id),
  FOREIGN KEY (trainer_id) REFERENCES raceform.trainer(trainer_id),
  CHECK (order_of_finish > 0),
  CHECK (age >= 0)
);
