# Pop the hood · Abrí el capó

**EN** · DevOps, SRE, observability, security, architecture, AI and tech in general, explained with everyday analogies and a hands-on lab you can run on your own machine. Pop the hood, break things on purpose, see how they work.

**ES** · DevOps, SRE, observabilidad, seguridad, arquitectura, IA y tecnología en general, explicados con analogías de la vida diaria y un laboratorio para correr en tu máquina. Abrí el capó, rompé cosas a propósito y mirá cómo funcionan.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/jar3/pop-the-hood)

## Labs · Laboratorios

| # | Lab · Laboratorio | Topic · Tema | Level · Nivel | Time · Tiempo | Post |
|---|---|---|---|---|---|
| 01 | [Probes: liveness, readiness and startup · Probes: liveness, readiness y startup](labs/01-probes) | Kubernetes | beginner · inicial | ~15 min | — |

Every lab follows the same structure (see [`labs/_template`](labs/_template)): the analogy, what you'll learn, the steps, how to break it on purpose, how to clean up and what you learned.

Todos los laboratorios siguen la misma estructura (ver [`labs/_template`](labs/_template)): la analogía, qué vas a aprender, los pasos, cómo romperlo a propósito, cómo limpiar y qué aprendiste.

## Before you start · Antes de arrancar

**EN**

- **Docker** running (Docker Engine or Docker Desktop).
- **[mise](https://mise.jdx.dev)**, which installs the right version of every tool, only for this repo.
- **Memory:** an empty single-node cluster uses about 600 MB of RAM. Keep at least 2 GB free.
- **No install at all?** Open it in GitHub Codespaces with the button above: everything is ready in the browser.

**ES**

- **Docker** andando (Docker Engine o Docker Desktop).
- **[mise](https://mise.jdx.dev)**, que instala la versión justa de cada herramienta, solo para este repo.
- **Memoria:** un cluster vacío de un nodo usa unos 600 MB de RAM. Dejá al menos 2 GB libres.
- **¿Sin instalar nada?** Abrilo en GitHub Codespaces con el botón de arriba: queda todo listo en el navegador.

## Getting started · Para arrancar

```sh
git clone https://github.com/jar3/pop-the-hood.git
cd pop-the-hood
mise trust && mise install
```

- **kind**: Kubernetes clusters inside Docker · clusters de Kubernetes adentro de Docker.
- **kubectl**: same version as the clusters · la misma versión que los clusters.
- **helm**: package manager for Kubernetes · gestor de paquetes de Kubernetes.
- **gitleaks**: secret scanner · escáner de secretos.

Test clusters store their access in `~/.kube/pop-the-hood-config`, outside the repo, so they never mix with your other kubeconfig. Los clusters de prueba guardan su acceso en `~/.kube/pop-the-hood-config`, fuera del repo, y no se mezclan con tu otro kubeconfig.

To check that every lab still works · Para comprobar que todos los laboratorios andan:

```sh
mise exec -- scripts/test-labs.sh              # all labs · todos
mise exec -- scripts/test-labs.sh labs/01-...  # one lab · uno solo
```

The same check runs on GitHub Actions on every change. La misma prueba corre en GitHub Actions con cada cambio.

## Found a broken lab? · ¿Un laboratorio no anda?

[Open an issue](../../issues/new/choose) with the lab, the step and the error. [Abrí un issue](../../issues/new/choose) con el laboratorio, el paso y el error.

## Contributing · Para contribuir

Enable the secret scanner before your first commit: it blocks the commit if it finds a password or a token. Activá el escáner de secretos antes del primer commit: frena el commit si encuentra una contraseña o un token.

```sh
git config core.hooksPath .githooks
```

## Disclaimer · Aviso

**EN** · These labs are for learning. They run on a local test cluster and are not meant for production: don't copy them into a real cluster without reviewing them.

**ES** · Estos laboratorios son para aprender. Corren en un cluster de prueba local y no están pensados para producción: no los copies a un cluster real sin revisarlos.

## About · Sobre mí

Made by **Jorge Riveros (aka Jar)**, SRE/DevOps engineer. Hecho por **Jorge Riveros (aka Jar)**, SRE/DevOps.

[LinkedIn](https://www.linkedin.com/in/riverosjorge/) · [GitHub](https://github.com/jar3)

## License · Licencia

- **Code** (manifests, scripts) · **Código** (manifiestos, scripts): [MIT](LICENSE).
- **Text and images** · **Textos e imágenes**: [CC BY 4.0](LICENSE-CONTENT.md).
