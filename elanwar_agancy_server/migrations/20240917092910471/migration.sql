BEGIN;


--
-- MIGRATION VERSION FOR elanwar_agancy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('elanwar_agancy', '20240917092910471', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240917092910471', "timestamp" = now();

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
