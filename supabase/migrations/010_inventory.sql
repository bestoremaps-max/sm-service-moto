CREATE TABLE inventory (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  codice TEXT NOT NULL,
  descrizione TEXT,
  giacenza NUMERIC(10,2) DEFAULT 0,
  giacenza_minima NUMERIC(10,2) DEFAULT 0,
  prezzo_acquisto NUMERIC(10,2),
  prezzo_vendita NUMERIC(10,2),
  fornitore TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(tenant_id, codice)
);
CREATE TABLE inventory_movements (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  inventory_id UUID NOT NULL REFERENCES inventory(id),
  work_order_id UUID REFERENCES work_orders(id),
  tipo TEXT CHECK (tipo IN ('carico','scarico')),
  quantita NUMERIC(10,2) NOT NULL,
  note TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
