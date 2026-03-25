CREATE TABLE maintenance_schedules (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  vehicle_id UUID NOT NULL REFERENCES vehicles(id) ON DELETE CASCADE,
  tipo TEXT NOT NULL,
  km_intervallo INTEGER,
  mesi_intervallo INTEGER,
  ultimo_eseguito DATE,
  prossima_data DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE maintenance_reminders (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  vehicle_id UUID NOT NULL REFERENCES vehicles(id) ON DELETE CASCADE,
  tipo TEXT NOT NULL,
  data_invio_prevista TIMESTAMPTZ,
  canale TEXT CHECK (canale IN ('email','sms','whatsapp')),
  stato TEXT DEFAULT 'pending' CHECK (stato IN ('pending','sent','failed')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
