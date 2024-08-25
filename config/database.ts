import env from '#start/env'
import { defineConfig } from '@adonisjs/lucid'

const POSTGRESConfig = defineConfig({
  connection: 'postgres',
  connections: {
    postgres: {
      client: 'pg',
      connection: {
        host: env.get('POSTGRES_HOST'),
        port: env.get('POSTGRES_PORT'),
        user: env.get('POSTGRES_USER'),
        password: env.get('POSTGRES_PASSWORD'),
        database: env.get('POSTGRES_DATABASE'),
      },
      migrations: {
        naturalSort: true,
        paths: ['database/migrations'],
      },
    },
  },
})

export default POSTGRESConfig
