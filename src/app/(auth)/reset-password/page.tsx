'use client'
import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'

const schema = z.object({ email: z.string().email() })
type FormData = z.infer<typeof schema>

export default function ResetPasswordPage() {
  const supabase = createClient()
  const [sent, setSent] = useState(false)
  const { register, handleSubmit, formState: { errors } } = useForm<FormData>({
    resolver: zodResolver(schema),
  })

  const onSubmit = async (data: FormData) => {
    await supabase.auth.resetPasswordForEmail(data.email, {
      redirectTo: `${window.location.origin}/update-password`,
    })
    setSent(true)
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50">
      <div className="w-full max-w-md p-8 bg-white rounded-xl shadow-sm">
        <h1 className="text-2xl font-bold text-gray-900 mb-2">Recupera password</h1>
        {sent ? (
          <p className="text-green-600">Email inviata! Controlla la tua casella.</p>
        ) : (
          <form onSubmit={handleSubmit(onSubmit)} className="space-y-4 mt-4">
            <input {...register('email')} type="email" placeholder="La tua email"
              className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
            {errors.email && <p className="text-red-500 text-xs">{errors.email.message}</p>}
            <button type="submit"
              className="w-full py-2 bg-brand text-white rounded-lg font-medium hover:bg-brand-dark">
              Invia link di recupero
            </button>
          </form>
        )}
        <a href="/login" className="block text-center text-sm text-gray-500 mt-4 hover:underline">
          Torna al login
        </a>
      </div>
    </div>
  )
}
