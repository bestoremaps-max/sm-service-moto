'use client'
import { useEffect, useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { hasPermission, type UserRole } from '@/lib/auth/roles'

interface Props {
  role: UserRole
  children: React.ReactNode
  fallback?: React.ReactNode
}

export function RequireRole({ role, children, fallback = null }: Props) {
  const [userRole, setUserRole] = useState<UserRole | null>(null)
  const [loading, setLoading] = useState(true)
  const supabase = createClient()

  useEffect(() => {
    async function getRole() {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) { setLoading(false); return }
      const { data } = await supabase
        .from('user_roles')
        .select('role')
        .eq('user_id', user.id)
        .single()
      setUserRole(data?.role as UserRole ?? null)
      setLoading(false)
    }
    getRole()
  }, [])

  if (loading) return null
  if (!userRole) return <>{fallback}</>

  const roleOrder: UserRole[] = ['viewer', 'receptionist', 'meccanico', 'admin']
  const userLevel = roleOrder.indexOf(userRole)
  const requiredLevel = roleOrder.indexOf(role)

  if (userLevel < requiredLevel) return <>{fallback}</>
  return <>{children}</>
}
