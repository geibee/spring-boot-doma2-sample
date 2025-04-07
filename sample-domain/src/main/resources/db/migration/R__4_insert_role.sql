DELETE FROM roles WHERE created_by = 'init';
INSERT INTO roles (role_code, role_name, created_by, created_at) VALUES
('system_admin', 'システム管理者', 'init', CURRENT_TIMESTAMP),
('admin', '管理者', 'init', CURRENT_TIMESTAMP),
('operator', 'オペレーター', 'init', CURRENT_TIMESTAMP),
('user', 'ユーザー', 'init', CURRENT_TIMESTAMP);

DELETE FROM permissions WHERE created_by = 'init';
INSERT INTO permissions (permission_code, permission_name, created_by, created_at) VALUES
('codeCategory:read', '分類マスタ検索', 'init', CURRENT_TIMESTAMP),
('codeCategory:save', '分類マスタ登録・編集', 'init', CURRENT_TIMESTAMP),
('code:read', 'コードマスタ検索', 'init', CURRENT_TIMESTAMP),
('code:save', 'コードマスタ登録・編集', 'init', CURRENT_TIMESTAMP),
('holiday:read', '祝日マスタ検索', 'init', CURRENT_TIMESTAMP),
('holiday:save', '祝日マスタ登録・編集', 'init', CURRENT_TIMESTAMP),
('mailTemplate:read', 'メールテンプレート検索', 'init', CURRENT_TIMESTAMP),
('mailTemplate:save', 'メールテンプレート登録・編集', 'init', CURRENT_TIMESTAMP),
('role:read', 'ロール検索', 'init', CURRENT_TIMESTAMP),
('role:save', 'ロール登録・編集', 'init', CURRENT_TIMESTAMP),
('uploadFile', 'ファイルアップロード', 'init', CURRENT_TIMESTAMP),
('user:read', '顧客マスタ検索', 'init', CURRENT_TIMESTAMP),
('user:save', '顧客マスタ登録・編集', 'init', CURRENT_TIMESTAMP),
('staff:read', '担当者マスタ検索', 'init', CURRENT_TIMESTAMP),
('staff:save', '担当者マスタ登録・編集', 'init', CURRENT_TIMESTAMP);

DELETE FROM role_permissions WHERE created_by = 'init';
INSERT INTO role_permissions (role_code, permission_code, is_enabled, created_by, created_at)
    SELECT 'system_admin', permission_code, TRUE, 'init', CURRENT_TIMESTAMP FROM permissions;
INSERT INTO role_permissions (role_code, permission_code, is_enabled, created_by, created_at)
    SELECT 'admin', permission_code, FALSE, 'init', CURRENT_TIMESTAMP FROM permissions;
INSERT INTO role_permissions (role_code, permission_code, is_enabled, created_by, created_at)
    SELECT 'operator', permission_code, FALSE, 'init', CURRENT_TIMESTAMP FROM permissions;
INSERT INTO role_permissions (role_code, permission_code, is_enabled, created_by, created_at)
    SELECT 'user', permission_code, FALSE, 'init', CURRENT_TIMESTAMP FROM permissions;

DELETE FROM staff_roles WHERE created_by = 'init';
INSERT INTO staff_roles (staff_id, role_code, created_by, created_at) VALUES
((SELECT staff_id FROM staffs WHERE email = 'test@sample.com' AND deleted_at IS NULL), 'system_admin', 'init', CURRENT_TIMESTAMP);

DELETE FROM user_roles WHERE created_by = 'init';
INSERT INTO user_roles (user_id, role_code, created_by, created_at) VALUES
((SELECT user_id FROM users WHERE email = 'test@sample.com' AND deleted_at IS NULL), 'user', 'init', CURRENT_TIMESTAMP);