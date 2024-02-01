-- Table: public.domains_temp
BEGIN;

-- Drop and Create Table
DROP TABLE IF EXISTS public.domains_temp;

CREATE TABLE IF NOT EXISTS public.domains_temp
(
    value text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.domains_temp
    OWNER to domains;

-- Load Data
COPY public.domains_temp(value) 
FROM '/opt/ingest/all-domains.txt' DELIMITER ',' CSV;

-- Output Count of Rows
SELECT count(1) as row_count FROM public.domains_temp;

COMMIT;