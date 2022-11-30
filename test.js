/**
 * test.js
 *
 * Entry point file for testing rapr
 */

/**
 * Tests for db.js
 */
 const {describe, expect, test} = require('@jest/globals');
 const {open, access, constants, stat} = require('node:fs/promises');
 const {exec} = require("child_process");
 var db = require('./db');
 // FS API
 var fs = require('fs');
 // Require path for addressing static public dir for www server
 var path = require('path');
 
 describe('Database module',
          () => {
             test('Test openDB #1', () => {
                 var openPromise = new Promise((resolve, reject) => {resolve(db.openDb())});
                 return expect(openPromise.then((db) => {access(db.dbFilePathName, constants.R_OK | constants.W_OK)})).resolves.toBe(undefined);
             });
             test('Test initDB #1', () => {
                exec("node ./bin/accountingdb -- --init-db", (error, stdout, stderr) => {
                    if (error)
                        return expect().rejects.not;
                    expect().toEqual('****** Constructor for db ...\ninitdb: argc = 4 ...\ninitdb: argv[0] = C:\\Users\\a047461\\.nvm\\versions\\node\\v16.17.0\\bin\\node.exe ...\ninitdb: argv[1] = C:\\Users\\a047461\\ONEDRI~1\\Sources\\Raprochements\\bin\\accountingdb ...\ninitdb: argv[2] = -- ...\ninitdb: argv[3] = --init-db ...\naccountingdb: invalid arg: process.argv[2] = -- ...\n[accountingdb] --init-db\nDeleting DB file C:\Users\a047461\AppData\Local\rapr\accounting.db ...\n*> [accountingdb] --init-db\n***>===============================<***\nDelete DB file: done!\ninitdb: open DB ...\n****** Opening Accounting DB ...\ninitdb: Creating tables schema in DB ...\ninitdb: Opening transaction ...\ninitdb: Create table \'Accounts\' ...\ninitdb: Table \'Accounts\' created!\ninitdb: Create table \'Currrencies\' ...\ninitdb: Table \nCurrencies\' created!\ninitdb: Adding records in table Currencies ...\ninitdb: Added \'Currencies\' records in DB!\ninitdb: Create \'Banks\' table ...\ninitdb: Table \'Banks\' created!\ninitdb: Adding records in table \'Banks\' ...\ninitdb: Added \'Banks\' records in DB!\ninitdb: Create \'Statements\' table ...\ninitdb: Table \'Statements\' created!\ninitdb: Create \'Balances\' table ...\ninitdb: Table \'Balances\' created!\ninitdb: Create \'BalanceTypeCodes\' table ...\ninitdb: Table \'BalanceTypeCodes\' created!\ninitdb: Adding records in table \nBalanceTypeCodes\' ...\ninitdb: Added \'BalanceTypeCodes\' records in DB!\ninitdb: Create \'Entries\' table ...\ninitdb: Table \'Entries\' created!\ninitdb: Create \'StatusCodes\' table ...\ninitdb: Table \'StatusCodes\' created!\ninitdb: Adding records in table \'StatusCodes\' ...\ninitdb: Added \'StatusCodes\' records in DB!\ninitdb: Create \'Accounts\' table index ...\ninitdb: \'Accounts\' table index created!\ninitdb: Create \'StatementsAccountsIdx\' table index ...\ninitdb: \'StatementsAccountsIdx\' table index created!\ninitdb: Create \'StatementsBalanceIdx\' table index ...\ninitdb: \'StatementsBalanceIdx\' table index created!\ninitdb: Create \'EntriesCreditDebitIdx\' table index ...\ninitdb: \'EntriesCreditDebitIdx\' table index created!\ninitdb: Create \'EntriesBookingDateTimeIdx\' table index ...\ninitdb: \'EntriesBookingDateTimeIdx\' table index created!\ninitdb: Create \'EntriesValueDateTimeIdx\' table index ...\ninitdb: \'EntriesValueDateTimeIdx\' table index created!\n****** Accounting DB openned !\n\n');
                });
             });
             test('Test dumpDB #1', () => {});
             test('Test restoreDB #1', () => {});
             
          });
