-- Table: public.domains

-- DROP TABLE IF EXISTS public.domains;

CREATE TABLE IF NOT EXISTS public.domains
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    value text COLLATE pg_catalog."default" NOT NULL,
    created timestamp with time zone NOT NULL DEFAULT now(),
    updated timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT domains_pkey PRIMARY KEY (id),
    CONSTRAINT uq_value UNIQUE (value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.domains
    OWNER to domains;
