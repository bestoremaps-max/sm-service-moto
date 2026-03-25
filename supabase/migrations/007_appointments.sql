CREATE TABLE appointments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  client_id UUID REFERENCES clients(id),
  vehicle_id UUID REFERENCES vehicles(id),
  meccanico_id UUID REFERENCES auth.users(id),
  titolo TEXT NOT NULL,
  descrizione TEXT,
  inizio TIMESTAMPTZ NOT NULL,
  fine TIMESTAMPTZ NOT NULL,
  stato TEXT DEFAULT 'confermato' CHECK (stato IN ('confermato','annullato','completato')),
  reminder_sent BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
