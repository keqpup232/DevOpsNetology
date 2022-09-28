
// this file has the baseline default parameters
{
  components: {
    postgres: {
      image: 'postgres:13-alpine',
      replicas: 1,
      port: 5432,
      dbname: 'news',
      dbuser: 'postgres',
      dbpassword: 'postgres',
    },
    backend: {
      image: 'keqpup232/backend:1.1',
      replicas: 1,
      port: 9000,
    },
    frontend: {
      image: 'keqpup232/frontend:1.1',
      BASE_URL: 'http://localhost',
      replicas: 1,
      port: 8000,
    },
    volumeMounts: {
      mountPath: '/static',
    },
    pvc: {
      claimName: 'pvc',
      storage: '100Mi',
    },
    pvcDB: {
      claimName: 'pvc-db',
      storage: '1Gi',
    },
  },
}
