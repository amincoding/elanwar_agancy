BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hotel" (
    "id" bigserial PRIMARY KEY,
    "hotelName" text NOT NULL,
    "contactInfo" text NOT NULL,
    "adress" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reservation" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "fullName" text NOT NULL,
    "hotelId" bigint NOT NULL,
    "roomId" bigint NOT NULL,
    "totalPrice" double precision NOT NULL,
    "payed" double precision,
    "debt" double precision
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room" (
    "id" bigserial PRIMARY KEY,
    "roomNumbre" text NOT NULL
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
ALTER TABLE ONLY "reservation"
    ADD CONSTRAINT "reservation_fk_1"
    FOREIGN KEY("hotelId")
    REFERENCES "hotel"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reservation"
    ADD CONSTRAINT "reservation_fk_2"
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR elanwar_agancy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('elanwar_agancy', '20240917072028373', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240917072028373', "timestamp" = now();

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
