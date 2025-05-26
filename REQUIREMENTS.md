# Test nivel 2: Prueba Técnica Práctica SRE (Take-Home - Operación de

# Múltiples Aplicaciones en Kubernetes Local)

**Objetivo:**

Evaluar la capacidad del candidato para tomar **un mínimo de dos aplicaciones** existentes
(propias o de ejemplo), prepararlas para ejecución en contenedores, y desplegarlas,
configurar y operar en un entorno de Kubernetes local. La prueba busca demostrar
habilidades en la gestión simultánea de varios servicios, aplicando conceptos de operación
y confiabilidad relevantes para un rol SRE en un entorno contenerizado.

**Aplicaciones de Ejemplo Sugeridas (Utilizar al menos dos de estas, o dos diferentes de
tu elección):**

Puedes utilizar las siguientes dos aplicaciones sencillas como base para la prueba, o elegir
**dos aplicaciones diferentes** de tu propia autoría o de otros repositorios públicos. Si eliges
aplicaciones diferentes, deberán ser **aplicaciones sencillas que expongan un endpoint
HTTP** y deberás proveer acceso a su código fuente.

Ejemplos sugeridos:

1. **Aplicación 1 (Akka HTTP - Scala):** https://github.com/matlux/akka-http-hello-
    world/tree/master
       o Una aplicación simple construida con Scala y Akka HTTP que expone un
          endpoint básico.
2. **Aplicación 2 (Java Webapp - JSP/Servlet):** https://github.com/sbcd90/docker-
    java-sample-webapp/tree/master
       o Una aplicación web Java más tradicional (basada en Servlet/JSP) desplegada
          en Tomcat.

**Entorno Requerido:**

- Debes configurar y utilizar un clúster de Kubernetes local. Puedes usar herramientas
    gratuitas como **Minikube** , **Kind** , o el Kubernetes incluido en **Docker Desktop**.
    Documenta claramente la herramienta utilizada.
- Necesitarás tener Docker instalado.
- Necesitarás las herramientas de construcción necesarias para las aplicaciones que
    elijas (ej. JDK/Maven para Java, sbt para Scala/Akka).

**Tareas:**

Para **cada una de las aplicaciones** que elijas (un mínimo de dos):

1. **Revisión y Contenerización:**
    o Examina el código fuente de la aplicación para entender su funcionamiento
       básico.

o Crea o adapta un Dockerfile para la aplicación, asegurando que se
empaqueta correctamente en una imagen Docker ejecutable. Si la aplicación
ya tiene Dockerfile, revísalo y úsalo.
o Construye la imagen Docker localmente para cada aplicación.
2. **Creación de Manifiestos de Kubernetes con Configuración de Operación**
    **(Enfoque SRE):**
       o Crea los archivos de manifiesto de Kubernetes (.yaml) necesarios para
          desplegar la aplicación en un clúster. Asegúrate de que estos manifiestos
          incluyan las configuraciones relevantes para la operación confiable desde la
          perspectiva SRE. Para cada aplicación, necesitarás al menos:
             § Un **Deployment** para gestionar sus instancias (Pods).
             § Un **Service** (tipo ClusterIP, NodePort, o Ingress si tu entorno local lo
                soporta) para exponerla.
             § Dentro del manifiesto del Deployment, configura especificaciones de
                **Resource Requests y Limits** (CPU y Memoria) para el contenedor.
                Elige valores razonables.
             § También en el manifiesto del Deployment, añade **Liveness Probes** y
                **Readiness Probes** al contenedor. Configura estas probes
                adecuadamente para verificar la salud y disponibilidad de la
                aplicación.
       o Asegúrate de que los nombres de los recursos en Kubernetes sean únicos
          **dentro del mismo namespace** (ej. deployment-app1, service-app2).
3. **Despliegue Inicial y Verificación:**
    o Despliega **ambas aplicaciones** en tu clúster de Kubernetes local utilizando
       sus respectivos manifiestos. **Todas las aplicaciones deben ser desplegadas**
       **en el mismo namespace de Kubernetes.**
    o Verifica que los Pods de **ambas aplicaciones** estén corriendo correctamente.
    o Accede a **cada aplicación** a través de su Service configurado para verificar
       que responden. Confirma que **ambas aplicaciones están activas y**
       **accesibles al mismo tiempo.**
4. **Operación - Despliegue de Nueva Versión:**
    o Simula una "nueva versión" para **al menos una de las aplicaciones**.
    o Realiza un **Rolling Update** de su Deployment en Kubernetes sin causar
       tiempo de inactividad. Verifica que la nueva versión esté activa.
5. **Operación - Rollback:**
    o Después de verificar la nueva versión (en la aplicación que actualizaste),
       realiza un **Rollback** al estado anterior utilizando comandos de Kubernetes.
       Verifica que la versión previa esté funcionando nuevamente.
6. **Observabilidad (Logging):**
    o Asegúrate de que **ambas aplicaciones** impriman logs relevantes en su salida
       estándar.
    o Muestra cómo ver los logs de los Pods de **cada aplicación** usando
       comandos de Kubernetes, especificando el namespace.

**Entregables:**


Debes proporcionar un único punto de acceso a tu trabajo, idealmente un **repositorio
público en GitHub o en su defecto un archivo comprimido**. Este repositorio debe
contener:

1. **Carpeta(s) de Aplicación(es) con Código Fuente, Dockerfile y Documentación**
    **Específica:** Incluye una carpeta en la raíz del repositorio por cada aplicación
    utilizada (ej. /app1, /app2, etc.). Dentro de cada una de estas carpetas (/appX),
    debes incluir:
       o **El Dockerfile final** utilizado para construir la imagen Docker de esa
          aplicación.
       o Un archivo **README.md específico para esta aplicación.** Este README
          debe contener:
             § Una breve descripción de la aplicación: ¿qué hace (ej. "servicio
                Hello World"), qué tecnología usa (Java/Akka, Java/Tomcat, etc.)?
             § Instrucciones o detalles necesarios para construir la imagen Docker
                local utilizando el Dockerfile y el código fuente **incluidos en esta**
                **carpeta o** un **enlace al repositorio publico**. Si es código propio no
                público, menciónalo.
       o El **código fuente completo de esa aplicación si no es un repositorio**
          **público** , tal cual lo utilizaste para la prueba. Si el código fuente original **no**
          proviene de un repositorio público (como los ejemplos sugeridos), asegúrate
          de incluirlo aquí.
2. **Manifiestos de Kubernetes:** Los archivos yaml (Deployment, Service, etc.)
    creados para desplegar **cada una de las aplicaciones** , organizados de forma clara
    en una carpeta separada (ej. /kubernetes/app1, /kubernetes/app2). Asegúrate
    de que estos manifiestos especifiquen el mismo namespace.
3. **Documentación General del Proyecto (README Principal):** Un archivo
    **README.md** en la **raíz del repositorio** que actúe como la documentación principal
    del proyecto de la prueba. Este README debe incluir:
       o La herramienta de Kubernetes local utilizada y cómo iniciar el clúster.
       o Instrucciones paso a paso para construir las imágenes Docker (si aplica) y
          desplegar **ambas aplicaciones** en el clúster local, **indicando el namespace**
          **utilizado**.
       o Explicación breve de los manifiestos de K8s para **cada aplicación** ,
          refiriéndote a los archivos en la carpeta /kubernetes.
       o **Demostración del Despliegue Inicial y Verificación:** Describe los
          comandos utilizados en la **Tarea 3 (Despliegue Inicial y Verificación)**
          para ambas aplicaciones, verificar que sus Pods están corriendo y que
          son accesibles. Incluye **capturas de pantalla** que muestren la salida
          de los comandos claves.
       o **Demostración de las Tareas de Operación (Rolling Update y Rollback):**
          Describe los comandos utilizados en las **Tareas 4 (Despliegue Nueva**
          **Versión)** y **5 (Rollback)** para realizar el Rolling Update y el Rollback.
          Incluye **capturas de pantalla** que muestren la salida de los comandos
          claves.
o Demostración de Logging: Describe los comandos utilizados en la Tarea 6
(Observabilidad - Logging) para ver los logs de cada aplicación. Incluye
capturas de pantalla que muestren la salida de los comandos relevantes.
o Instrucciones claras sobre cómo detener y limpiar el entorno de
Kubernetes local y cualquier recurso creado.

**Evaluación:**

Tu solución será evaluada en base a:

- **Funcionalidad y Despliegue:** ¿Ambas aplicaciones se containerizan y despliegan
    correctamente en Kubernetes, **en el mismo namespace**?
- **Conocimiento de Kubernetes:** ¿Se utilizan los recursos de K8s apropiados
    (Deployment, Service, Probes, Resources) para gestionar múltiples servicios? ¿Los
    manifiestos son correctos, bien organizados y especifican el namespace
    correctamente?
- **Habilidades Operativas (SRE):** ¿Se configuran adecuadamente los
    Requests/Limits y Probes para cada aplicación? ¿Se demuestran correctamente los
    procesos de Rolling Update y Rollback? ¿Se verifica el estado y los logs de forma
    efectiva para ambos servicios, **considerando el namespace**?
- **Gestión de Múltiples Servicios en Namespace Compartido:** ¿Demuestras
    capacidad para gestionar y desplegar más de un servicio en el mismo namespace,
    asegurando su correcta configuración y accesibilidad simultánea?
- **Documentación:** ¿La documentación es clara, precisa y completa, permitiendo a
    alguien más replicar el entorno y los pasos para ambas aplicaciones, incluyendo el
    uso del namespace y la demostración con capturas?
- **Buenas Prácticas:** ¿Se siguen buenas prácticas básicas de contenerización y
    configuración de K8s?


