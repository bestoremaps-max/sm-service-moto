CREATE OR REPLACE FUNCTION search_parts(query TEXT, p_tenant_id UUID)
RETURNS TABLE(part_code TEXT, description TEXT, price NUMERIC, source TEXT) AS $$
BEGIN
  RETURN QUERY
  SELECT pp.part_code, pp.description, pp.price, 'piaggio'::TEXT
  FROM piaggio_parts pp
  WHERE to_tsvector('italian', pp.description) @@ plainto_tsquery('italian', query)
  LIMIT 20;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION generate_portal_token(p_client_id UUID, p_tenant_id UUID)
RETURNS UUID AS $$
DECLARE
  v_token UUID;
BEGIN
  INSERT INTO client_portal_sessions (client_id, tenant_id, expires_at)
  VALUES (p_client_id, p_tenant_id, NOW() + INTERVAL '7 days')
  RETURNING token INTO v_token;
  RETURN v_token;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
