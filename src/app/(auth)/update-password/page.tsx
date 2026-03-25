'use client'
import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'

const schema = z.object({ password: z.string().min(8) })
type FormData = z.infer<typeof schema>

export default function UpdatePasswordPage() {
  const router = useRouter()
  const supabase = createClient()
  const [error, setError] = useState<string | null>(null)
  const { register, handleSubmit } = useForm<FormData>({ resolver: zodResolver(schema) })

  const onSubmit = async (data: FormData) => {
    const { error } = await supabase.auth.updateUser({ password: data.password })
    if (error) { setError(error.message); return }
    router.push('/login')
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50">
      <div className="w-full max-w-md p-8 bg-white rounded-xl shadow-sm">
        <h1 className="text-2xl font-bold text-gray-900 mb-4">Nuova password</h1>
        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <input {...register('password')} type="password" placeholder="Nuova password (min 8 caratteri)"
            className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
          {error && <p className="text-red-500 text-sm">{error}</p>}
          <button type="submit"
            className="w-full py-2 bg-brand text-white rounded-lg font-medium hover:bg-brand-dark">
            Aggiorna password
          </button>
        </form>
      </div>
    </div>
  )
}
