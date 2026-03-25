CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  nome TEXT NOT NULL,
  cognome TEXT NOT NULL,
  email TEXT,
  telefono TEXT,
  codice_fiscale TEXT,
  piva TEXT,
  indirizzo TEXT,
  note TEXT,
  whatsapp_consent BOOLEAN DEFAULT false,
  whatsapp_consent_at TIMESTAMPTZ,
  preferred_channel TEXT DEFAULT 'email' CHECK (preferred_channel IN ('email','sms','whatsapp')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
