CREATE TABLE whatsapp_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  client_id UUID REFERENCES clients(id),
  direction TEXT CHECK (direction IN ('inbound','outbound')),
  wa_message_id TEXT,
  content TEXT,
  stato TEXT DEFAULT 'sent',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE whatsapp_templates (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  nome TEXT NOT NULL,
  template_id TEXT,
  contenuto TEXT,
  approvato BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
