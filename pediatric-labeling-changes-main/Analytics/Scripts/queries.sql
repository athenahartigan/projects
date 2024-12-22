-- -- Athena Hartigan
-- -- Due Date: 11/9/2024
-- -- This code analyzes which drugs are safe/effective for pediatric use and relationships between the trade name and generic name and dose form and route of administration
-- -- Co-Author: Bard

-- -- queries for excellent performance

SELECT DISTINCT "TradeName"."TradeName" AS "Safe Drugs"
FROM "TradeName"
WHERE "TradeNameId" IN (
    SELECT "TradeNameId"
    FROM SafeDrugs
);

SELECT DISTINCT "TradeName"."TradeName" AS "Effective Drugs"
FROM "TradeName"
WHERE "TradeNameId" IN (
    SELECT "TradeNameId"
    FROM EffectiveDrugs
);

SELECT DISTINCT "TradeName"."TradeName" AS "Safe and Effective Drugs"
FROM "TradeName"
WHERE "TradeNameId" IN (
    SELECT "TradeNameId"
    FROM EffectiveDrugs
)
AND "TradeNameId" IN (
    SELECT "TradeNameId"
    FROM SafeDrugs
);


-- queries for my curiosity

SELECT DISTINCT "TradeName"."TradeName", "GenericName"."GenericName"
FROM "TradeName"
JOIN "Generic_Trade" ON "TradeName"."TradeNameId" = "Generic_Trade"."TradeNameId"
JOIN "GenericName" ON "Generic_Trade"."GenericNameId" = "GenericName"."GenericNameId"
ORDER BY "TradeName"."TradeName" ASC;

SELECT DISTINCT "GenericName"."GenericName", "TradeName"."TradeName"
FROM "GenericName"
JOIN "Generic_Trade" ON "GenericName"."GenericNameId" = "Generic_Trade"."GenericNameId"
JOIN "TradeName" ON "Generic_Trade"."TradeNameId" = "TradeName"."TradeNameId"
ORDER BY "GenericName"."GenericName" ASC;

SELECT DISTINCT "Route"."RouteAdmin", "Dose"."DoseForm"
FROM "Route"
JOIN "Route_App" ON "Route"."RouteId" = "Route_App"."RouteId"
JOIN "Dose_App" ON "Route_App"."FDAAppId" = "Dose_App"."FDAAppId"
JOIN "Dose" ON "Dose_App"."DoseId" = "Dose"."DoseId"
ORDER BY "Route"."RouteAdmin" ASC;

SELECT DISTINCT "Dose"."DoseForm", "Route"."RouteAdmin"
FROM "Dose"
JOIN "Dose_App" ON "Dose"."DoseId" = "Dose_App"."DoseId"
JOIN "Route_App" ON "Dose_App"."FDAAppId" = "Route_App"."FDAAppId"
JOIN "Route" ON "Route_App"."RouteId" = "Route"."RouteId"
ORDER BY "Dose"."DoseForm" ASC;




