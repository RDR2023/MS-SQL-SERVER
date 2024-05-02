-- Suggested testing environment:
-- https://sqliteonline.com/ with language set as MS SQL

-- Example case create statement:
CREATE TABLE messages ( 
    id INTEGER NOT NULL PRIMARY KEY,
    type VARCHAR(30) NOT NULL,
    data VARCHAR(100) NOT NULL
);

CREATE TABLE notifications ( 
    id INTEGER NOT NULL PRIMARY KEY,
    message VARCHAR(100) NOT NULL
);

CREATE TABLE alerts ( 
    id INTEGER NOT NULL PRIMARY KEY,
    shortMessage VARCHAR(15) NOT NULL
);

INSERT INTO messages (id, type, data) VALUES (0, 'notification', 'Hello') ;
INSERT INTO messages (id, type, data) VALUES (1, 'alert', 'Danger! Danger! Danger!');

-- Execute your submission in a separate run from the CREATE TABLE statements
-- Write your code here
-- Execute this in a separate run from your submission
EXEC ParseMessages;

SELECT id, 'notification' as type, message FROM notifications 
UNION
SELECT id, 'alert' as type, shortMessage FROM alerts
-- Expected output (in any order):
-- id   type            message
-- ----------------------------
-- 0    notification    Hello
-- 1    alert           Danger! Danger!