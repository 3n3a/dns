-- Table: public.domains

-- DROP TABLE IF EXISTS public.domains;

CREATE TABLE IF NOT EXISTS public.domains
(
    value text COLLATE pg_catalog."default",
    tld character varying(255) COLLATE pg_catalog."default" GENERATED ALWAYS AS (COALESCE(split_part(value, '.'::text, 2), ''::text)) STORED
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.domains
    OWNER to domains;
