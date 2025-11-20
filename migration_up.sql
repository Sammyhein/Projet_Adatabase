-- serial permet à ce que l'ID ne soit jamais à l'inverse de INTEGER
-- REAL prend plus de nombre après la virgule
-- FLOAT sera peu de nombre après la virgule
-- Pour FOREIGN KEY on peut faire différement, on peut fait [nom de la colonne] INTEGER REFERENCES [nom de l'autre tableau]([nom de la colonne de l'autre tableau])
-- Aussi pour le foreign key, au lieu de INTEGER on met TEXT si la référence est un text

-- Themes 

CREATE TABLE themes (
    id serial PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updates_at TIMESTAMPTZ DEFAULT NOW()
);


-- Skills
CREATE TABLE skills (
    id INTEGER PRIMARY KEY,
    name TEXT
);

-- TYPE resouce_type
CREATE TYPE resource_type as ENUM (
    'guide',
    'video',
    'exercise',
    'projet'
);

-- Resources
CREATE TABLE resources (
    id serial PRIMARY KEY,
    type resource_type,
    title TEXT,
    description TEXT,
    url TEXT,
    is_ada BOOLEAN,
    theme_id INTEGER REFERENCES themes(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);


-- Resources skills
CREATE TABLE resources_skills (
    resource_id INTEGER REFERENCES resources(id),
    skill_id INTEGER REFERENCES skills(id)
);



