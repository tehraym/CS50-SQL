CREATE TABLE "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE "schools_university"(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN ('elementary school', 'middle school',
        'high school', 'lower school', 'upper school', 'college', 'university')),
    "location" TEXT NOT NULL,
    "date_founded" INTEGER,
    PRIMARY KEY ("id")
);

CREATE TABLE "companies"(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "location" TEXT,
    PRIMARY KEY ("id")
);

CREATE TABLE "connections"(
    "id" INTEGER,
    "user_id" INTEGER,
    "user_connect_id" INTEGER,
    "school_id" INTEGER,
    "degree" TEXT,
    "type_degree" TEXT,
    "company_id" INTEGER,
    "title" TEXT,
    "start" INTEGER,
    "end" INTEGER,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("user_id") REFERENCES "user"("id"),
    FOREIGN KEY ("user_connect_id") REFERENCES "users"("id"),
    FOREIGN KEY ("school_id") REFERENCES "schools_university"("id"),
    FOREIGN KEY ("company_id") REFERENCES "companies"("id")
);
