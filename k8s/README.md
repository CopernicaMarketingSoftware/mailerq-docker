# Kubernetes

The yaml files in this folder are example Kubernetes stack deployments. 

### Secrets
- `mysql-pass`:`password`
- `rabbitmq-config`:`erlang-cookie`
- `mailerq-config`:`license`

The license secret can simply be generated using
```
kubectl create secret generic mailerq-config --from-file=license=/path/to/license
```
and the others can be created from literals as displayed below.

```
kubectl create secret generic <identifier>
--from-literal=key=value
```

## Startup order
First, RabbitMQ and MySQL should be started. Then, the MailerQ deployment can be started.