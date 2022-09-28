
// this file has the param overrides for the default environment
local base = import './base.libsonnet';

base {
  components +: {
    postgres +: {
      replicas: 1,
    },
    backend +: {
      replicas: 1,
    },
    frontend +: {
      replicas: 1,
    },
  },
}