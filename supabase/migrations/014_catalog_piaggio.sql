CREATE TABLE piaggio_parts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  part_code TEXT NOT NULL UNIQUE,
  description TEXT,
  family TEXT,
  model TEXT,
  group_name TEXT,
  price NUMERIC(10,2),
  image_url TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE piaggio_parts_history (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  part_code TEXT NOT NULL,
  field_changed TEXT,
  old_value TEXT,
  new_value TEXT,
  changed_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE sync_credentials (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE UNIQUE,
  encrypted_cookie TEXT,
  last_verified TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE sync_log (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  tipo TEXT,
  stato TEXT,
  parts_synced INTEGER DEFAULT 0,
  error_message TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE catalog_notifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  part_code TEXT,
  messaggio TEXT,
  letta BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
