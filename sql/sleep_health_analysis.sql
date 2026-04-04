-- ============================================================
-- Sleep Health & Lifestyle Analysis — SQL Queries
-- Dataset: sleep_health_dataset (100,000 rows, 32 columns)
-- ============================================================

-- Table Creation
CREATE TABLE sleep_health (
    person_id                    INT PRIMARY KEY,
    age                          INT,
    gender                       VARCHAR(10),
    occupation                   VARCHAR(30),
    bmi                          DECIMAL(5,2),
    country                      VARCHAR(30),
    sleep_duration_hrs           DECIMAL(5,2),
    sleep_quality_score          DECIMAL(4,2),
    rem_percentage               DECIMAL(5,2),
    deep_sleep_percentage        DECIMAL(5,2),
    sleep_latency_mins           INT,
    wake_episodes_per_night      INT,
    caffeine_mg_before_bed       INT,
    alcohol_units_before_bed     DECIMAL(4,2),
    screen_time_before_bed_mins  INT,
    exercise_day                 TINYINT,
    steps_that_day               INT,
    nap_duration_mins            INT,
    stress_score                 DECIMAL(4,2),
    work_hours_that_day          DECIMAL(5,2),
    chronotype                   VARCHAR(15),
    mental_health_condition      VARCHAR(20),
    heart_rate_resting_bpm       INT,
    sleep_aid_used               TINYINT,
    shift_work                   TINYINT,
    room_temperature_celsius     DECIMAL(5,2),
    weekend_sleep_diff_hrs       DECIMAL(5,2),
    season                       VARCHAR(10),
    day_type                     VARCHAR(10),
    cognitive_performance_score  DECIMAL(5,2),
    sleep_disorder_risk          VARCHAR(15),
    felt_rested                  TINYINT
);

-- ============================================================
-- 1. Overall Summary Statistics
-- ============================================================
SELECT
    COUNT(*)                                          AS total_records,
    COUNT(DISTINCT person_id)                         AS unique_persons,
    ROUND(AVG(sleep_duration_hrs), 2)                 AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)                AS avg_quality,
    ROUND(AVG(stress_score), 2)                       AS avg_stress,
    ROUND(AVG(cognitive_performance_score), 2)        AS avg_cognitive,
    ROUND(AVG(felt_rested) * 100, 1)                  AS pct_felt_rested
FROM sleep_health;

-- ============================================================
-- 2. Sleep Disorder Risk Distribution
-- ============================================================
SELECT
    sleep_disorder_risk,
    COUNT(*)                                           AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM sleep_health), 1) AS pct
FROM sleep_health
GROUP BY sleep_disorder_risk
ORDER BY count DESC;

-- ============================================================
-- 3. Average Sleep Metrics by Gender
-- ============================================================
SELECT
    gender,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(stress_score), 2)                AS avg_stress,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY gender
ORDER BY avg_quality DESC;

-- ============================================================
-- 4. Sleep Quality by Occupation
-- ============================================================
SELECT
    occupation,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(cognitive_performance_score), 2) AS avg_cognitive,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY occupation
ORDER BY avg_quality DESC;

-- ============================================================
-- 5. Sleep Quality by Country
-- ============================================================
SELECT
    country,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(stress_score), 2)                AS avg_stress,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY country
ORDER BY avg_quality DESC;

-- ============================================================
-- 6. Caffeine Impact on Sleep
-- ============================================================
SELECT
    caffeine_mg_before_bed,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(sleep_latency_mins), 1)          AS avg_latency,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY caffeine_mg_before_bed
ORDER BY caffeine_mg_before_bed;

-- ============================================================
-- 7. Alcohol Impact on Sleep
-- ============================================================
SELECT
    alcohol_units_before_bed,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(wake_episodes_per_night), 2)     AS avg_wake_episodes,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY alcohol_units_before_bed
ORDER BY alcohol_units_before_bed;

-- ============================================================
-- 8. Mental Health Condition Impact
-- ============================================================
SELECT
    mental_health_condition,
    COUNT(*)                                           AS count,
    ROUND(AVG(sleep_duration_hrs), 2)                  AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)                 AS avg_quality,
    ROUND(AVG(stress_score), 2)                        AS avg_stress,
    ROUND(AVG(cognitive_performance_score), 2)         AS avg_cognitive,
    ROUND(AVG(felt_rested) * 100, 1)                   AS pct_rested,
    ROUND(SUM(CASE WHEN sleep_disorder_risk IN ('Moderate','Severe')
          THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1)   AS pct_high_risk
FROM sleep_health
GROUP BY mental_health_condition
ORDER BY avg_quality DESC;

-- ============================================================
-- 9. Chronotype Analysis
-- ============================================================
SELECT
    chronotype,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(sleep_latency_mins), 1)          AS avg_latency_min,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY chronotype
ORDER BY avg_quality DESC;

-- ============================================================
-- 10. Exercise vs No Exercise
-- ============================================================
SELECT
    CASE WHEN exercise_day = 1 THEN 'Exercised' ELSE 'No Exercise' END AS exercise_status,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(stress_score), 2)                AS avg_stress,
    ROUND(AVG(cognitive_performance_score), 2) AS avg_cognitive,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY exercise_day;

-- ============================================================
-- 11. Sleep Aid Usage Analysis
-- ============================================================
SELECT
    CASE WHEN sleep_aid_used = 1 THEN 'Used Sleep Aid' ELSE 'No Sleep Aid' END AS aid_status,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(sleep_latency_mins), 1)          AS avg_latency,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY sleep_aid_used;

-- ============================================================
-- 12. Seasonal Sleep Patterns
-- ============================================================
SELECT
    season,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY season
ORDER BY avg_quality DESC;

-- ============================================================
-- 13. Weekday vs Weekend Sleep
-- ============================================================
SELECT
    day_type,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(stress_score), 2)                AS avg_stress,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY day_type;

-- ============================================================
-- 14. Age Group Analysis
-- ============================================================
SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56-69'
    END AS age_group,
    COUNT(*)                                           AS count,
    ROUND(AVG(sleep_duration_hrs), 2)                  AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)                 AS avg_quality,
    ROUND(AVG(cognitive_performance_score), 2)         AS avg_cognitive,
    ROUND(SUM(CASE WHEN sleep_disorder_risk = 'Severe'
          THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1)   AS pct_severe_risk
FROM sleep_health
GROUP BY age_group
ORDER BY age_group;

-- ============================================================
-- 15. Shift Work Impact
-- ============================================================
SELECT
    CASE WHEN shift_work = 1 THEN 'Shift Worker' ELSE 'Non-Shift' END AS work_type,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_duration_hrs), 2)          AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(stress_score), 2)                AS avg_stress,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested,
    ROUND(SUM(CASE WHEN sleep_disorder_risk IN ('Moderate','Severe')
          THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_high_risk
FROM sleep_health
GROUP BY shift_work;

-- ============================================================
-- 16. Screen Time Impact (Binned)
-- ============================================================
SELECT
    CASE
        WHEN screen_time_before_bed_mins <= 30  THEN '0-30 min'
        WHEN screen_time_before_bed_mins <= 60  THEN '31-60 min'
        WHEN screen_time_before_bed_mins <= 90  THEN '61-90 min'
        WHEN screen_time_before_bed_mins <= 120 THEN '91-120 min'
        ELSE '121-180 min'
    END AS screen_time_bin,
    COUNT(*)                                   AS count,
    ROUND(AVG(sleep_quality_score), 2)         AS avg_quality,
    ROUND(AVG(sleep_latency_mins), 1)          AS avg_latency,
    ROUND(AVG(felt_rested) * 100, 1)           AS pct_rested
FROM sleep_health
GROUP BY screen_time_bin
ORDER BY screen_time_bin;

-- ============================================================
-- 17. Top Predictors: People Who Felt Rested vs Not
-- ============================================================
SELECT
    CASE WHEN felt_rested = 1 THEN 'Rested' ELSE 'Not Rested' END AS rested_status,
    COUNT(*)                                           AS count,
    ROUND(AVG(sleep_duration_hrs), 2)                  AS avg_duration,
    ROUND(AVG(sleep_quality_score), 2)                 AS avg_quality,
    ROUND(AVG(deep_sleep_percentage), 2)               AS avg_deep_sleep_pct,
    ROUND(AVG(rem_percentage), 2)                      AS avg_rem_pct,
    ROUND(AVG(wake_episodes_per_night), 2)             AS avg_wake_episodes,
    ROUND(AVG(stress_score), 2)                        AS avg_stress,
    ROUND(AVG(caffeine_mg_before_bed), 1)              AS avg_caffeine,
    ROUND(AVG(screen_time_before_bed_mins), 1)         AS avg_screen_time,
    ROUND(AVG(cognitive_performance_score), 2)         AS avg_cognitive
FROM sleep_health
GROUP BY felt_rested;
