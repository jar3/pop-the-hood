# 01 · Probes: liveness, readiness and startup · Probes: liveness, readiness y startup

- **Post:** —
- **Topic · Tema:** Kubernetes
- **Level · Nivel:** beginner · inicial
- **Time · Tiempo:** ~15 min

## The analogy · La analogía

**EN** · A restaurant manager checks on each waiter with three questions. *Startup:* "did you finish changing into your uniform?" (don't bother them until they do). *Readiness:* "can you take tables now?" (if not, no new customers are sent their way, but nobody fires them). *Liveness:* "are you OK?" (if they don't answer, they're sent home and someone else takes the shift).

**ES** · El encargado de un restaurante le hace tres preguntas a cada mozo. *Startup:* "¿terminaste de cambiarte?" (no lo molesta hasta que termine). *Readiness:* "¿estás para atender?" (si no, no le manda mesas nuevas, pero nadie lo echa). *Liveness:* "¿estás bien?" (si no contesta, lo mandan a la casa y entra otro en su turno).

## What you'll learn · Qué vas a aprender

- EN · What each probe does and what Kubernetes does when it fails.
- EN · Why a readiness failure takes the pod out of the Service without restarting it.
- EN · Why a startup probe protects slow apps from being killed by the liveness probe.
- ES · Qué hace cada probe y qué hace Kubernetes cuando falla.
- ES · Por qué una readiness que falla saca al pod del Service sin reiniciarlo.
- ES · Por qué la startup probe protege a las apps lentas de que la liveness las mate.

## Steps · Pasos

1. Create the cluster · Crear el cluster:

   ```sh
   kind create cluster --name pop-the-hood
   ```

2. Apply the manifests and watch the pod for the first 15 seconds · Aplicar los manifiestos y mirar el pod los primeros 15 segundos:

   ```sh
   kubectl apply -f manifests/
   kubectl get pods -l app=web -w
   ```

   **EN** · The app takes 10 seconds to start, so `READY` shows `0/1` first. The startup probe waits for it; the liveness probe doesn't kick in yet.
   **ES** · La app tarda 10 segundos en arrancar, así que `READY` muestra `0/1` al principio. La startup probe la espera; la liveness todavía no actúa.

3. Check that the Service has the pod as a backend · Comprobar que el Service tiene al pod como destino:

   ```sh
   kubectl get endpointslices -l kubernetes.io/service-name=web
   ```

## Break it on purpose · Rompelo a propósito

**1. Readiness: the waiter goes on a break · El mozo se toma un descanso**

```sh
POD=$(kubectl get pod -l app=web -o name)
kubectl exec $POD -- rm /usr/share/nginx/html/ready.html
kubectl get pods -l app=web             # READY 0/1, RESTARTS 0
kubectl get endpointslices -l kubernetes.io/service-name=web   # no ready endpoints
kubectl exec $POD -- sh -c 'echo ok > /usr/share/nginx/html/ready.html'
```

**EN** · Predict: does the pod restart? No. It just stops getting traffic until the file is back.
**ES** · Adiviná: ¿se reinicia el pod? No. Solo deja de recibir tráfico hasta que vuelve el archivo.

**2. Liveness: the waiter doesn't answer · El mozo no contesta**

```sh
kubectl exec $POD -- rm /usr/share/nginx/html/index.html
kubectl get pods -l app=web -w          # RESTARTS goes to 1
```

**EN** · The home page now fails, the liveness probe fails twice and Kubernetes restarts the container. The new container comes from the image, with the page back.
**ES** · La página principal ahora falla, la liveness falla dos veces y Kubernetes reinicia el contenedor. El contenedor nuevo sale de la imagen, con la página de nuevo.

**3. Your turn · Te toca:** remove the `startupProbe` and set the liveness `failureThreshold` to 1. What happens during the first 10 seconds? · Sacá la `startupProbe` y poné el `failureThreshold` de la liveness en 1. ¿Qué pasa en los primeros 10 segundos?

## Clean up · Limpiar

```sh
kind delete cluster --name pop-the-hood
```

## What you learned · Qué aprendiste

- EN · Readiness decides **traffic**; liveness decides **restarts**; startup buys **time** to boot.
- EN · A liveness probe that checks something external (a database) can restart all your pods at once when that external thing fails. Keep it about the container itself.
- ES · La readiness decide el **tráfico**; la liveness, los **reinicios**; la startup da **tiempo** para arrancar.
- ES · Una liveness que revisa algo externo (una base de datos) puede reiniciar todos tus pods a la vez cuando eso externo falla. Que mire solo al contenedor.

**Docs:** [Liveness, Readiness and Startup Probes](https://kubernetes.io/docs/concepts/configuration/liveness-readiness-startup-probes/)

## Test · Prueba

`test.sh` checks the three behaviors above. · `test.sh` prueba los tres comportamientos de arriba.
