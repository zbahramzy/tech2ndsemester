USE zaland_bank;
INSERT INTO accounts (name, balance) VALUES ('Bob', 1000);


START TRANSACTION;
    SELECT accounts.balance FROM accounts WHERE id = 1;
    UPDATE accounts SET balance = balance + 100 WHERE id = 1;
COMMIT;