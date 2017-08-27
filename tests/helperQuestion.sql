-- BLOCK select_assessment_instances
SELECT
    ai.*
FROM
    assessment_instances AS ai;

-- BLOCK select_assessment_instance_durations
SELECT
    extract (epoch FROM ai.duration) AS duration
FROM
    assessment_instances AS ai;

-- BLOCK select_instance_questions
SELECT
    iq.*,
    q.qid
FROM
    instance_questions AS iq
    JOIN assessment_questions AS aq ON (aq.id = iq.assessment_question_id)
    JOIN questions AS q ON (q.id = aq.question_id)
ORDER BY
    q.qid;

-- BLOCK select_instance_question
SELECT
    iq.*
FROM
    instance_questions AS iq
WHERE
    iq.id = $instance_question_id;

-- BLOCK select_assessment_instance
SELECT
    ai.*
FROM
    assessment_instances AS ai
WHERE
    ai.id = $assessment_instance_id;

-- BLOCK select_variants
SELECT
    v.*
FROM
    variants AS v
ORDER BY
    v.date;

-- BLOCK select_variant
SELECT
    v.*
FROM
    variants AS v
WHERE
    v.id = $variant_id;

-- BLOCK select_last_submission
SELECT
    s.*
FROM
    submissions AS s
ORDER BY
    s.date DESC
LIMIT
    1;

-- BLOCK select_last_submission_for_question
SELECT
    s.*
FROM
    submissions AS s
    JOIN variants AS v ON (v.id = s.variant_id)
WHERE
    v.question_id = $question_id
ORDER BY
    s.date DESC
LIMIT
    1;

-- BLOCK select_last_submission_for_instance_question
SELECT
    s.*
FROM
    submissions AS s
    JOIN variants AS v ON (v.id = s.variant_id)
WHERE
    v.instance_question_id = $instance_question_id
ORDER BY
    s.date DESC
LIMIT
    1;

-- BLOCK select_question_by_qid
SELECT *
FROM questions
WHERE qid = $qid;

-- BLOCK select_last_job_sequence
SELECT *
FROM job_sequences
ORDER BY start_date DESC
LIMIT 1;

-- BLOCK select_job_sequence
SELECT *
FROM job_sequences
WHERE id = $job_sequence_id;

-- BLOCK select_errors_for_last_variant
WITH last_variant AS (
    SELECT *
    FROM variants
    ORDER BY date DESC
    LIMIT 1
)
SELECT *
FROM
    errors,
    last_variant
WHERE variant_id = last_variant.id;
