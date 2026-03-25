export type UserRole = 'admin' | 'meccanico' | 'receptionist' | 'viewer'

export const PERMISSIONS = {
  clients:    { view: ['admin','meccanico','receptionist','viewer'], edit: ['admin','receptionist'], delete: ['admin'] },
  vehicles:   { view: ['admin','meccanico','receptionist','viewer'], edit: ['admin','receptionist'], delete: ['admin'] },
  work_orders:{ view: ['admin','meccanico','receptionist','viewer'], edit: ['admin','meccanico'],    delete: ['admin'] },
  quotes:     { view: ['admin','meccanico','receptionist','viewer'], edit: ['admin','receptionist'], delete: ['admin'] },
  invoices:   { view: ['admin','receptionist'],                      edit: ['admin'],                delete: ['admin'] },
  inventory:  { view: ['admin','meccanico','receptionist','viewer'], edit: ['admin'],                delete: ['admin'] },
  settings:   { view: ['admin'],                                     edit: ['admin'],                delete: ['admin'] },
} as const

export function hasPermission(
  role: UserRole,
  resource: keyof typeof PERMISSIONS,
  action: 'view' | 'edit' | 'delete'
): boolean {
  return (PERMISSIONS[resource][action] as readonly string[]).includes(role)
}
