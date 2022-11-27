/**
 * Tests for db.js
 */
import {describe, expect, test} from '@jest/globals';
import {open, access, constants, stat} from 'node:fs/promises';
import {db} from '../db';
// FS API
var fs = require('fs');
// Require path for addressing static public dir for www server
var path = require('path');

describe('Database module',
         () => {
            test('Test openDB #1', () => {
                let fp;
                var openPromise = new Promise((resolve, reject) => {resolve(db.openDb())});
                var accessPromise = access(db.dbFilePathName, constants.R_OK | constants.W_OK);
                return expect(accessPromise.resolve(undefined)).resolves.toBe(undefined);
            });
         });