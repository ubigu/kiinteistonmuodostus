-- experiment with uuid as primary key (with autogenerated new value)
DROP TABLE IF EXISTS test_uuid_primary_key;

CREATE TABLE test_uuid_primary_key (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    arvo CHARACTER VARYING(100)
);

INSERT INTO test_uuid_primary_key (arvo) SELECT CAST(arvo AS CHARACTER VARYING(10)) FROM generate_series(0,999) AS arvo;

DROP TABLE IF EXISTS test_timestamps;

CREATE TABLE test_timestamps (
    id BIGSERIAL PRIMARY KEY,
    t_no_tz TIMESTAMP WITHOUT TIME ZONE,
    t_tz TIMESTAMP WITH TIME ZONE
);

INSERT INTO test_timestamps (t_no_tz, t_tz) VALUES
    (now(), now()),
-- dates generated with: date --iso-8601=sec
    ('2021-03-22T11:57:45+02:00','2021-03-22T11:57:45+02:00');

-- Notice how string input TZ is not noticed in WITHOUT TIME ZONE field
SELECT * FROM test_timestamps;

-- "Correct" way of selecting local time from an attribute, where time zone info is saved
-- Note also, that it is not needed to know, if daylight savings time is effective
SELECT TIMEZONE('Europe/Helsinki', t_tz) FROM test_timestamps;
SELECT TIMEZONE('Europe/Stockholm', t_tz) FROM test_timestamps;
