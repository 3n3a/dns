-- Table: public.domains

-- DROP TABLE IF EXISTS public.domains;

CREATE TABLE IF NOT EXISTS public.domains
(
    value text,
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.domains
    OWNER to domains;
