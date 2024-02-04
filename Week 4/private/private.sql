CREATE TABLE "text"(
    "first" INTEGER,
    "second" INTEGER,
    "third" INTEGER
);

INSERT INTO "text"("first", "second", "third")
    VALUES
    (14,98,4),
    (114,3,5),
    (618,72,9),
    (630,7,3),
    (932,12,5),
    (2230,50,7),
    (2346,44,10),
    (3041,14,5);


CREATE VIEW message AS
SELECT substr(s."sentence", t."second", t."third") AS "phrase"
FROM sentences s
JOIN text t ON s."id" = t."first"
WHERE t."first" != '';

