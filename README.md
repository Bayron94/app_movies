# Aplicación de Películas

Esta es una aplicación de películas desarrollada en Flutter que permite a los usuarios ver una lista de películas populares y sus detalles, con opciones de filtrado por género y puntuación. La aplicación consume la API de [The Movie Database (TMDB)](https://www.themoviedb.org/) para obtener la información de las películas.

## Desarrollador

- **Nombre**: Bayron Ordoñez

## Características

- **Lista de Películas Populares**: Muestra un listado de películas populares obtenidas de la API de TMDB.
- **Filtros**:
  - Filtrar por **Puntuación Mínima**: Muestra solo películas con una puntuación mínima seleccionada.
- **Detalles de Película**: Al seleccionar una película, muestra detalles adicionales como sinopsis, reparto y puntuación.
- **Abrir Más Información en la Web**: Incluye un botón para realizar una búsqueda en Google de la película seleccionada.

## Requisitos de Configuración

1. **Archivo de Variables de Entorno (`.env`)**

   Para que la aplicación funcione correctamente, se debe crear un archivo `.env` en la raíz del proyecto con la siguiente variable:

   ```plaintext
   API_KEY_TMDB=<TU_API_KEY_AQUI>
