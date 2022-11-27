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
 var db = require('./db');
 // FS API
 var fs = require('fs');
 // Require path for addressing static public dir for www server
 var path = require('path');
 
 describe('Database module',
          () => {
             test('Test openDB #1', () => {
                 let fp;
                 var openPromise = new Promise((resolve, reject) => {resolve(db.openDb())});
                 return expect(openPromise.then(access(db.dbFilePathName, constants.R_OK | constants.W_OK)).resolve(undefined)).resolves.toBe(undefined);
             });
          });
