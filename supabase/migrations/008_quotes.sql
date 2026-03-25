CREATE TABLE quotes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  client_id UUID NOT NULL REFERENCES clients(id),
  vehicle_id UUID REFERENCES vehicles(id),
  work_order_id UUID REFERENCES work_orders(id),
  numero TEXT,
  stato TEXT DEFAULT 'bozza' CHECK (stato IN ('bozza','inviato','accettato','rifiutato','scaduto')),
  totale NUMERIC(10,2),
  note TEXT,
  firma_url TEXT,
  scadenza DATE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE quote_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  quote_id UUID NOT NULL REFERENCES quotes(id) ON DELETE CASCADE,
  part_code TEXT,
  description TEXT NOT NULL,
  qty NUMERIC(10,2) NOT NULL DEFAULT 1,
  unit_price NUMERIC(10,2) NOT NULL,
  purchase_price NUMERIC(10,2),
  source TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
