-- Initial setup of PostgreSQL database
CREATE USER zonemaster WITH PASSWORD 'zonemaster';
CREATE DATABASE zonemaster WITH ENCODING 'UTF8';

\c zonemaster

CREATE TABLE test_results (
    id serial primary key,
    hash_id VARCHAR(16) DEFAULT substring(md5(random()::text || clock_timestamp()::text) from 1 for 16) NOT NULL,
    batch_id integer,
	creation_time timestamp without time zone DEFAULT NOW() NOT NULL,
	test_start_time timestamp without time zone,
	test_end_time timestamp without time zone,
	priority integer DEFAULT 10,
	progress integer DEFAULT 0,
	params_deterministic_hash varchar(32),
	params json NOT NULL,
	results json
);

CREATE TABLE batch_jobs (
    id serial PRIMARY KEY,
    username varchar(50) NOT NULL,
    creation_time timestamp without time zone NOT NULL DEFAULT NOW()
);

CREATE TABLE users (
    id serial PRIMARY KEY,
    user_info JSON
);

GRANT SELECT,UPDATE,INSERT ON test_results, batch_jobs, users TO zonemaster;
GRANT USAGE ON test_results_id_seq, batch_jobs_id_seq, users_id_seq TO zonemaster;
