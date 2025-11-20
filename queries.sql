--  Récupérer la liste des thèmes
SELECT name, description FROM themes;

--  Récupérer la liste des skills
SELECT * FROM skills;

--  Récupérer toutes les ressources triées par date de mise à jour
SELECT * 
FROM resources
ORDER BY updated_at ASC;

-- Récupérer uniquement le nom et l'url des ressources de type exercice
SELECT title, url 
FROM resources
WHERE type = 'exercise';


-- Récupérer le titre et la description des ressources d'Ada uniquement
-- SELECT *
-- FROM resources;

SELECT title, description
FROM resources
WHERE is_ada = TRUE;


-- Récupérer les ressources qui ont la compétence JavaScript associée
-- SELECT * FROM resources_skills;

SELECT * 
FROM resources
JOIN resources_skills ON resources.id = resources_skills.resource_id
JOIN skills ON skills.id = resources_skills.skill_id
WHERE name = 'JavaScript';


--Récupérer les ressources dont le titre contient le mot "react" (avec ou sans majuscules)
-- ILIKE prend en compte les majuscules si il y en a
SELECT *
FROM resources
WHERE title ILIKE '%react%';


--BONUS 
---- D'AILLEURS ! POUR LE JOIN ! Comment comprendre la différenece entre LEFT JOIN et RIGHT JOIN 
---- L'ordre se défini par rapport à l'ordre de manipulation dans ton querie 
---- Un moyen de bien se rapport , 
---- après notre select, on met un FROM , eh bien ce tableau qu'on va mettre c'est notre première manipulation
---- donc il se met tout à gauche (en premier quoi)
---- Ensuite le tableau qui est dans le JOIN est la deuxième manipulation donc il se met à la droite de mon premier tableau


-- Récupérer la liste des thèmes avec le nombre de ressources par thème
-- SELECT *
-- FROM themes;

-- Au lieu LEFT JOIN, je pourrais mettre INNER JOIN pour éviter d'afficher tous les éléments qui ont "NULL"

SELECT theme_id, name, themes.description, resources.title, resources.description
FROM themes
LEFT JOIN resources ON themes.id = resources.theme_id;

----OU

SELECT themes.name, COUNT(resources.id) AS nb_ressources
FROM themes
LEFT JOIN resources ON themes.id = resources.theme_id
GROUP BY themes.name
ORDER BY nb_ressources;

-- Récupérer le nom et l'url de toutes les ressources avec un tableau/liste contenant l'ensemble de leurs skills associés

---- ARRAY_AGG permet de créé un ARRAY_AGG par rapport à la colonne demandé
---- Le AGG est ce qui permet d'agrementer automatiquement (faire la liste quoi)
---- on aurait également pu faire STRING_AGG([nom colonne], ', ') qui le met sous format de texte normal
---- OU faire JSON_AGG([nom de colonne]) qui le met sous forme de tableau à crochet []

---- le AS permet de redonner un nom à la colonne. Ici au lieu que ça soit "skills.name", ça devient juste "skill"

---- Ajouter GROUP BY permet de mettre en route la fonction ARRAY_AGG
---- Sans le GROUP BY , ARRAYS_AGG ne marche pas 
---- À la suite de GROUP BY, je remet les colonne que je veux afficher mais en précisant dans quelle table ils se retrouvent

SELECT title, url, ARRAY_AGG(skills.name) AS skill
FROM resources
JOIN resources_skills ON resources.id = resources_skills.resource_id
JOIN skills ON resources_skills.skill_id = skills.id
GROUP BY resources.title, resources.url;

--  Récupérer les 5 ressources les plus récentes avec leur thème

SELECT title, resources.description, updated_at, themes.name, themes.description
FROM resources
JOIN themes ON resources.theme_id = themes.id
ORDER BY updated_at DESC
LIMIT 5;

-- Récupérer toutes les compétences qui ne sont associées à aucune ressource
-- SELECT *
-- FROM skills
-- WHERE skills.id = 6;

-- SELECT skill_id
-- FROM resources_skills;

---- LE LEFT JOIN EST IMPORTANT POUR AFFICHER LE NOM DANS CET EXEMPLE
---- IS NULL a marchait mais le = NULL n'a pas marché

SELECT name AS Skill_Null
FROM skills
LEFT JOIN resources_skills ON skills.id = resources_skills.skill_id
WHERE resources_skills.skill_id IS NULL;