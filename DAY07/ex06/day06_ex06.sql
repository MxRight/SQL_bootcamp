CREATE SEQUENCE seq_person_discounts AS BIGINT
OWNED BY person_discounts.id;

ALTER TABLE person_discounts
    ALTER COLUMN id SET DEFAULT nextval('seq_person_discounts');

SELECT setval('seq_person_discounts', (SELECT COUNT(*) FROM person_discounts) + 1, false);