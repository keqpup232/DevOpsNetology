local p = import '../params.libsonnet';
local params = p.components;

[
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      labels: {
        app: 'backend',
      },
      name: 'backend',
    },
    spec: {
      replicas: params.backend.replicas,
      selector: {
        matchLabels: {
          app: 'backend',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'backend',
          },
        },
        spec: {
          containers: [
            {
              image: params.backend.image,
              name: 'backend',
              ports: [
                {
                  containerPort: params.backend.port,
                },
              ],
              env: [
                {
                  name: 'DATABASE_URL',
                  value: 'postgres://'+params.postgres.dbuser+':'+params.postgres.dbpassword+'@db:'+params.postgres.port+'/'+params.postgres.dbname,
                },
              ],
              volumeMounts: [
                {
                  mountPath: params.volumeMounts.mountPath,
                  name: 'my-volume',
                },
              ],
            },
          ],
          volumes: [
            {
              name: 'my-volume',
              persistentVolumeClaim: {
                claimName: params.pvc.claimName,
              },
            },
          ],
          restartPolicy: 'Always',
        },
      },
    },
  },
]