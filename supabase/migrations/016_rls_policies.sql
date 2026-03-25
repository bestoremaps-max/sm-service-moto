ALTER TABLE tenants ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE clients ENABLE ROW LEVEL SECURITY;
ALTER TABLE vehicles ENABLE ROW LEVEL SECURITY;
ALTER TABLE maintenance_schedules ENABLE ROW LEVEL SECURITY;
ALTER TABLE maintenance_reminders ENABLE ROW LEVEL SECURITY;
ALTER TABLE work_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE work_time_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE quotes ENABLE ROW LEVEL SECURITY;
ALTER TABLE quote_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoice_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_movements ENABLE ROW LEVEL SECURITY;
ALTER TABLE client_portal_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE whatsapp_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE whatsapp_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_diagnostic_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE sync_credentials ENABLE ROW LEVEL SECURITY;
ALTER TABLE sync_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE catalog_notifications ENABLE ROW LEVEL SECURITY;

CREATE POLICY tenant_isolation ON clients
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON vehicles
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON work_orders
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON quotes
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON invoices
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON inventory
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON appointments
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON whatsapp_messages
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON maintenance_schedules
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON maintenance_reminders
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON ai_diagnostic_logs
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON sync_credentials
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON sync_log
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON catalog_notifications
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
CREATE POLICY tenant_isolation ON client_portal_sessions
  USING (tenant_id = (auth.jwt() ->> 'tenant_id')::UUID);
