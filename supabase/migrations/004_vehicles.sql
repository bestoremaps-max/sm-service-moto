CREATE TABLE vehicles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  targa TEXT,
  vin TEXT,
  marca TEXT,
  modello TEXT,
  anno INTEGER,
  cilindrata INTEGER,
  colore TEXT,
  km INTEGER DEFAULT 0,
  data_revisione DATE,
  data_assicurazione DATE,
  data_prossimo_tagliando DATE,
  vin_decoded_data JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
