CREATE TABLE ai_diagnostic_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  work_order_id UUID REFERENCES work_orders(id),
  sintomo TEXT,
  suggerimenti TEXT,
  ricambi_proposti JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
