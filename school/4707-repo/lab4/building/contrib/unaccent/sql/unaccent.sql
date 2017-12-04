CREATE EXTENSION unaccent;

-- must have a UTF8 database
SELECT getdatabaseencoding();

SET client_encoding TO 'KOI8';

SELECT unaccent('foobar');
SELECT unaccent('����');
SELECT unaccent('����');

SELECT unaccent('unaccent', 'foobar');
SELECT unaccent('unaccent', '����');
SELECT unaccent('unaccent', '����');

SELECT ts_lexize('unaccent', 'foobar');
SELECT ts_lexize('unaccent', '����');
SELECT ts_lexize('unaccent', '����');
