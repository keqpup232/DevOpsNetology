local p = import '../params.libsonnet';
local params = p.components;

[
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      labels: {
        app: 'frontend',
      },
      name: 'frontend',
    },
    spec: {
      replicas: params.frontend.replicas,
      selector: {
        matchLabels: {
          app: 'frontend',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'frontend',
          },
        },
        spec: {
          containers: [
            {
              image: params.frontend.image,
              name: 'frontend',
              ports: [
                {
                  containerPort: params.frontend.port,
                },
              ],
              env: [
                {
                  name: 'BASE_URL',
                  value: params.frontend.BASE_URL+':'+params.backend.port,
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