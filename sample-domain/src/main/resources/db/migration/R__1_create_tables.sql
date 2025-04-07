CREATE TABLE IF NOT EXISTS persistent_logins(
  username VARCHAR(64) NOT NULL,
  ip_address VARCHAR(64) NOT NULL,
  user_agent VARCHAR(200) NOT NULL,
  series VARCHAR(64),
  token VARCHAR(64) NOT NULL,
  last_used TIMESTAMP NOT NULL,
  PRIMARY KEY (series),
  CONSTRAINT idx_persistent_logins UNIQUE (username, ip_address, user_agent),
  CONSTRAINT idx_persistent_logins_01 UNIQUE (last_used)
);
COMMENT ON TABLE persistent_logins IS 'ログイン記録';
COMMENT ON COLUMN persistent_logins.username IS 'ログインID';
COMMENT ON COLUMN persistent_logins.ip_address IS 'IPアドレス';
COMMENT ON COLUMN persistent_logins.user_agent IS 'UserAgent';
COMMENT ON COLUMN persistent_logins.series IS '直列トークン';
COMMENT ON COLUMN persistent_logins.token IS 'トークン';
COMMENT ON COLUMN persistent_logins.last_used IS '最終利用日';

CREATE TABLE IF NOT EXISTS code_categories(
  code_category_id SERIAL PRIMARY KEY,
  category_code VARCHAR(50) NOT NULL,
  category_name VARCHAR(50) NOT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_code_categories ON code_categories (category_code, deleted_at);
COMMENT ON TABLE code_categories IS 'コード分類';
COMMENT ON COLUMN code_categories.code_category_id IS 'コード分類ID';
COMMENT ON COLUMN code_categories.category_code IS '分類コード';
COMMENT ON COLUMN code_categories.category_name IS '分類名';
COMMENT ON COLUMN code_categories.created_by IS '登録者';
COMMENT ON COLUMN code_categories.created_at IS '登録日時';
COMMENT ON COLUMN code_categories.updated_by IS '更新者';
COMMENT ON COLUMN code_categories.updated_at IS '更新日時';
COMMENT ON COLUMN code_categories.deleted_by IS '削除者';
COMMENT ON COLUMN code_categories.deleted_at IS '削除日時';
COMMENT ON COLUMN code_categories.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS codes(
  code_id SERIAL PRIMARY KEY,
  category_code VARCHAR(50) NOT NULL,
  code_value VARCHAR(100) NOT NULL,
  code_name VARCHAR(50) NOT NULL,
  code_alias VARCHAR(100) DEFAULT NULL,
  display_order INTEGER DEFAULT 0,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_codes ON codes (category_code, deleted_at);
COMMENT ON TABLE codes IS 'コード';
COMMENT ON COLUMN codes.code_id IS 'コードID';
COMMENT ON COLUMN codes.category_code IS '分類コード';
COMMENT ON COLUMN codes.code_value IS 'コード値';
COMMENT ON COLUMN codes.code_name IS 'コード名';
COMMENT ON COLUMN codes.code_alias IS 'コードエイリアス';
COMMENT ON COLUMN codes.display_order IS '表示順';
COMMENT ON COLUMN codes.created_by IS '登録者';
COMMENT ON COLUMN codes.created_at IS '登録日時';
COMMENT ON COLUMN codes.updated_by IS '更新者';
COMMENT ON COLUMN codes.updated_at IS '更新日時';
COMMENT ON COLUMN codes.deleted_by IS '削除者';
COMMENT ON COLUMN codes.deleted_at IS '削除日時';
COMMENT ON COLUMN codes.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS permissions(
  permission_id SERIAL PRIMARY KEY,
  permission_code VARCHAR(50) NOT NULL,
  permission_name VARCHAR(50) NOT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_permissions ON permissions (permission_code, deleted_at);
COMMENT ON TABLE permissions IS '権限';
COMMENT ON COLUMN permissions.permission_id IS '権限ID';
COMMENT ON COLUMN permissions.permission_code IS '権限コード';
COMMENT ON COLUMN permissions.permission_name IS '権限名';
COMMENT ON COLUMN permissions.created_by IS '登録者';
COMMENT ON COLUMN permissions.created_at IS '登録日時';
COMMENT ON COLUMN permissions.updated_by IS '更新者';
COMMENT ON COLUMN permissions.updated_at IS '更新日時';
COMMENT ON COLUMN permissions.deleted_by IS '削除者';
COMMENT ON COLUMN permissions.deleted_at IS '削除日時';
COMMENT ON COLUMN permissions.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS roles(
  role_id SERIAL PRIMARY KEY,
  role_code VARCHAR(50) NOT NULL,
  role_name VARCHAR(100) NOT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_roles ON roles (role_code, deleted_at);
COMMENT ON TABLE roles IS 'ロール';
COMMENT ON COLUMN roles.role_id IS 'ロールID';
COMMENT ON COLUMN roles.role_code IS 'ロールコード';
COMMENT ON COLUMN roles.role_name IS 'ロール名';
COMMENT ON COLUMN roles.created_by IS '登録者';
COMMENT ON COLUMN roles.created_at IS '登録日時';
COMMENT ON COLUMN roles.updated_by IS '更新者';
COMMENT ON COLUMN roles.updated_at IS '更新日時';
COMMENT ON COLUMN roles.deleted_by IS '削除者';
COMMENT ON COLUMN roles.deleted_at IS '削除日時';
COMMENT ON COLUMN roles.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS role_permissions(
  role_permission_id SERIAL PRIMARY KEY,
  role_code VARCHAR(50) NOT NULL,
  permission_code VARCHAR(50) NOT NULL,
  is_enabled BOOLEAN NOT NULL DEFAULT FALSE,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_role_permissions ON role_permissions (role_code, deleted_at);
COMMENT ON TABLE role_permissions IS 'ロール権限紐付け';
COMMENT ON COLUMN role_permissions.role_permission_id IS 'ロール権限紐付けID';
COMMENT ON COLUMN role_permissions.role_code IS 'ロールコード';
COMMENT ON COLUMN role_permissions.permission_code IS '権限コード';
COMMENT ON COLUMN role_permissions.is_enabled IS '有効フラグ';
COMMENT ON COLUMN role_permissions.created_by IS '登録者';
COMMENT ON COLUMN role_permissions.created_at IS '登録日時';
COMMENT ON COLUMN role_permissions.updated_by IS '更新者';
COMMENT ON COLUMN role_permissions.updated_at IS '更新日時';
COMMENT ON COLUMN role_permissions.deleted_by IS '削除者';
COMMENT ON COLUMN role_permissions.deleted_at IS '削除日時';
COMMENT ON COLUMN role_permissions.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS staff_roles(
  staff_role_id SERIAL PRIMARY KEY,
  staff_id INTEGER NOT NULL,
  role_code VARCHAR(50) NOT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_staff_roles ON staff_roles (staff_id, role_code, deleted_at);
COMMENT ON TABLE staff_roles IS '担当者ロール';
COMMENT ON COLUMN staff_roles.staff_role_id IS '担当者ロールID';
COMMENT ON COLUMN staff_roles.staff_id IS '担当者ID';
COMMENT ON COLUMN staff_roles.role_code IS 'ロールコード';
COMMENT ON COLUMN staff_roles.created_by IS '登録者';
COMMENT ON COLUMN staff_roles.created_at IS '登録日時';
COMMENT ON COLUMN staff_roles.updated_by IS '更新者';
COMMENT ON COLUMN staff_roles.updated_at IS '更新日時';
COMMENT ON COLUMN staff_roles.deleted_by IS '削除者';
COMMENT ON COLUMN staff_roles.deleted_at IS '削除日時';
COMMENT ON COLUMN staff_roles.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS user_roles(
  user_role_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  role_code VARCHAR(50) NOT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_user_roles ON user_roles (user_id, role_code, deleted_at);
COMMENT ON TABLE user_roles IS '顧客ロール';
COMMENT ON COLUMN user_roles.user_role_id IS '顧客ロールID';
COMMENT ON COLUMN user_roles.user_id IS 'ユーザーID';
COMMENT ON COLUMN user_roles.role_code IS 'ロールコード';
COMMENT ON COLUMN user_roles.created_by IS '登録者';
COMMENT ON COLUMN user_roles.created_at IS '登録日時';
COMMENT ON COLUMN user_roles.updated_by IS '更新者';
COMMENT ON COLUMN user_roles.updated_at IS '更新日時';
COMMENT ON COLUMN user_roles.deleted_by IS '削除者';
COMMENT ON COLUMN user_roles.deleted_at IS '削除日時';
COMMENT ON COLUMN user_roles.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS staffs(
  staff_id SERIAL PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name VARCHAR(40) NOT NULL,
  email VARCHAR(100) DEFAULT NULL,
  password VARCHAR(100) DEFAULT NULL,
  tel VARCHAR(20) DEFAULT NULL,
  password_reset_token VARCHAR(50) DEFAULT NULL,
  token_expires_at TIMESTAMP DEFAULT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_staffs ON staffs (email, deleted_at);
COMMENT ON TABLE staffs IS '担当者';
COMMENT ON COLUMN staffs.staff_id IS '担当者ID';
COMMENT ON COLUMN staffs.first_name IS '名';
COMMENT ON COLUMN staffs.last_name IS '性';
COMMENT ON COLUMN staffs.email IS 'メールアドレス';
COMMENT ON COLUMN staffs.password IS 'パスワード';
COMMENT ON COLUMN staffs.tel IS '電話番号';
COMMENT ON COLUMN staffs.password_reset_token IS 'パスワードリセットトークン';
COMMENT ON COLUMN staffs.token_expires_at IS 'トークン失効日';
COMMENT ON COLUMN staffs.created_by IS '登録者';
COMMENT ON COLUMN staffs.created_at IS '登録日時';
COMMENT ON COLUMN staffs.updated_by IS '更新者';
COMMENT ON COLUMN staffs.updated_at IS '更新日時';
COMMENT ON COLUMN staffs.deleted_by IS '削除者';
COMMENT ON COLUMN staffs.deleted_at IS '削除日時';
COMMENT ON COLUMN staffs.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS users(
  user_id SERIAL PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name VARCHAR(40) NOT NULL,
  email VARCHAR(100) DEFAULT NULL,
  password VARCHAR(100) DEFAULT NULL,
  tel VARCHAR(20) DEFAULT NULL,
  zip VARCHAR(20) DEFAULT NULL,
  address VARCHAR(100) DEFAULT NULL,
  upload_file_id INTEGER DEFAULT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_users ON users (email, deleted_at);
COMMENT ON TABLE users IS '顧客';
COMMENT ON COLUMN users.user_id IS 'ユーザID';
COMMENT ON COLUMN users.first_name IS '名';
COMMENT ON COLUMN users.last_name IS '性';
COMMENT ON COLUMN users.email IS 'メールアドレス';
COMMENT ON COLUMN users.password IS 'パスワード';
COMMENT ON COLUMN users.tel IS '電話番号';
COMMENT ON COLUMN users.zip IS '郵便番号';
COMMENT ON COLUMN users.address IS '住所';
COMMENT ON COLUMN users.upload_file_id IS '添付ファイル';
COMMENT ON COLUMN users.created_by IS '登録者';
COMMENT ON COLUMN users.created_at IS '登録日時';
COMMENT ON COLUMN users.updated_by IS '更新者';
COMMENT ON COLUMN users.updated_at IS '更新日時';
COMMENT ON COLUMN users.deleted_by IS '削除者';
COMMENT ON COLUMN users.deleted_at IS '削除日時';
COMMENT ON COLUMN users.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS upload_files(
  upload_file_id SERIAL PRIMARY KEY,
  file_name VARCHAR(100) NOT NULL,
  original_file_name VARCHAR(200) NOT NULL,
  content_type VARCHAR(50) NOT NULL,
  content BYTEA NOT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_upload_files ON upload_files (file_name, deleted_at);
COMMENT ON TABLE upload_files IS 'アップロードファイル';
COMMENT ON COLUMN upload_files.upload_file_id IS 'ファイルID';
COMMENT ON COLUMN upload_files.file_name IS 'ファイル名';
COMMENT ON COLUMN upload_files.original_file_name IS 'オリジナルファイル名';
COMMENT ON COLUMN upload_files.content_type IS 'コンテンツタイプ';
COMMENT ON COLUMN upload_files.content IS 'コンテンツ';
COMMENT ON COLUMN upload_files.created_by IS '登録者';
COMMENT ON COLUMN upload_files.created_at IS '登録日時';
COMMENT ON COLUMN upload_files.updated_by IS '更新者';
COMMENT ON COLUMN upload_files.updated_at IS '更新日時';
COMMENT ON COLUMN upload_files.deleted_by IS '削除者';
COMMENT ON COLUMN upload_files.deleted_at IS '削除日時';
COMMENT ON COLUMN upload_files.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS mail_templates(
  mail_template_id SERIAL PRIMARY KEY,
  category_code VARCHAR(50) DEFAULT NULL,
  template_code VARCHAR(100) NOT NULL,
  subject VARCHAR(100) NOT NULL,
  template_body TEXT NOT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_mail_templates ON mail_templates (template_code, deleted_at);
COMMENT ON TABLE mail_templates IS 'メールテンプレート';
COMMENT ON COLUMN mail_templates.mail_template_id IS 'メールテンプレートID';
COMMENT ON COLUMN mail_templates.category_code IS 'テンプレート分類コード';
COMMENT ON COLUMN mail_templates.template_code IS 'テンプレートコード';
COMMENT ON COLUMN mail_templates.subject IS 'メールタイトル';
COMMENT ON COLUMN mail_templates.template_body IS 'メール本文';
COMMENT ON COLUMN mail_templates.created_by IS '登録者';
COMMENT ON COLUMN mail_templates.created_at IS '登録日時';
COMMENT ON COLUMN mail_templates.updated_by IS '更新者';
COMMENT ON COLUMN mail_templates.updated_at IS '更新日時';
COMMENT ON COLUMN mail_templates.deleted_by IS '削除者';
COMMENT ON COLUMN mail_templates.deleted_at IS '削除日時';
COMMENT ON COLUMN mail_templates.version IS '改訂番号';

CREATE TABLE IF NOT EXISTS send_mail_queue(
  send_mail_queue_id SERIAL NOT NULL,
  created_at TIMESTAMP NOT NULL,
  from_address VARCHAR(255) NOT NULL,
  to_address VARCHAR(255) DEFAULT NULL,
  cc_address VARCHAR(255) DEFAULT NULL,
  bcc_address VARCHAR(255) DEFAULT NULL,
  subject VARCHAR(255) DEFAULT NULL,
  body TEXT,
  sent_at TIMESTAMP DEFAULT NULL,
  created_by VARCHAR(50) NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (created_at, send_mail_queue_id)
) PARTITION BY RANGE (created_at);

CREATE SEQUENCE IF NOT EXISTS send_mail_queue_id_seq;
CREATE INDEX idx_send_mail_queue ON send_mail_queue (sent_at, deleted_at);
COMMENT ON TABLE send_mail_queue IS 'メール送信キュー';
COMMENT ON COLUMN send_mail_queue.send_mail_queue_id IS 'メール送信キューID';
COMMENT ON COLUMN send_mail_queue.from_address IS 'fromアドレス';
COMMENT ON COLUMN send_mail_queue.to_address IS 'toアドレス';
COMMENT ON COLUMN send_mail_queue.cc_address IS 'ccアドレス';
COMMENT ON COLUMN send_mail_queue.bcc_address IS 'bccアドレス';
COMMENT ON COLUMN send_mail_queue.subject IS '件名';
COMMENT ON COLUMN send_mail_queue.body IS 'メール本文';
COMMENT ON COLUMN send_mail_queue.sent_at IS 'メール送信日時';
COMMENT ON COLUMN send_mail_queue.created_by IS '登録者';
COMMENT ON COLUMN send_mail_queue.created_at IS '登録日時';
COMMENT ON COLUMN send_mail_queue.updated_by IS '更新者';
COMMENT ON COLUMN send_mail_queue.updated_at IS '更新日時';
COMMENT ON COLUMN send_mail_queue.deleted_by IS '削除者';
COMMENT ON COLUMN send_mail_queue.deleted_at IS '削除日時';
COMMENT ON COLUMN send_mail_queue.version IS '改訂番号';

CREATE TABLE send_mail_queue_p2022 PARTITION OF send_mail_queue
  FOR VALUES FROM ('2022-01-01 00:00:00') TO ('2023-01-01 00:00:00');
CREATE TABLE send_mail_queue_p2023 PARTITION OF send_mail_queue
  FOR VALUES FROM ('2023-01-01 00:00:00') TO ('2024-01-01 00:00:00');
CREATE TABLE send_mail_queue_p2024 PARTITION OF send_mail_queue
  FOR VALUES FROM ('2024-01-01 00:00:00') TO ('2025-01-01 00:00:00');
CREATE TABLE send_mail_queue_p2025 PARTITION OF send_mail_queue
  FOR VALUES FROM ('2025-01-01 00:00:00') TO ('2026-01-01 00:00:00');
CREATE TABLE send_mail_queue_p2026 PARTITION OF send_mail_queue
  FOR VALUES FROM ('2026-01-01 00:00:00') TO ('2027-01-01 00:00:00');
CREATE TABLE send_mail_queue_p2027 PARTITION OF send_mail_queue
  FOR VALUES FROM ('2027-01-01 00:00:00') TO ('2028-01-01 00:00:00');
CREATE TABLE send_mail_queue_p2028 PARTITION OF send_mail_queue
  FOR VALUES FROM ('2028-01-01 00:00:00') TO ('2029-01-01 00:00:00');
CREATE TABLE send_mail_queue_p2029 PARTITION OF send_mail_queue
  FOR VALUES FROM ('2029-01-01 00:00:00') TO ('2030-01-01 00:00:00');
CREATE TABLE send_mail_queue_p2030 PARTITION OF send_mail_queue
  FOR VALUES FROM ('2030-01-01 00:00:00') TO ('2031-01-01 00:00:00');

CREATE TABLE IF NOT EXISTS holidays(
  holiday_id SERIAL PRIMARY KEY,
  holiday_name VARCHAR(100) NOT NULL,
  holiday_date DATE NOT NULL,
  created_by VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_by VARCHAR(255) DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  deleted_by VARCHAR(255) DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  version INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_holidays ON holidays (holiday_name, deleted_at);
COMMENT ON TABLE holidays IS '祝日';
COMMENT ON COLUMN holidays.holiday_id IS '祝日ID';
COMMENT ON COLUMN holidays.holiday_name IS '祝日名';
COMMENT ON COLUMN holidays.holiday_date IS '日付';
COMMENT ON COLUMN holidays.created_by IS '登録者';
COMMENT ON COLUMN holidays.created_at IS '登録日時';
COMMENT ON COLUMN holidays.updated_by IS '更新者';
COMMENT ON COLUMN holidays.updated_at IS '更新日時';
COMMENT ON COLUMN holidays.deleted_by IS '削除者';
COMMENT ON COLUMN holidays.deleted_at IS '削除日時';
COMMENT ON COLUMN holidays.version IS '改訂番号';