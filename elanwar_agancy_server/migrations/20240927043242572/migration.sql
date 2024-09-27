BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "reservation" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reservation" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "fullName" text NOT NULL,
    "hotel" text NOT NULL,
    "room" bigint NOT NULL,
    "totalPrice" double precision NOT NULL,
    "payed" double precision,
    "debt" double precision,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "isExpired" boolean NOT NULL,
    "createAt" timestamp without time zone NOT NULL,
    "idCardNumber" bigint NOT NULL,
    "phoneNumber" text NOT NULL,
    "adress" text NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reservation"
    ADD CONSTRAINT "reservation_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR elanwar_agancy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('elanwar_agancy', '20240927043242572', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240927043242572', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
