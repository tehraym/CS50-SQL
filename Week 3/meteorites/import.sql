.import --csv "meteorites.csv" temp

-- Replacing Empty values with "NULL"
UPDATE "temp"
SET "mass" = NULL,
    "year" = NULL,
    "lat" = NULL,
    "long" = NULL
WHERE "mass" = '' OR "year" = '' OR "lat" = '' OR "long" = '';

--Round off to 2 decimal points
UPDATE "temp"
SET "mass" = ROUND("mass", 2),
    "lat" = ROUND("lat", 2),
    "long" = ROUND("long", 2);

--Exclude Relict
DELETE FROM "temp"
WHERE "nametype" = 'Relict';

-- Create table and order by year and name
CREATE TABLE "meteorites" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT CHECK (discovery IN ('Fell', 'Found')),
    "year" INTEGER,
    "lat" REAL,
    "long" REAL
);

INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "temp"
ORDER BY "year", "name";
