-- Run this in your Supabase SQL Editor (once)

CREATE TABLE IF NOT EXISTS cards (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT DEFAULT '',
  column_id TEXT NOT NULL,
  position INTEGER DEFAULT 0,
  deadline DATE DEFAULT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- If the table already exists, run this to add the deadline column:
-- ALTER TABLE cards ADD COLUMN IF NOT EXISTS deadline DATE DEFAULT NULL;

CREATE TABLE IF NOT EXISTS checklist_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  card_id UUID NOT NULL REFERENCES cards(id) ON DELETE CASCADE,
  text TEXT NOT NULL,
  checked BOOLEAN DEFAULT FALSE,
  position INTEGER DEFAULT 0
);

ALTER TABLE cards REPLICA IDENTITY FULL;
ALTER TABLE checklist_items REPLICA IDENTITY FULL;

ALTER TABLE cards DISABLE ROW LEVEL SECURITY;
ALTER TABLE checklist_items DISABLE ROW LEVEL SECURITY;

ALTER PUBLICATION supabase_realtime ADD TABLE cards;
ALTER PUBLICATION supabase_realtime ADD TABLE checklist_items;
