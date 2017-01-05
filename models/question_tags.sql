CREATE TABLE IF NOT EXISTS question_tags (
    id BIGSERIAL PRIMARY KEY,
    question_id BIGINT NOT NULL REFERENCES questions ON DELETE CASCADE ON UPDATE CASCADE,
    tag_id BIGINT NOT NULL REFERENCES tags ON DELETE CASCADE ON UPDATE CASCADE,
    number INTEGER,
    UNIQUE (question_id, tag_id)
);

ALTER TABLE question_tags ALTER COLUMN id SET DATA TYPE BIGINT;
ALTER TABLE question_tags ALTER COLUMN question_id SET DATA TYPE BIGINT;
ALTER TABLE question_tags ALTER COLUMN tag_id SET DATA TYPE BIGINT;