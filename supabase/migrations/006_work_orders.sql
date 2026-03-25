CREATE TABLE work_orders (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  client_id UUID NOT NULL REFERENCES clients(id),
  vehicle_id UUID NOT NULL REFERENCES vehicles(id),
  stato TEXT DEFAULT 'accettato' CHECK (stato IN ('accettato','in_lavorazione','in_attesa_ricambi','completato','consegnato')),
  meccanico_id UUID REFERENCES auth.users(id),
  km_ingresso INTEGER,
  diagnosi TEXT,
  note_interne TEXT,
  foto_urls TEXT[],
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE work_time_entries (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  work_order_id UUID NOT NULL REFERENCES work_orders(id) ON DELETE CASCADE,
  meccanico_id UUID NOT NULL REFERENCES auth.users(id),
  operazione TEXT,
  minuti INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
