'use client'
import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'

const schema = z.object({
  nome_officina: z.string().min(2, 'Nome obbligatorio'),
  email: z.string().email('Email non valida'),
  password: z.string().min(8, 'Minimo 8 caratteri'),
  telefono: z.string().min(6, 'Telefono obbligatorio'),
  vat_number: z.string().min(11, 'P.IVA non valida').max(11),
  privacy: z.boolean().refine(v => v === true, 'Devi accettare la Privacy Policy'),
})
type FormData = z.infer<typeof schema>

export default function RegisterPage() {
  const router = useRouter()
  const supabase = createClient()
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)

  const { register, handleSubmit, formState: { errors } } = useForm<FormData>({
    resolver: zodResolver(schema),
  })

  const onSubmit = async (data: FormData) => {
    setLoading(true)
    setError(null)
    const { data: authData, error: authError } = await supabase.auth.signUp({
      email: data.email,
      password: data.password,
    })
    if (authError || !authData.user) {
      setError(authError?.message ?? 'Errore registrazione')
      setLoading(false)
      return
    }
    const { data: tenant, error: tenantError } = await supabase
      .from('tenants')
      .insert({
        name: data.nome_officina,
        vat_number: data.vat_number,
        phone: data.telefono,
        plan: 'free',
      })
      .select()
      .single()
    if (tenantError || !tenant) {
      setError('Errore creazione officina')
      setLoading(false)
      return
    }
    await supabase.from('user_roles').insert({
      user_id: authData.user.id,
      tenant_id: tenant.id,
      role: 'admin',
    })
    router.push('/dashboard')
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50">
      <div className="w-full max-w-md p-8 bg-white rounded-xl shadow-sm">
        <div className="mb-6 text-center">
          <h1 className="text-2xl font-bold text-gray-900">Registra la tua officina</h1>
          <p className="text-gray-500 mt-1">Piano Free — nessuna carta richiesta</p>
        </div>
        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Nome officina</label>
            <input {...register('nome_officina')} className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand" />
            {errors.nome_officina && <p className="text-red-500 text-xs mt-1">{errors.nome_officina.message}</p>}
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">P.IVA (11 cifre)</label>
            <input {...register('vat_number')} className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand" />
            {errors.vat_number && <p className="text-red-500 text-xs mt-1">{errors.vat_number.message}</p>}
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <input {...register('email')} type="email" className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand" />
            {errors.email && <p className="text-red-500 text-xs mt-1">{errors.email.message}</p>}
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Telefono</label>
            <input {...register('telefono')} className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand" />
            {errors.telefono && <p className="text-red-500 text-xs mt-1">{errors.telefono.message}</p>}
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Password</label>
            <input {...register('password')} type="password" className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand" />
            {errors.password && <p className="text-red-500 text-xs mt-1">{errors.password.message}</p>}
          </div>
          <div className="flex items-start gap-2">
            <input {...register('privacy')} type="checkbox" id="privacy" className="mt-1" />
            <label htmlFor="privacy" className="text-sm text-gray-600">
              Accetto la <a href="/privacy" className="text-brand underline">Privacy Policy</a>
            </label>
          </div>
          {errors.privacy && <p className="text-red-500 text-xs">{errors.privacy.message}</p>}
          {error && <p className="text-red-500 text-sm">{error}</p>}
          <button type="submit" disabled={loading}
            className="w-full py-2 px-4 bg-brand text-white rounded-lg font-medium hover:bg-brand-dark disabled:opacity-50">
            {loading ? 'Registrazione...' : 'Crea account'}
          </button>
          <a href="/login" className="block text-center text-sm text-gray-500 hover:underline">
            Hai già un account? Accedi
          </a>
        </form>
      </div>
    </div>
  )
}
