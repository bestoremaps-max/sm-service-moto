CREATE TABLE tecdoc_vehicles_cache (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vin TEXT,
  targa TEXT,
  decoded_data JSONB,
  expires_at TIMESTAMPTZ DEFAULT NOW() + INTERVAL '90 days',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE tecdoc_parts_cache (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vehicle_id_tecdoc TEXT,
  part_code TEXT,
  data JSONB,
  expires_at TIMESTAMPTZ DEFAULT NOW() + INTERVAL '7 days',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
