BEGIN;

-- Your insert query here
INSERT INTO domains (value)
	SELECT value FROM domains_temp
ON CONFLICT (value)
	DO NOTHING;

-- Commit the transaction
COMMIT;
