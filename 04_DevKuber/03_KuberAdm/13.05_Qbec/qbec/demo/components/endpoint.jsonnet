[
  {
    kind: 'Endpoints',
    apiVersion: 'v1',
    metadata: {
      name: 'external-api',
    },
    subsets: [
      {
        addresses: [
          {
            ip: '138.197.231.124',
          },
        ],
        ports: [
          {
            port: 443,
          },
        ],
      },
    ],
  },
]