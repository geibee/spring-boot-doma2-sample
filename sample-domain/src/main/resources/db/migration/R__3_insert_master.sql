DELETE FROM staffs WHERE email = 'test@sample.com';
INSERT INTO staffs(first_name, last_name, email, password, tel, created_by, created_at) VALUES
('john', 'doe', 'test@sample.com', '$2a$06$hY5MzfruCds1t5uFLzrlBuw3HcrEGeysr9xJE4Cml5xEOVf425pmK', '09011112222', 'init', CURRENT_TIMESTAMP);

DELETE FROM users WHERE email = 'test@sample.com';
INSERT INTO users(first_name, last_name, email, password, tel, address, created_by, created_at) VALUES
('john', 'doe', 'test@sample.com', '$2a$06$hY5MzfruCds1t5uFLzrlBuw3HcrEGeysr9xJE4Cml5xEOVf425pmK', '09011112222', 'tokyo, chuo-ku 1-2-3', 'init', CURRENT_TIMESTAMP);

DELETE FROM mail_templates WHERE created_by = 'init';
INSERT INTO mail_templates (category_code, template_code, subject, template_body, created_by, created_at) VALUES
(NULL, 'passwordReset', 'パスワードリセット完了のお願い', '[[${staff.firstName}]]さん

下記のリンクを開いてパスワードをリセットしてください。
[[${url}]]', 'init', CURRENT_TIMESTAMP),
(NULL, 'birthdayMail', '誕生日のお祝いメール', '[[${user.lastName}]] [[${user.firstName}]]さん
誕生日おめでとう！', 'init', CURRENT_TIMESTAMP);