INSERT INTO themes (id, name, description) 
SELECT 1, 'Frontend', 'interface utilisateur'
UNION SELECT 2, 'Backend', 'couche logicielle accédant à des données'
UNION SELECT 3, 'Base de données', 'ensemble d''informations'
UNION SELECT 4, 'DevOps', 'développement et opérations';

INSERT INTO resources (id, title, url, description, type, is_ada, theme_id)
SELECT 1, 'Introduction à React', 'https://react.dev', 'Guide officiel React', 'guide'::resource_type, true, 1
UNION SELECT 2, 'SQL pour débutants', 'https://example.com/sql', 'Cours SQL complet', 'video'::resource_type, false, 3
UNION SELECT 3, 'Exercices JavaScript', 'https://example.com/js', 'Pratique JS', 'exercise'::resource_type, false, 1
UNION SELECT 4, 'Créer une API en node', 'https://example.com/node', 'Projet node', 'projet'::resource_type, false, 2;

INSERT INTO skills (id, name)
SELECT 1, 'JavaScript'
UNION SELECT 2, 'React'
UNION SELECT 3, 'SQL'
UNION SELECT 4, 'PostgreSQL'
UNION SELECT 5, 'Node.js'
UNION SELECT 6, 'HTML';

INSERT INTO resources_skills(resource_id, skill_id)
SELECT 1, 1
UNION SELECT 1, 2
UNION SELECT 2, 3
UNION SELECT 2, 4
UNION SELECT 3, 1
UNION SELECT 4, 1
UNION SELECT 4, 5
