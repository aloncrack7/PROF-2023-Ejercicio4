sqlite3 Employees.db ".backup tmp.db"
sqlite3 Employees.db "SELECT 'DROP TABLE IF EXISTS ' || name || ';' AS sql_command FROM sqlite_master WHERE type = 'table';" | sqlite3 Employees.db 2>/dev/null || true
sqlite3 Employees.db < sqlite.sql
sqlite3 Employees.db ".restore tmp.db"
rm tmp.db