# 1. The 5 Most Viewed TED Talks and Common Tags Among Them
-- Most 5 Viewed TED Talks
SELECT t.talk_id, t.title, t.view
FROM talks t
ORDER BY t.view DESC
LIMIT 5;

-- 5 Common Tags Among These Talks
SELECT tag.tag_name
FROM tags tag
JOIN talktags tt ON tag.tag_id = tt.tag_id
JOIN (
    SELECT t.talk_id
    FROM talks t
    ORDER BY t.view DESC
    LIMIT 5
) top_talks ON tt.talk_id = top_talks.talk_id
GROUP BY tag.tag_name
ORDER BY COUNT(*) DESC
LIMIT 5;

# 2. The Most 5 Popular TED Talk Speakers and 5 Common Tags Among Them
-- Most 5 Popular TED Talk Speakers
SELECT t.speaker
FROM talks t
GROUP BY t.speaker
ORDER BY SUM(t.view) DESC
LIMIT 5;

-- 5 Common Tags Among These Talks by Popular Speakers
SELECT tag.tag_name
FROM tags tag
JOIN talktags tt ON tag.tag_id = tt.tag_id
JOIN (
    SELECT t.talk_id
    FROM talks t
    JOIN (
        SELECT speaker
        FROM talks
        GROUP BY speaker
        ORDER BY SUM(view) DESC
        LIMIT 5
    ) top_speakers ON t.speaker = top_speakers.speaker
) top_speakers_talks ON tt.talk_id = top_speakers_talks.talk_id
GROUP BY tag.tag_name
ORDER BY COUNT(*) DESC
LIMIT 5;

# 3. 
-- What are the most and least popular/views months?
-- For the most popular month
(SELECT t.month, SUM(t.view) AS total_views
FROM talks t
GROUP BY t.month
ORDER BY total_views DESC
LIMIT 1)
UNION ALL

-- For the least popular month
(SELECT t.month, SUM(t.view) AS total_views
FROM talks t
GROUP BY t.month
ORDER BY total_views ASC
LIMIT 1);

