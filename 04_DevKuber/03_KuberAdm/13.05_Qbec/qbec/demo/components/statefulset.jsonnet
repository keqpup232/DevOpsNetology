local p = import '../params.libsonnet';
local params = p.components;

[
  {
    apiVersion: 'apps/v1',
    kind: 'StatefulSet',
    metadata: {
      name: 'db',
    },
    spec: {
      selector: {
        matchLabels: {
          app: 'db',
        },
      },
      serviceName: 'db',
      replicas: params.postgres.replicas,
      template: {
        metadata: {
          labels: {
            app: 'db',
          },
        },
        spec: {
          volumes: [
            {
              name: 'data',
              persistentVolumeClaim: {
                claimName: params.pvcDB.claimName,
              },
            },
          ],
          containers: [
            {
              name: 'postgres',
              image: params.postgres.image,
              volumeMounts: [
                {
                  name: 'data',
                  mountPath: '/mnt',
                },
              ],
              env: [
                {
                  name: 'POSTGRES_PASSWORD',
                  value: params.postgres.dbpassword,
                },
                {
                  name: 'POSTGRES_USER',
                  value: params.postgres.dbuser,
                },
                {
                  name: 'POSTGRES_DB',
                  value: params.postgres.dbname,
                },
              ],
            },
          ],
        },
      },
    },
  },
]