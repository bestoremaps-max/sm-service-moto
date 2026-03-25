CREATE TABLE tenants (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  vat_number TEXT,
  address TEXT,
  city TEXT,
  phone TEXT,
  logo_url TEXT,
  hourly_rate NUMERIC(10,2) DEFAULT 65.00,
  plan TEXT NOT NULL DEFAULT 'free',
  stripe_customer_id TEXT,
  whatsapp_number TEXT,
  whatsapp_enabled BOOLEAN DEFAULT false,
  onboarding_completed BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
