-- Index: idx_value_trgm

-- DROP INDEX IF EXISTS public.idx_value_trgm;

CREATE INDEX IF NOT EXISTS idx_value_trgm
    ON public.domains USING gin
    (value COLLATE pg_catalog."default" gin_trgm_ops)
    TABLESPACE pg_default;

