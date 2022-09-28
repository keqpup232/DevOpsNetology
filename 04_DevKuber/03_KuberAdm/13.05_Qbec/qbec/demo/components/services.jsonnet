local p = import '../params.libsonnet';
local params = p.components;

[
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: 'backend',
      labels: {
        app: 'backend',
      },
    },
    spec: {
      type: 'ClusterIP',
      ports: [
        {
          port: params.backend.port,
        },
      ],
      selector: {
        app: 'backend',
      },
    },
  },
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: 'frontend',
      labels: {
        app: 'frontend',
      },
    },
    spec: {
      type: 'ClusterIP',
      ports: [
        {
          port: params.frontend.port,
        },
      ],
      selector: {
        app: 'frontend',
      },
    },
  },
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: 'db',
      labels: {
        app: 'db',
      },
    },
    spec: {
      type: 'ClusterIP',
      ports: [
        {
          port: params.postgres.port,
        },
      ],
      selector: {
        app: 'db',
      },
    },
  },
]