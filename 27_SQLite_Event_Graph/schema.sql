-- Purushartha OS SQLite Event Graph Schema

CREATE TABLE IF NOT EXISTS person (
    person_id TEXT PRIMARY KEY,
    display_name TEXT,
    role_type TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS relationship_event (
    event_id TEXT PRIMARY KEY,
    timestamp TEXT NOT NULL,
    stage TEXT,
    domain TEXT,
    harm_level INTEGER,
    impact_score REAL,
    repair_score REAL,
    learning_score REAL,
    summary TEXT,
    confidence TEXT,
    consent_class TEXT
);

CREATE TABLE IF NOT EXISTS event_participant (
    event_id TEXT,
    person_id TEXT,
    participant_role TEXT,
    PRIMARY KEY (event_id, person_id),
    FOREIGN KEY (event_id) REFERENCES relationship_event(event_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE IF NOT EXISTS graph_edge (
    edge_id TEXT PRIMARY KEY,
    from_node TEXT,
    to_node TEXT,
    edge_type TEXT,
    source_event_id TEXT,
    confidence TEXT
);

CREATE TABLE IF NOT EXISTS scd2_relationship_state (
    state_id TEXT PRIMARY KEY,
    relationship_id TEXT,
    valid_from TEXT,
    valid_to TEXT,
    is_current INTEGER,
    relationship_health_score REAL,
    burden_skew_score REAL,
    karma_bond_score REAL,
    purushartha_balance_score REAL,
    source_event_ids TEXT,
    confidence TEXT
);
