import { createClient } from './server'

export async function testConnection() {
  const supabase = await createClient()
  const { data, error } = await supabase.from('_test_').select('*').limit(1)
  return { error: error?.message ?? 'connected' }
}
