/* Region populate */

INSERT INTO "Region" ("RegName", "AreaName", "TerName", "TerTypeName")
SELECT DISTINCT REGNAME, AREANAME, TERNAME, TerTypeName
FROM zno;


INSERT INTO "Region" ("RegName", "AreaName", "TerName")
SELECT DISTINCT EORegName, EOAreaName, EOTerName
FROM zno
WHERE EORegName IS NOT NULL AND EOAreaName IS NOT NULL AND EOTerName IS NOT NULL
EXCEPT
SELECT "RegName", "AreaName", "TerName"
FROM "Region";

/* Educational objectives populate */

INSERT INTO "EO" ("EOName", "EOTypeName", "EOParent", "RegionID", "ClassLang")
SELECT DISTINCT on (zno.EONAME) zno.EONAME, zno.EOTYPENAME, zno.EOParent, "Region"."RegionID", zno.ClassLangName
FROM zno
LEFT JOIN "Region"
ON zno.EORegName = "Region"."RegName" AND zno.AreaName = "Region"."AreaName" AND zno.EOTerName = "Region"."TerName"
WHERE zno.EONAME IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.UkrPTName) zno.UkrPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.UkrPTRegName = "Region"."RegName" AND zno.UkrPTAreaName = "Region"."AreaName" AND zno.UkrPTTerName = "Region"."TerName"
WHERE zno.UkrPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.UkrPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.histPTName) zno.histPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.histPTRegName = "Region"."RegName" AND zno.histPTAreaName = "Region"."AreaName" AND zno.histPTTerName = "Region"."TerName"
WHERE zno.histPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.histPTName IS NOT NULL;

INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.mathPTName) zno.mathPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.mathPTRegName = "Region"."RegName" AND zno.mathPTAreaName = "Region"."AreaName" AND zno.mathPTTerName = "Region"."TerName"
WHERE zno.mathPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.mathPTName IS NOT NULL;

INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.histPTName) zno.physPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.physPTRegName = "Region"."RegName" AND zno.physPTAreaName = "Region"."AreaName" AND zno.physPTTerName = "Region"."TerName"
WHERE zno.physPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.physPTName IS NOT NULL;

INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.chemPTName) zno.chemPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.chemPTRegName = "Region"."RegName" AND zno.chemPTAreaName = "Region"."AreaName" AND zno.chemPTTerName = "Region"."TerName"
WHERE zno.chemPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.chemPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.bioPTName) zno.bioPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.bioPTRegName = "Region"."RegName" AND zno.bioPTAreaName = "Region"."AreaName" AND zno.bioPTTerName = "Region"."TerName"
WHERE zno.bioPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.bioPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.geoPTName) zno.geoPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.geoPTRegName = "Region"."RegName" AND zno.geoPTAreaName = "Region"."AreaName" AND zno.geoPTTerName = "Region"."TerName"
WHERE zno.geoPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.geoPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.engPTName) zno.engPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.engPTRegName = "Region"."RegName" AND zno.engPTAreaName = "Region"."AreaName" AND zno.engPTTerName = "Region"."TerName"
WHERE zno.engPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.engPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.engPTName) zno.fraPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.fraPTRegName = "Region"."RegName" AND zno.fraPTAreaName = "Region"."AreaName" AND zno.fraPTTerName = "Region"."TerName"
WHERE zno.fraPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.fraPTName IS NOT NULL;

INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.deuPTName) zno.deuPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.deuPTRegName = "Region"."RegName" AND zno.deuPTAreaName = "Region"."AreaName" AND zno.deuPTTerName = "Region"."TerName"
WHERE zno.deuPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.deuPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.spaPTName) zno.spaPTName, "Region"."RegionID"
FROM zno
LEFT JOIN "Region"
ON zno.spaPTRegName = "Region"."RegName" AND zno.spaPTAreaName = "Region"."AreaName" AND zno.spaPTTerName = "Region"."TerName"
WHERE zno.spaPTName NOT IN (
SELECT "EOName"
FROM "EO"
) AND zno.spaPTName IS NOT NULL;




/* Person populate */

INSERT INTO "Person" ("PersonID", "Birth", "SexName", "RegionID", "RegTypeName", "ClassProfileName", "EOName")
SELECT zno.OUTID, zno.Birth, zno.SEXTYPENAME, "Region"."RegionID", zno.REGTYPENAME, zno.ClassProfileNAME, "EO"."EOName"
FROM zno
LEFT JOIN "Region"
ON zno.REGNAME = "Region"."RegName" AND zno.AREANAME = "Region"."AreaName" AND zno.TERNAME = "Region"."TerName"
LEFT JOIN "EO"
ON zno.EONAME = "EO"."EOName";



/* Test populate */

INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "AdaptScale", "PTEOName")
SELECT outID, UkrTest, zno_year, UkrTestStatus, UkrBall100, UkrBall12, UkrBall, UkrAdaptScale, UkrPTName
FROM zno
WHERE zno.UkrTest IS NOT NULL;



INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, histTest, zno_year, histTestStatus, histBall100, histBall12, histBall, histPTName, histLang
FROM zno
WHERE zno.histTest IS NOT NULL;



INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, mathTest, zno_year, mathTestStatus, mathBall100, mathBall12, mathBall, mathPTName, mathLang
FROM zno
WHERE zno.mathTest IS NOT NULL;


INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, physTest, zno_year, physTestStatus, physBall100, physBall12, physBall, physPTName, physLang
FROM zno
WHERE zno.physTest IS NOT NULL;


INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, chemTest, zno_year, chemTestStatus, chemBall100, chemBall12, chemBall, chemPTName, chemLang
FROM zno
WHERE zno.chemTest IS NOT NULL;



INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, bioTest, zno_year, bioTestStatus, bioBall100, bioBall12, bioBall, bioPTName, bioLang
FROM zno
WHERE zno.bioTest IS NOT NULL;



INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, geoTest, zno_year, geoTestStatus, geoBall100, geoBall12, geoBall, geoPTName, geoLang
FROM zno
WHERE zno.geoTest IS NOT NULL;


INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName")
SELECT outID, engTest, zno_year, engTestStatus, engBall100, engBall12, engBall, engPTName
FROM zno
WHERE zno.engTest IS NOT NULL;


INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName")
SELECT outID, fraTest, zno_year, fraTestStatus, fraBall100, fraBall12, fraBall, fraPTName
FROM zno
WHERE zno.fraTest IS NOT NULL;



INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName")
SELECT outID, deuTest, zno_year, deuTestStatus, deuBall100, deuBall12, deuBall, deuPTName
FROM zno
WHERE zno.deuTest IS NOT NULL;



INSERT INTO "Test" ("PersonID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName")
SELECT outID, spaTest, zno_year, spaTestStatus, spaBall100, spaBall12, spaBall, spaPTName
FROM zno
WHERE zno.spaTest IS NOT NULL;









