USE netflix_binge_analysis;

show tables;




SHOW COLUMNS FROM netflix_titles;
SHOW COLUMNS FROM netflix_watch_history;
SHOW COLUMNS FROM netflix_users;


SELECT u.name AS user_name,
ROUND(SUM(w.duration_watched),2) AS total_hours
FROM netflix_watch_history w
JOIN netflix_users u USING (user_id)
GROUP BY u.name
ORDER BY total_hours DESC
LIMIT 10;

SELECT w.show_id, COUNT(*) AS total_watches
FROM netflix_watch_history w
GROUP BY w.show_id
ORDER BY total_watches DESC
LIMIT 5;

SELECT t.title, t.listed_in AS genre, COUNT(*) AS total_watches
FROM netflix_watch_history w
JOIN netflix_titles t USING (show_id)
GROUP BY t.title, t.listed_in
ORDER BY total_watches DESC
LIMIT 5;

SELECT HOUR(STR_TO_DATE(w.start_time, '%h:%i %p')) AS binge_hour,
COUNT(*) AS total_sessions
FROM netflix_watch_history w
GROUP BY binge_hour
ORDER BY total_sessions DESC
LIMIT 10;

SELECT w.device,
COUNT(*) AS total_sessions,
ROUND(AVG(w.duration_watched),2) AS avg_watch_hours
FROM netflix_watch_history w
GROUP BY w.device
ORDER BY total_sessions DESC;

SELECT u.country,
COUNT(w.watch_id) AS total_sessions,
ROUND(SUM(w.duration_watched),1) AS total_watch_hours
FROM netflix_users u
JOIN netflix_watch_history w USING (user_id)
GROUP BY u.country
ORDER BY total_watch_hours DESC
LIMIT 5;





