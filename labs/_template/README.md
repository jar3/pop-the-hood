# NN · Lab title · Título del laboratorio

- **Post:** link to the LinkedIn post · link al post de LinkedIn
- **Topic · Tema:** Kubernetes / SRE / observability · observabilidad / security · seguridad / architecture · arquitectura / AI · IA
- **Level · Nivel:** beginner / intermediate / advanced · inicial / intermedio / avanzado
- **Time · Tiempo:** ~15 min

## The analogy · La analogía

**EN** · One everyday situation that works like the concept.

**ES** · Una situación de la vida diaria que funciona igual que el concepto.

## What you'll learn · Qué vas a aprender

- EN · ...
- ES · ...

## Steps · Pasos

1. Create the cluster · Crear el cluster:

   ```sh
   kind create cluster --name pop-the-hood
   ```

2. Apply the manifests · Aplicar los manifiestos:

   ```sh
   kubectl apply -f manifests/
   ```

3. ...

## Break it on purpose · Rompelo a propósito

**EN** · Change one thing, predict what will happen, then check it.

**ES** · Cambiá una cosa, adiviná qué va a pasar y comprobalo.

## Clean up · Limpiar

```sh
kind delete cluster --name pop-the-hood
```

## What you learned · Qué aprendiste

- EN · ...
- ES · ...

## Test · Prueba

`test.sh` checks that the lab works as described here; `scripts/test-labs.sh` and GitHub Actions run it. `test.sh` comprueba que el laboratorio funciona como se describe acá; lo corren `scripts/test-labs.sh` y GitHub Actions.
