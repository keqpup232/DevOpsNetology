local p = import '../params.libsonnet';
local params = p.components;

[
  {
    kind: 'PersistentVolumeClaim',
    apiVersion: 'v1',
    metadata: {
      name: params.pvc.claimName,
    },
    spec: {
      storageClassName: 'nfs',
      accessModes: [
        'ReadWriteMany',
      ],
      resources: {
        requests: {
          storage: params.pvc.storage,
        },
      },
    },
  },
  {
    kind: 'PersistentVolumeClaim',
    apiVersion: 'v1',
    metadata: {
      name: params.pvcDB.claimName,
    },
    spec: {
      storageClassName: 'nfs',
      accessModes: [
        'ReadWriteMany',
      ],
      resources: {
        requests: {
          storage: params.pvcDB.storage,
        },
      },
    },
  },
]