CREATE TABLE invoices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  client_id UUID NOT NULL REFERENCES clients(id),
  quote_id UUID REFERENCES quotes(id),
  numero TEXT,
  xml_fattura_pa TEXT,
  stato_sdi TEXT DEFAULT 'bozza',
  payment_link_url TEXT,
  stato_pagamento TEXT DEFAULT 'non_pagato' CHECK (stato_pagamento IN ('non_pagato','parziale','pagato')),
  totale NUMERIC(10,2),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE invoice_payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  invoice_id UUID NOT NULL REFERENCES invoices(id) ON DELETE CASCADE,
  metodo TEXT,
  data_pagamento DATE,
  importo NUMERIC(10,2),
  stripe_payment_intent_id TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
