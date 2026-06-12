\encoding utf8

-- The schema holding our horse racing data.
CREATE SCHEMA raceform;

-- All countries involved in horse racing and horse breeding.
CREATE TABLE raceform.country (
  -- Country codes used in the horse industry.
  -- These codes consist of two or three characters.
  country_code CHAR(3) NOT NULL,
  -- Country codes expressed in the ISO 3166-1 alpha-3 standard.
  -- All codes consists of three characters.
  -- This column is for identifying the country.
  iso_country_code CHAR(3) NOT NULL,
  -- The name of the country for display purpose.
  country_name TEXT NOT NULL,

  PRIMARY KEY (country_code),
  UNIQUE (iso_country_code)
);

-- Types of horse races
CREATE TABLE raceform.race_type (
  -- The code of the type.
  -- Possible values are:
  -- * `Chase`: jump races with taller obstacles.
  -- * `Flat`: races on level course without obstacles.
  -- * `Hurdle`: jump races with smaller obstacles.
  -- * `NH Flat`: races for jump horses without obstacles.
  race_type VARCHAR(8) NOT NULL,
  PRIMARY KEY (race_type)
);

-- All the jockeys who ride racehorses.
CREATE TABLE raceform.jockey (
  -- The identifier of the jockey.
  jockey_id UUID NOT NULL DEFAULT gen_random_uuid(),
  -- The name of the jockey.
  jockey_name TEXT NOT NULL,

  PRIMARY KEY (jockey_id),
  UNIQUE (jockey_name)
);

-- All the trainers who train racehorses.
CREATE TABLE raceform.trainer (
  -- The identifier of the trainer.
  trainer_id UUID NOT NULL DEFAULT gen_random_uuid(),
  -- The name of the trainer.
  trainer_name TEXT NOT NULL,

  PRIMARY KEY (trainer_id),
  UNIQUE (trainer_name)
);

-- All racecourses.
CREATE TABLE raceform.racecourse (
  -- The identifier of this racecourse.
  racecourse_id UUID DEFAULT gen_random_uuid(),
  -- The name of this racecourse.
  racecourse_name TEXT NOT NULL,
  -- The code of the country where this racecourse is located.
  country_code CHAR(3) NOT NULL,

  PRIMARY KEY (racecourse_id),
  UNIQUE (racecourse_name, country_code),
  FOREIGN KEY (country_code) REFERENCES raceform.country(country_code)
);

-- All racehorses.
CREATE TABLE raceform.horse(
  -- The identifier of the horse.
  horse_id UUID DEFAULT gen_random_uuid(),
  -- The name of the horse.
  horse_name VARCHAR(32) NOT NULL,
  -- The country code of the country where the horse was born.
  country_code CHAR(3) NOT NULL,
  -- The year of birth in the Western calendar.
  birth_year INTEGER NOT NULL,
  -- The genetic gender of the horse.
  -- Allowed values are:
  -- * `XX`: female horse
  -- * `XY`: male horse
  -- `NULL` if the gender is unknown for the horse.
  gender CHAR(2),

  PRIMARY KEY (horse_id),
  UNIQUE (horse_name, country_code, birth_year),
  FOREIGN KEY (country_code) REFERENCES raceform.country(country_code)
);

-- Occurrences of horse races.
CREATE TABLE raceform.race(
  -- The identifier of the race.
  race_id UUID DEFAULT gen_random_uuid(),
  -- The identifier of the racecourse where the race was held.
  racecourse_id UUID NOT NULL,
  -- The day the race was held.
  race_date DATE NOT NULL,
  -- Start time in local time.
  post_time TIME NOT NULL,
  -- The name of the race.
  race_name TEXT NOT NULL,
  -- The type of the race.
  race_type VARCHAR(8) NOT NULL,
  -- The distance run by horses in the race.
  distance TEXT NOT NULL,
  -- The grand condition.
  going TEXT,
  -- The number of horses participating in the race
  runners INTEGER NOT NULL,

  PRIMARY KEY (race_id),
  FOREIGN KEY (racecourse_id) REFERENCES raceform.racecourse(racecourse_id),
  FOREIGN KEY (race_type) REFERENCES raceform.race_type(race_type)
);

-- Horses that participated in races.
CREATE TABLE raceform.runner(
  -- The identifier of the race the runner participated in.
  race_id UUID NOT NULL,
  -- The identifier of the hose who participated in the race.
  horse_id UUID NOT NULL,
  -- The unique identification number worn by the runner.
  saddle_number INTEGER,
  -- The starting stall position assigned to the runner.
  draw_number INTEGER,
  -- The order of finish of the runner.
  -- The winner will be assigned the value `1`.
  order_of_finish INTEGER,
  -- The reason why an order has not been assigned to the runner.
  reason TEXT NOT NULL,
  -- The identifier of the jockey who rode the runner in the race.
  jockey_id UUID,
  -- The identifier of the trainer who trained the runner for the race.
  trainer_id UUID,
  -- The age of the runner at the time of the race.
  -- The update date varies depending on the country
  -- where the horse was born.
  age INTEGER NOT NULL,
  -- The gender of the runner at the time of the race.
  -- To determine whether a horse is male or female, refer to the `horse` table.
  gender CHAR(2) NOT NULL,

  PRIMARY KEY (race_id, horse_id),
  FOREIGN KEY (race_id) REFERENCES raceform.race(race_id),
  FOREIGN KEY (jockey_id) REFERENCES raceform.jockey(jockey_id),
  FOREIGN KEY (trainer_id) REFERENCES raceform.trainer(trainer_id),
  CHECK (order_of_finish > 0),
  CHECK (age >= 0)
);
